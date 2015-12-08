//
//  SearchPoetryViewModel.h
//  BaseProject
//
//  Created by jiyingxin on 15/10/29.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "PoetryViewModel.h"

@interface SearchPoetryViewModel : PoetryViewModel
@property(nonatomic,strong) NSString *searchStr;
+(NSString *)shiwithTitle:(NSString *)title;
@end













