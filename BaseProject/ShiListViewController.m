//
//  ShiListViewController.m
//  BaseProject
//
//  Created by jiyingxin on 15/10/29.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "ShiListViewController.h"
#import "PoetryViewModel.h"
#import "FirstViewController.h"
#import "ViewController.h"



@implementation PoetryCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:reuseIdentifier]) {
    }
    return self;
}
@end

#import "PoetryDetailViewController.h"

@interface ShiListViewController ()<UITableViewDelegate, UITableViewDataSource>
@property(nonatomic,strong) UITableView *tableView;
@property(nonatomic,strong) PoetryViewModel *poetryVM;
@property (nonatomic,strong)NSMutableArray *titleArr;

@end
@implementation ShiListViewController
-(NSMutableArray *)titleArr{
    if (!_titleArr) {
        _titleArr = [NSMutableArray array];
    }
    return _titleArr;
}
- (id)initWithKind:(NSString *)kind{
    if (self = [super init]) {
        _kind = kind;
    }
    return self;
}
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView=[[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [UIView new];
        [_tableView registerClass:[PoetryCell class] forCellReuseIdentifier:@"Cell"];
    }
    return _tableView;
}
- (PoetryViewModel *)poetryVM{
    if (!_poetryVM) {
        _poetryVM=[[PoetryViewModel alloc] initWithKind:_kind];
    }
    return _poetryVM;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    [self.view addSubview:self.tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
    self.title = _kind;
    
}
#pragma mark - UITableView
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewCellEditingStyleDelete;
}
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    return @"删除此诗";
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle == 1) {
        [[UIAlertView bk_showAlertViewWithTitle:[self.poetryVM titleForRow:indexPath.row] message:@"确认要删除此诗吗？此操作不可恢复!!" cancelButtonTitle:@"点错了" otherButtonTitles:@[@"心意已决"] handler:^(UIAlertView *alertView, NSInteger buttonIndex) {
            if (buttonIndex == 1) {
                if ([self.poetryVM removePoetryForRow:indexPath.row]) {
                    [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
                }
            }
        }] show];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.poetryVM.rowNumber;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    cell.textLabel.text = [self.poetryVM titleForRow:indexPath.row];
    cell.detailTextLabel.text = [self.poetryVM authorForRow:indexPath.row];
    cell.accessoryType = 1; //→
    return cell;
}
kRemoveCellSeparator
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSInteger num = 0;
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
       num+=1;
    
    PoetryDetailViewController *vc=[[PoetryDetailViewController alloc] initWithShi:[self.poetryVM shiForRow:indexPath.row] intro:[self.poetryVM shiIntroForRow:indexPath.row]];
   

    vc.shiTitle = [self.poetryVM titleForRow:indexPath.row];
    

//    NSUserDefaults *plist = [NSUserDefaults standardUserDefaults];
//    [plist setInteger:self.titleArr.count forKey:@"readNum"];
//   
//    [plist synchronize];

    
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
