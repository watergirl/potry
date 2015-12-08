//
//  MyPlaytabBarcontroller.m
//  BaseProject
//
//  Created by ios－21 on 15/11/15.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "MyPlaytabBarcontroller.h"
#import "CreatViewController.h"
#import "MyplainView.h"

@interface MyPlaytabBarcontroller ()


@end

@implementation MyPlaytabBarcontroller


+(MyPlaytabBarcontroller *)standardInstance{
    static MyPlaytabBarcontroller *vc = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        vc = [MyPlaytabBarcontroller new];
  
    });
    return vc;
    

}



- (void)viewDidLoad {
    [super viewDidLoad];
 
    [self addBack];
   
    CreatViewController *cvc = [CreatViewController new];
    
    MyplainView *myvc = [MyplainView new];
    UINavigationController *cvcNavi =[[UINavigationController alloc]initWithRootViewController:cvc];
    UINavigationController *myvcNavi = [[UINavigationController alloc]initWithRootViewController:myvc];
    
    self.viewControllers = @[cvcNavi,myvcNavi];

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
