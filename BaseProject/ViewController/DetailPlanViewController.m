//
//  DetailPlanViewController.m
//  BaseProject
//
//  Created by ios－23 on 15/11/15.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "DetailPlanViewController.h"
#import "UserModel.h"
#import "UserPlan.h"
@interface DetailPlanViewController ()
@property (nonatomic,strong)UILabel *planMainLb;
@property (nonatomic,strong)UILabel *palnContentLb;

@property (nonatomic,strong)UIImageView *imageView;



@end

@implementation DetailPlanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.navigationController.navigationBar.translucent = YES;
    
    self.imageView.image = [UIImage imageNamed:@"8"];
    
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor whiteColor];
    view.alpha = 0.7;
    [self.imageView addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
    
    [view addSubview:self.planMainLb];
    
   
    
    [_planMainLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(30);
        make.right.mas_equalTo(-30);
        make.top.mas_equalTo(100);
    }];
    
    [view addSubview:self.palnContentLb];
    [_palnContentLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(30);
        make.right.mas_equalTo(-30);
        make.top.mas_equalTo(self.planMainLb.mas_bottom).mas_equalTo(40);
        make.bottom.mas_lessThanOrEqualTo(-30);
    }];

    
    NSArray *arr = [UserPlan PlanWithusername:[UserModel nameWithOnline] PlanMain:self.planmain];
    UserPlan *plan = arr[0];
    
    self.planMainLb.textColor = [UIColor blackColor];
    self.planMainLb.text =plan.planmain;
    self.palnContentLb.textColor = [UIColor blackColor];
    self.palnContentLb.numberOfLines = 0;
    self.palnContentLb.text = plan.plancontent;
   
    
    [self addBack];
}

- (void)addBack{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:[UIImage imageNamed:@"btn_back_n"] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:@"btn_back_h"] forState:UIControlStateHighlighted];
    btn.frame = CGRectMake(0, 0, 45, 44);
    [btn bk_addEventHandler:^(id sender) {
        [self.navigationController popViewControllerAnimated:YES];
    } forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *menuItem=[[UIBarButtonItem alloc] initWithCustomView:btn];
    //使用弹簧控件缩小菜单按钮和边缘距离
    UIBarButtonItem *spaceItem=[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    spaceItem.width = -16;
    self.navigationItem.leftBarButtonItems = @[spaceItem,menuItem];
}


- (UILabel *)planMainLb {
	if(_planMainLb == nil) {
		_planMainLb = [[UILabel alloc] init];
        _planMainLb.textColor = [UIColor whiteColor];
        _planMainLb.font = [UIFont systemFontOfSize:25];
        _planMainLb.textAlignment = NSTextAlignmentCenter;

	}
	return _planMainLb;
}

- (UILabel *)palnContentLb {
	if(_palnContentLb == nil) {
        _palnContentLb.textColor = [UIColor whiteColor];
        _palnContentLb.font = [UIFont systemFontOfSize:20];
		_palnContentLb = [[UILabel alloc] init];

        _palnContentLb.textAlignment = NSTextAlignmentCenter;
	}
	return _palnContentLb;
}

- (UIImageView *)imageView {
	if(_imageView == nil) {
		_imageView = [[UIImageView alloc] init];
        [self.view addSubview:_imageView];
        [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(0);
        }];
	}
	return _imageView;
}

@end
