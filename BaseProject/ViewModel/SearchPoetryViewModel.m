//
//  SearchPoetryViewModel.m
//  BaseProject
//
//  Created by jiyingxin on 15/10/29.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "SearchPoetryViewModel.h"

@implementation SearchPoetryViewModel

- (NSArray *)poetryList{
    if (_searchStr == nil || _searchStr.length == 0) {
        return nil;
    }
    return [PoetryModel poetryListWithSearchStr:_searchStr];
}

+(NSString *)shiwithTitle:(NSString *)title{
    PoetryModel *model = [PoetryModel poetryListWithSearchStr:title][0];
    return model.shi;
}

@end














