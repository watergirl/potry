//
//  UserModel.m
//  BaseProject
//
//  Created by ios－23 on 15/11/8.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "UserModel.h"

@implementation UserModel




+ (NSArray *)nameArr:(NSString *)name{
    //从数据库中获取t_kind表中所有数据
    FMDatabase *db = [self defaultDatabase];
    FMResultSet *rs = [db executeQuery:@"select * from T_USER"];
    
    NSMutableArray *dataArr = [NSMutableArray new];
    while ([rs next]) {
        UserModel *model = [self new];
        model.name  = [rs stringForColumn:@"T_name"];
        model.password = [rs stringForColumn:@"T_password"];
        model.online = [rs stringForColumn:@"T_online"];
        
        [dataArr addObject:model];
    }
    //释放掉搜索出来的内容
    [db closeOpenResultSets];
    [db close];
    return [dataArr copy];
}
+(NSArray *)name{
    FMDatabase *db = [self defaultDatabase];
    FMResultSet *rs = [db executeQuery:@"select * from T_USER"];
    NSMutableArray *dataArr = [NSMutableArray new];
    while ([rs next]) {
       
       NSString *name  = [rs stringForColumn:@"T_name"];
     
        
        [dataArr addObject:name];
    }
    //释放掉搜索出来的内容
    [db closeOpenResultSets];
    [db close];
    return [dataArr copy];
}

+(NSArray *)phoneNumber{
    FMDatabase *db = [self defaultDatabase];
    FMResultSet *rs = [db executeQuery:@"select * from T_USER"];
    NSMutableArray *dataArr = [NSMutableArray new];
    while ([rs next]) {
        
        NSString *phoneNumber  = [rs stringForColumn:@"T_phoneNumber"];
        
        
        [dataArr addObject:phoneNumber];
    }
    //释放掉搜索出来的内容
    [db closeOpenResultSets];
    [db close];
    return [dataArr copy];
}



+(void)UpdateNameWithName:(NSString *)name password:(NSString *)pwd phoneNmber:(NSString *)phoneNM {
    FMDatabase *db = [UserModel defaultDatabase];
    //同时添加在线功能
    [db executeUpdateWithFormat:@"insert into t_user values (%@,%@,1,%@)", name,pwd,phoneNM];
    
    
    [db close];
}
+(NSString *)passwordWithName:(NSString *)name{
    FMDatabase *db = [self defaultDatabase];
    //如果数据库语句需要传参 ⬇️
    FMResultSet *rs = [db executeQueryWithFormat:@"select * from T_USER where T_name = %@", name];
    NSString *password = nil;
    while ([rs next]) {
        password = [rs stringForColumn:@"T_password"];
    }
//    NSLog(@"---%@",password);
    return password;
}

+(NSString *)nameWithOnline{
    FMDatabase *db = [self defaultDatabase];
    //如果数据库语句需要传参 ⬇️
    FMResultSet *rs = [db executeQueryWithFormat:@"select * from T_USER where T_online = 1"];
    
    NSString *name = nil;
    while ([rs next]) {
        name = [rs stringForColumn:@"T_name"];
    }
      return name;
}

+(void)UpdateOnlineWithName:(NSString *)name  {
    FMDatabase *db = [UserModel defaultDatabase];
    [db executeUpdateWithFormat:@"update T_user set t_online = 1 where t_name = %@", name];
    [db close];
}
+(void)updateUnderLine{
    FMDatabase *db = [UserModel defaultDatabase];
    [db executeUpdateWithFormat:@"update T_user set t_online = 0"];
    [db close];

}
@end
