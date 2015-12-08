//
//  RemberShiViewController.m
//  BaseProject
//
//  Created by ios－23 on 15/11/11.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "RemberShiViewController.h"
#import "UserShi.h"
#import "UserModel.h"
#import "RemberDetailViewController.h"
@interface PoetryDetailCellx:UITableViewCell
@property(nonatomic, strong) UILabel *label;
@end
@implementation PoetryDetailCellx
- (UILabel *)label{
    if (!_label) {
        _label = [UILabel new];
        _label.font = [UIFont systemFontOfSize:18];
        //自动换行
        _label.numberOfLines = 0;
        _label.textColor = [UIColor whiteColor];
        [self.contentView addSubview:_label];
        [_label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.centerY.mas_equalTo(0);
        }];
    }
    return _label;
}


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor clearColor];
        self.contentView.backgroundColor = [UIColor clearColor];
//        self.accessoryType =  UITableViewCellAccessoryDisclosureIndicator;
        
    }
    return self;
}


@end


@interface RemberShiViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)UITableView *tableView;

@end

@implementation RemberShiViewController
- (UITableView *)tableView {
    if(_tableView == nil) {
        _tableView = [[UITableView alloc] init];
        _tableView.backgroundColor = [UIColor clearColor];
        [self.view addSubview:_tableView];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
       
        [_tableView registerClass:[PoetryDetailCellx class] forCellReuseIdentifier:@"Cell"];
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(0);
            
        }];
        _tableView.tableFooterView = [UIView new];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"我的收藏";
    self.navigationController.navigationBar.translucent = NO;

    self.view.backgroundColor  = [UIColor redColor];
    UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"4"]];
    [self.view addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
    
    [self.tableView reloadData];
    
    [self addBack];
}

- (void)addBack{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:[UIImage imageNamed:@"btn_back_n"] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:@"btn_back_h"] forState:UIControlStateHighlighted];
    btn.frame = CGRectMake(0, 0, 45, 44);
    [btn bk_addEventHandler:^(id sender) {
        [self.navigationController dismissModalViewControllerAnimated:YES];
    } forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *menuItem=[[UIBarButtonItem alloc] initWithCustomView:btn];
    //使用弹簧控件缩小菜单按钮和边缘距离
    UIBarButtonItem *spaceItem=[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    spaceItem.width = -16;
    self.navigationItem.leftBarButtonItems = @[spaceItem,menuItem];
}






-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [UserShi shiWithuserName:[UserModel nameWithOnline]].count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    PoetryDetailCellx *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
   
    cell.backgroundColor = [UIColor clearColor];
    cell.contentView.backgroundColor = [UIColor clearColor];
    
    UserShi *us =[UserShi shiWithuserName:[UserModel nameWithOnline]][indexPath.row];
    cell.label.text = us.title;
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewAutomaticDimension;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    UserShi *us =[UserShi shiWithuserName:[UserModel nameWithOnline]][indexPath.row];
   
    RemberDetailViewController *vc=  [[RemberDetailViewController alloc]initWithTitle:us.title];
    [self.navigationController pushViewController:vc animated:YES];
}



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
        UserShi *us =[UserShi shiWithuserName:[UserModel nameWithOnline]][indexPath.row];
        [[UIAlertView bk_showAlertViewWithTitle:us.title message:@"确认要删除此诗吗？此操作不可恢复!!" cancelButtonTitle:@"点错了" otherButtonTitles:@[@"心意已决"] handler:^(UIAlertView *alertView, NSInteger buttonIndex) {
            if (buttonIndex == 1) {
                [UserShi removeRemberWithUsername:[UserModel nameWithOnline] shi:us.title];
                [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
                
            }
        }] show];
    }
}

@end
