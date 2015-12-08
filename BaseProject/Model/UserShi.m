//
//  UserShi.m
//  BaseProject
//
//  Created by ios－23 on 15/11/11.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "UserShi.h"
#import "BaseModel.h"
@implementation UserShi

+(NSArray *)shiWithuserName:(NSString *)username{
    //从数据库中获取t_kind表中所有数据
    FMDatabase *db = [self defaultDatabase];
    FMResultSet *rs = [db executeQueryWithFormat:@"select * from User_Shi where username = %@",username];
    
    NSMutableArray *dataArr = [NSMutableArray new];
    while ([rs next]) {
        UserShi *model = [self new];
        model.userName = [rs stringForColumn:@"username"];
        model.title = [rs stringForColumn:@"title"];
        [dataArr addObject:model];
    }
    //释放掉搜索出来的内容
    [db closeOpenResultSets];
    [db close];
    return [dataArr copy];
 
}
// 更新姓名古诗(添加背过的古诗)
+(void)insertusername:(NSString *)username shi:(NSString *)title{
    
    FMDatabase *db = [self defaultDatabase];
    [db executeUpdateWithFormat:@"insert into User_Shi values (%@,%@)", username,title];
    
    
    [db close];
    
}

+(BOOL)exitusername:(NSString *)username shi:(NSString *)title{
    FMDatabase *db = [self defaultDatabase];

   NSMutableArray *dataArr = [NSMutableArray new];
    FMResultSet *rs= [db executeQueryWithFormat:@"select * from User_Shi where username = %@ and title = %@",username,title];

    while ([rs next]) {
        UserShi *model = [self new];
        model.userName = [rs stringForColumn:@"username"];
        model.title = [rs stringForColumn:@"title"];
        [dataArr addObject:model];
    
    }

    return dataArr.count;

}

+ (void)removeRemberWithUsername:(NSString *)username shi:(NSString *)title{
    
    FMDatabase *db = [UserShi defaultDatabase];
     [db executeUpdateWithFormat:@"delete from User_Shi where username = %@ and title = %@", username,title];
    [db close];
   
}


@end
