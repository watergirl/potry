//
//  UserShi.h
//  BaseProject
//
//  Created by ios－23 on 15/11/11.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "BaseModel.h"

@interface UserShi : BaseModel

@property (nonatomic,strong)NSString *userName;
@property (nonatomic,strong)NSString *title;
//通过名字查找所有古诗
+(NSArray *)shiWithuserName:(NSString *)username;

// 更新姓名古诗(添加背过的古诗数)
+(BOOL)exitusername:(NSString *)username shi:(NSString *)title;
+(void)insertusername:(NSString *)username shi:(NSString *)title;
+ (void)removeRemberWithUsername:(NSString *)username shi:(NSString *)title;
@end
