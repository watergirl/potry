//
//  MyplainView.m
//  BaseProject
//
//  Created by ios－21 on 15/11/16.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "MyplainView.h"
#import "UserPlan.h"
#import "UserModel.h"
#import "DetailPlanViewController.h"
@interface MyplainView ()

@end

@implementation MyplainView
- (instancetype)init
{
    self = [super init];
    if (self) {
    
        self.title = @"我的计划";
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
        self.view.backgroundColor = [UIColor whiteColor];
    
    self.title = @"我的计划";
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return [UserPlan planWithuserName:[UserModel nameWithOnline]].count;;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    UserPlan *plan = [UserPlan planWithuserName:[UserModel nameWithOnline]][indexPath.row];
    
    cell.textLabel.text = plan.planmain;

    cell.accessoryType =  UITableViewCellAccessoryDisclosureIndicator;
    cell.backgroundColor = [UIColor clearColor];
    cell.contentView.backgroundColor = [UIColor clearColor];
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    UserPlan *plan = [UserPlan planWithuserName:[UserModel nameWithOnline]][indexPath.row];
    DetailPlanViewController *vc = [DetailPlanViewController new];
    
    vc.planmain = plan.planmain;
    vc.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController pushViewController:vc animated:YES ];



}





#pragma mark - UITableView
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewCellEditingStyleDelete;
}
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    return @"删除此计划";
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle == 1) {
        UserPlan *plan = [UserPlan planWithuserName:[UserModel nameWithOnline]][indexPath.row];
        [[UIAlertView bk_showAlertViewWithTitle:plan.planmain message:@"确认要删除此计划吗？此操作不可恢复!!" cancelButtonTitle:@"点错了" otherButtonTitles:@[@"心意已决"] handler:^(UIAlertView *alertView, NSInteger buttonIndex) {
            if (buttonIndex == 1) {
                UserPlan *plan = [UserPlan planWithuserName:[UserModel nameWithOnline]][indexPath.row];
                [UserPlan deletatePlanWithusername:[UserModel nameWithOnline] PlanMain:plan.planmain];
                
                [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
                
            }
        }] show];
    }
}







@end
