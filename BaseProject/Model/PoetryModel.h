//
//  PoetryModel.h
//  BaseProject
//
//  Created by jiyingxin on 15/10/28.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "BaseModel.h"

@interface PoetryModel : BaseModel

@property(nonatomic,strong) NSString *kind;
@property(nonatomic,strong) NSString *shi;
@property(nonatomic,strong) NSString *introShi;
@property(nonatomic,strong) NSString *title;
@property(nonatomic) long ID;
@property(nonatomic,strong) NSString *author;
//@property (nonatomic,assign )BOOL rember;
- (BOOL)removePoetry;
//通过字符串，搜索 诗名或者作者包含此字符串的诗
+ (NSArray *)poetryListWithSearchStr:(NSString *)searchStr;

+ (NSArray *)poetryListWithKind:(NSString *)kind;
////已经背过的诗
//+(void)UpdateRemberWithTitle:(NSString *)title;
////还要继续背
//+(void)resumeRemberWithTitle:(NSString *)title;
////诗列表中记住的所有诗
//+ (NSArray *)poetryListWithRember;
+ (NSArray *)poetryListWithAll;
@end











