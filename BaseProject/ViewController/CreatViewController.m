//
//  CreatViewController.m
//  BaseProject
//
//  Created by ios－21 on 15/11/16.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "CreatViewController.h"
#import "UserPlan.h"
#import "UserModel.h"


@interface CreatViewController ()
@property(nonatomic,strong)UITextField *planTitle;
@property(nonatomic,strong)UITextView *planView;
@property (nonatomic,strong)FUIButton *rember;

@end

@implementation CreatViewController


-(instancetype)init{
    if (self = [super init]) {
        self.title = @"制定计划";
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.planTitle.hidden = NO;
    self.planView.hidden = NO;
    [self.view addSubview:self.rember];
    [self.rember mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0);
        make.bottom.mas_equalTo(-70);
        make.left.mas_equalTo(40);
        make.right.mas_equalTo(-40);
    }];
    
}

- (UITextField *)planTitle {
	if(_planTitle == nil) {
		_planTitle = [[UITextField alloc] init];
        _planTitle.backgroundColor = [UIColor  lightGrayColor];
        _planTitle.placeholder = @"请输入计划标题";
        [self.view addSubview:_planTitle];
        
        [_planTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(80);
            make.left.mas_equalTo(40);
//            make.width.mas_equalTo(100);
            make.right.mas_equalTo(-40);
            make.height.mas_equalTo(40);
        }];
	}
	return _planTitle;
}

- (UITextView *)planView {
	if(_planView == nil) {
		_planView = [[UITextView alloc] init];
        _planView.backgroundColor = [UIColor lightGrayColor];
//        _planView.
        [self.view addSubview:_planView];
        [_planView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(20);
            make.right.mas_equalTo(-20);
            make.top.mas_equalTo(150);
            make.bottom.mas_equalTo(-100);
            
        }];
	}
	return _planView;
}

- (FUIButton *)rember {
    if(_rember == nil) {
        _rember = [[FUIButton alloc] init];
        
        _rember.shadowColor = [UIColor greenSeaColor];
        _rember.buttonColor = [UIColor turquoiseColor];
        _rember.shadowHeight = 3.0f;
        _rember.cornerRadius = 6.0f;
        
        [_rember setTitle:@"保存计划" forState:UIControlStateNormal];
        _rember.titleLabel.font = [UIFont boldFlatFontOfSize:20];
        
        [_rember setTitleColor:[UIColor cloudsColor] forState:UIControlStateNormal];
        
        [_rember setTitleColor:[UIColor cloudsColor] forState:UIControlStateHighlighted];
        
        [_rember bk_addEventHandler:^(id sender) {
            
            if (![UserPlan exitPlanWithusername:[UserModel nameWithOnline] PlanMain:self.planTitle.text]) {
                
                [UserPlan insertPlanWithusername:[UserModel nameWithOnline] planMain:self.planTitle.text planContent:self.planView.text];
            }
            

            
        } forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _rember;
}

@end
