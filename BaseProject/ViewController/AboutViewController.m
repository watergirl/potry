//
//  AboutViewController.m
//  BaseProject
//
//  Created by ios－23 on 15/11/13.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "AboutViewController.h"

@interface AboutViewController ()
@property (nonatomic,strong)UILabel *contentLb;
@end

@implementation AboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"诗集词曲大宝";
    self.contentLb.text = @"  诗集词曲大全是一个超级方便的手机客户端，通过注册并登陆,便能够在这里轻松查找你所需要的诗词，可以查找诗词注解及评析，还可以查找诗词详情。记录曾经背诵过的诗词及所有诗词，另外你还可以在侧边栏实现查找曾经收藏过的诗更换头像的功能。方便同学全班同学课后互动问答互相学习共同进步。";

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

- (UILabel *)contentLb {
	if(_contentLb == nil) {
		_contentLb = [[UILabel alloc] init];
        _contentLb.numberOfLines = 0;
        [self.view addSubview:_contentLb];
        [_contentLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.right.mas_equalTo(-10);
            make.top.mas_equalTo(64);
        }];
        
	}
	return _contentLb;
}

@end
