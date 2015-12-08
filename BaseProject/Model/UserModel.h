//
//  UserModel.h
//  BaseProject
//
//  Created by ios－23 on 15/11/8.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "BaseModel.h"

@interface UserModel : BaseModel
@property (nonatomic,strong)NSString *name;
@property (nonatomic,strong)NSString *password;
@property (nonatomic,getter=isOnline)BOOL online;
+(NSArray *)nameArr:(NSString *)name;
+(NSArray *)name;
+(NSArray *)phoneNumber;
+(void)UpdateNameWithName:(NSString *)name password:(NSString *)pwd phoneNmber:(NSString *)phoneNM;
+(NSString *)passwordWithName:(NSString *)name;
+(NSString *)nameWithOnline;
+(void)UpdateOnlineWithName:(NSString *)name;
+(void)updateUnderLine;
@end
