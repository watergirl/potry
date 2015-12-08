//
//  RemberDetailViewController.m
//  BaseProject
//
//  Created by ios－23 on 15/11/12.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "RemberDetailViewController.h"
#import "SearchPoetryViewModel.h"
@interface PoetryremberCell : UITableViewCell
@property (nonatomic,strong)UILabel *label;

@end
@implementation PoetryremberCell

-(UILabel *)label{
    if (!_label) {
        _label = [UILabel new];
        _label.textAlignment = NSTextAlignmentCenter;
        _label.textColor = [UIColor blackColor];
        _label.numberOfLines = 0;
        [self.contentView addSubview:_label];
        [_label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.mas_equalTo(10);
            make.right.bottom.mas_equalTo(-10);
        }];
    }
    return _label;
}
@end

@interface RemberDetailViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong)NSString *shi;
@end

@implementation RemberDetailViewController
-(id)initWithTitle:(NSString *)title{
    if (self = [super init]) {
        _shititle = title;
    }
    return self;
}
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView=[UIView new];
        _tableView.allowsSelection = NO;
        _tableView.tableFooterView = [UIView new];
        [_tableView registerClass:[PoetryremberCell class] forCellReuseIdentifier:@"Cell"];
        [self.view addSubview:_tableView];
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(0);
            
        }];
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [Factory addBackItemToVC:self];
   self.shi = [SearchPoetryViewModel  shiwithTitle:self.shititle];
    [self.tableView reloadData];
}
#pragma mark - UITableView
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return @[@"题目", @"诗词赏析"][section];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

     PoetryremberCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (indexPath.section==0) {
        cell.label.text = self.shititle;
        
    }else{
        cell.label.text = self.shi;
        
    }
    
    return cell;
        
}
-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewAutomaticDimension;
}

@end
