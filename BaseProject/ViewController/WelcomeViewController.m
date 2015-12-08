//
//  WelcomeViewController.m
//  BaseProject
//
//  Created by ios－23 on 15/11/4.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "WelcomeViewController.h"
#import "iCarousel.h"
#import "ViewController.h"
@interface WelcomeViewController ()<iCarouselDelegate,iCarouselDataSource>

@property (nonatomic,strong)iCarousel *ic;
//存储图片名称
@property (nonatomic,strong)NSArray *imagePaths;

@end

@implementation WelcomeViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.ic];
    [self.ic mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
    self.view.backgroundColor = [UIColor blackColor];
    
}

-(NSArray *)imagePaths{
    if (!_imagePaths) {
        NSMutableArray *arr = [NSMutableArray array];
        for (int i=1; i<6; i++) {
            NSString *name = [NSString stringWithFormat:@"Welcome_3.0_%d",i];
            NSString *path = [[NSBundle mainBundle]pathForResource:name ofType:@"jpg"];
          
            [arr addObject:path];
        }
        
//        DDLogVerbose(@"      imagePaths %ld",       _imagePaths.count );
       _imagePaths = [arr copy];
        
    }
    return _imagePaths;
}
-(iCarousel *)ic{
    if (!_ic) {
        _ic = [iCarousel new];
        //仿写 collection
        _ic.delegate = self;
        _ic.dataSource = self;
        //修改3D 模式, type 是枚举值,数值0~11;
        _ic.type = 3;
        //自动展示,0表示不滚动,越大滚动越快
        _ic.autoscroll = -1;
        //改为翻页模式
        _ic.scrollEnabled = YES;
        
    }
    return _ic;
}

#pragma mark - iCarousel
//问：有多少个Cell
- (NSInteger)numberOfItemsInCarousel:(iCarousel *)carousel{
    NSLog(@" self.imagePaths.count; %ld", self.imagePaths.count);
    return self.imagePaths.count;
}
//问：每个Cell什么样
- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view{


    if (!view) {
        //这里x.y 是无作用的, 图片的宽高 300*500
        view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kWindowW, kWindowH)];
        UIImageView *imageView = [UIImageView new];
        imageView.tag = 100;
        [view addSubview:imageView];
        //        imageView.contentMode = UIViewContentModeScaleAspectFit;
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(0);
        }];
    }
    UIImageView *imageView = (UIImageView *)[view viewWithTag:100];
    //imageNames数组中存的是图片名，以为图片是jpg形式，只能用路径来读取。
    UIImage *image = [UIImage imageWithContentsOfFile:self.imagePaths[index]];
    imageView.image = image;
    return view;
}
//添加监听
-(void)carousel:(iCarousel *)carousel didSelectItemAtIndex:(NSInteger)index{
    
    
    
}



@end
