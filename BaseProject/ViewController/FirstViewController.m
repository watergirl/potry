//
//  FirstViewController.m
//  BaseProject
//
//  Created by ios－23 on 15/11/6.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "FirstViewController.h"
#import "PoetryModel.h"
#import "UserModel.h"
#import "UserShi.h"
#import "UMSocial.h"
@interface FirstViewController ()
@property (nonatomic,strong)FUIButton *rember;

@property (weak, nonatomic) IBOutlet UIView *writView;

@property (weak, nonatomic) IBOutlet UIButton *sharHeart;
@property (weak, nonatomic) IBOutlet UILabel *remberdNum;
@property (nonatomic,strong)NSMutableArray *remberArr;
@end

@implementation FirstViewController
- (FUIButton *)rember {
    if(_rember == nil) {
        _rember = [[FUIButton alloc] init];
        
        _rember.shadowColor = [UIColor greenSeaColor];
        _rember.buttonColor = [UIColor turquoiseColor];
        _rember.shadowHeight = 3.0f;
        _rember.cornerRadius = 6.0f;
        
        [_rember setTitle:@"我要背诗词" forState:UIControlStateNormal];
        _rember.titleLabel.font = [UIFont boldFlatFontOfSize:30];
        [_rember setTitleColor:[UIColor cloudsColor] forState:UIControlStateNormal];
        [_rember setTitleColor:[UIColor cloudsColor] forState:UIControlStateHighlighted];
        
        [_rember bk_addEventHandler:^(id sender) {
            
            UINavigationController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"na"];
            
            [self presentViewController:vc animated:YES completion:nil];
            

            
        } forControlEvents:UIControlEventTouchUpInside];
    }
    
    
    
    return _rember;
}
- (void)viewDidLoad {
    [super viewDidLoad];
   
      //导航栏样式
    [self configGlobalUIStyle];


    self.remberdNum.font = [UIFont boldFlatFontOfSize:26];
    self.titleLable.font = [UIFont boldFlatFontOfSize:26];
    self.titleLable.textColor = [UIColor blackColor];
    self.titleLable.text = [NSString stringWithFormat:@"今天已读诗词0首"];

    //闪光区域,所有在闪光区域内的空间都会闪
    FBShimmeringView *sv = [FBShimmeringView new];
    [self.writView addSubview:sv];
    [sv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0);
        make.top.mas_equalTo(self.writView.mas_top).mas_equalTo(20);
        make.size.mas_equalTo(CGSizeMake(220, 80));
    }];
    //把 label 放入闪光区域
    //必须这样写,
    sv.contentView = self.titleLable;
   
    FBShimmeringView *sv2 = [FBShimmeringView new];
    [self.writView addSubview:sv2];
    [sv2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0);
        make.top.mas_equalTo(self.writView.mas_top).mas_equalTo(80);
        make.size.mas_equalTo(CGSizeMake(220, 80));
    }];
    sv2.contentView = self.remberdNum;
    
    sv.contentView = self.titleLable;
    sv.shimmering = YES;
    sv2.shimmering = YES;
    //添加开始背诵按钮
    [self.view addSubview:self.rember];
    [self.rember mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0);
        make.bottom.mas_equalTo(-130);
        
    }];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    
    
     [super viewWillAppear:animated];
   
    self.title = [UserModel nameWithOnline];

    NSArray *read = [PoetryModel poetryListWithAll];
   
    self.titleLable.text = [NSString stringWithFormat:@"共有诗词%ld首",read.count];
     
    NSArray *arr = [UserShi shiWithuserName:[UserModel nameWithOnline]];
    self.remberdNum.text =[NSString stringWithFormat:@"已经背了%ld首",arr.count];
    [self addMenuItem];
}

-(void)addMenuItem{
    
     FUIButton *btn = [FUIButton buttonWithType:0];
   
    NSString *docPath=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
   NSString *path=[docPath stringByAppendingPathComponent:@"images"];
    NSString *filePath=[path stringByAppendingPathComponent:@"image"];
    UIImage *exitimage=[UIImage imageWithContentsOfFile:filePath];
   
    if (exitimage) {
 
        [btn setBackgroundImage:exitimage forState:UIControlStateNormal];
      [btn setBackgroundImage:exitimage forState:UIControlStateHighlighted];
    }else{
  
        [btn setBackgroundImage:[UIImage imageNamed:@"coolStart_retired_n"] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageNamed:@"coolStart_retired_s"] forState:UIControlStateHighlighted];
    }
    //将按钮设成圆形,但形状并不变,要结合下一句使用
    btn.layer.cornerRadius = 22;
    //将按钮切成圆形
    btn.clipsToBounds = YES;
    
    btn.frame = CGRectMake(0, 0, 44, 44);
    
    [btn bk_addEventHandler:^(id sender) {
        
        [self.sideMenuViewController presentLeftMenuViewController];
    } forControlEvents:UIControlEventTouchUpInside];
  
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:btn];

}



/** 配置全局UI的样式 */
- (void)configGlobalUIStyle{
   
    /** 设置导航栏背景图 */
    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"navigationbar_bg_64"] forBarMetrics:UIBarMetricsDefault];
    /** 配置导航栏题目的样式 */
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSFontAttributeName:[UIFont flatFontOfSize:kNaviTitleFontSize], NSForegroundColorAttributeName: kNaviTitleColor}];
}

- (IBAction)shareTo:(id)sender {
    //注意：分享到微信好友、微信朋友圈、微信收藏、QQ空间、QQ好友、来往好友、来往朋友圈、易信好友、易信朋友圈、Facebook、Twitter、Instagram等平台需要参考各自的集成方法
    [UMSocialSnsService presentSnsIconSheetView:self
                                         appKey:@"5632e65ae0f55a556a0013d9"
                                      shareText:@"诗词宝典——学生们的掌中宝"
                                   shareImage:[UIImage imageNamed:@"tubiao"]
                                shareToSnsNames:[NSArray arrayWithObjects:UMShareToSina,UMShareToWechatSession,UMShareToQQ,UMShareToSms,UMShareToEmail,UMShareToWechatTimeline,nil]
                                       delegate:self];

}


@end
