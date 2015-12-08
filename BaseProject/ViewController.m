//
//  ViewController.m
//  BaseProject
//
//  Created by jiyingxin on 15/10/22.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "ViewController.h"
#import "KindViewModel.h"
#import "KindIntroViewController.h"
#import "ShiListViewController.h"
#import "SearchPoetryViewModel.h"
#import "PoetryDetailViewController.h"
#import "FirstViewController.h"
@interface ViewController ()<UITableViewDelegate,UITableViewDataSource, UISearchBarDelegate>
@property(nonatomic,strong) SearchPoetryViewModel *searchPoetryVM;
@property(nonatomic,strong) KindViewModel *kindVM;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end
@implementation ViewController
- (SearchPoetryViewModel *)searchPoetryVM{
    if (!_searchPoetryVM) {
        _searchPoetryVM = [SearchPoetryViewModel new];
    }
    return _searchPoetryVM;
    
}

- (KindViewModel *)kindVM{
    if (!_kindVM) {
        _kindVM = [KindViewModel new];
    }
    return _kindVM;
}
#pragma mark - UITableView
//某行是否支持编辑状态
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
//搜索列表table不支持编辑状态
    return tableView == _tableView;
}
//某行的编辑状态是哪一种
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewCellEditingStyleDelete;
}
//删除状态的文字是什么
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    return @"删除此诗集";
}
//当编辑操作被触发后，做什么
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [[UIAlertView bk_showAlertViewWithTitle:[self.kindVM titleForRow:indexPath.row] message:@"确认要删除此诗集吗?这个操作无法恢复!" cancelButtonTitle:@"点错了" otherButtonTitles:@[@"心意已决"] handler:^(UIAlertView *alertView, NSInteger buttonIndex) {
            if (buttonIndex == 1) { //确定按钮
                if ([self.kindVM removeKindForRow:indexPath.row]) {
                    [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
                }
            }
        }] show];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectionP{
    return _tableView==tableView?self.kindVM.rowNumber:self.searchPoetryVM.rowNumber;
}
kRemoveCellSeparator
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (_tableView != tableView) {
//如果是搜索界面
        cell.textLabel.text =[self.searchPoetryVM titleForRow:indexPath.row];
        cell.detailTextLabel.text = [self.searchPoetryVM authorForRow:indexPath.row];
        return cell;
    }
    UILabel *titleLb = (UILabel *)[cell.contentView viewWithTag:100];
    titleLb.text = [self.kindVM titleForRow:indexPath.row];
    UIButton *btn = (UIButton *)[cell.contentView viewWithTag:200];
    btn.hidden = ![self.kindVM hasDetailForRow:indexPath.row];
    btn.layer.cornerRadius = 10;
//为了防止cell重用，导致多次给按钮添加点击监听操作
    [btn bk_removeEventHandlersForControlEvents:UIControlEventTouchUpInside];
    
    [btn bk_addEventHandler:^(id sender) {
        
        KindIntroViewController *vc = [KindIntroViewController new];
        vc.introKind = [self.kindVM detailForRow:indexPath.row];
        [self.navigationController pushViewController:vc animated:YES];
        vc.title = titleLb.text;
        
    } forControlEvents:UIControlEventTouchUpInside];
    
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (tableView != _tableView) {
        PoetryDetailViewController *vc = [[PoetryDetailViewController alloc] initWithShi:[self.searchPoetryVM shiForRow:indexPath.row] intro:[self.searchPoetryVM shiIntroForRow:indexPath.row]];
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }
    ShiListViewController *vc=[[ShiListViewController alloc] initWithKind:[self.kindVM titleForRow:indexPath.row]];
    
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _tableView.tableFooterView = [UIView new];
//向搜索列表中注册cell
    [self.searchDisplayController.searchResultsTableView registerClass:[PoetryCell class] forCellReuseIdentifier:@"Cell"];
    [self addBackItemToVC];
}

/**
 *  导航栏中添加按钮
 */
-(void)addBackItemToVC{
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:[UIImage imageNamed:@"btn_back_n1"] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:@"btn_back_h1"] forState:UIControlStateHighlighted];
    btn.frame = CGRectMake(0, 0, 45, 44);
    [btn bk_addEventHandler:^(id sender) {
        
//        FirstViewController *vc= [self.storyboard instantiateViewControllerWithIdentifier:@"FirstViewController"];
      
        [self dismissModalViewControllerAnimated:YES];
        
    } forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *menueItem = [[UIBarButtonItem alloc]initWithCustomView:btn];
    //使用弹簧控件缩小菜单按钮边缘距离
    UIBarButtonItem *spaceItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    spaceItem.width = -16;
    self.navigationItem.leftBarButtonItems = @[spaceItem,menueItem];
    
    
}


#pragma mark - UISearchBar
//搜索栏内容有更改时触发
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    self.searchPoetryVM.searchStr = searchText;
    [self.searchDisplayController.searchResultsTableView reloadData];
}



@end
