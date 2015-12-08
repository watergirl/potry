//
//  kImageView.m
//  BaseProject
//
//  Created by ios－23 on 15/11/9.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "kImageView.h"

@implementation kImageView

-(instancetype)init{
    if (self = [super init]) {
        _imageView = [UIImageView new];
        [self addSubview:_imageView];
        //按比例放大充满
        _imageView.contentMode = UIViewContentModeScaleAspectFill;
        [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(0);
        }];
        //当前视图容易剪掉超出自身范围的视图
        self.clipsToBounds = YES;
    }
    return self;
}

@end
