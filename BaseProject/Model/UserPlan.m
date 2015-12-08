//
//  UserPlan.m
//  BaseProject
//
//  Created by ios－23 on 15/11/15.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "UserPlan.h"

@implementation UserPlan

+(NSArray *)planWithuserName:(NSString *)username{
    //从数据库中获取t_kind表中所有数据
    FMDatabase *db = [self defaultDatabase];
    FMResultSet *rs = [db executeQueryWithFormat:@"select * from User_Plan where username = %@",username];
    
    NSMutableArray *dataArr = [NSMutableArray new];
    while ([rs next]) {
        UserPlan *model = [self new];
        model.username = [rs stringForColumn:@"username"];
        model.planmain = [rs stringForColumn:@"planmain"];
        model.plancontent = [rs stringForColumn:@"plancontent"];
        [dataArr addObject:model];
    }
    //释放掉搜索出来的内容
    [db closeOpenResultSets];
    [db close];
    return [dataArr copy];
    
}

+(void)insertPlanWithusername:(NSString *)username planMain:(NSString *)planmain planContent:(NSString *)plancontent{
    
    FMDatabase *db = [self defaultDatabase];
    [db executeUpdateWithFormat:@"insert into User_Plan values (%@,%@,%@)", username,planmain,plancontent];
    
    [db close];
    
}

+(void)deletatePlanWithusername:(NSString *)username PlanMain:(NSString *)planmain{
    
    FMDatabase *db = [self defaultDatabase];
    [db executeUpdateWithFormat:@"delete from User_Plan where username = %@ and planmain = %@", username,planmain];
    [db close];
    
}

+(BOOL)exitPlanWithusername:(NSString *)username PlanMain:(NSString *)planmain{
    FMDatabase *db = [self defaultDatabase];
    
    NSMutableArray *dataArr = [NSMutableArray new];
    FMResultSet *rs= [db executeQueryWithFormat:@"select * from User_Plan where username = %@ and planmain = %@",username,planmain];
    
    while ([rs next]) {
        UserPlan *model = [self new];
        model.planmain = [rs stringForColumn:@"planmain"];
        model.plancontent = [rs stringForColumn:@"plancontent"];
        [dataArr addObject:model];
        
    }
    
    return dataArr.count;
}
+(NSArray *)PlanWithusername:(NSString *)username PlanMain:(NSString *)planmain{
    
    FMDatabase *db = [self defaultDatabase];
    
    NSMutableArray *dataArr = [NSMutableArray new];
    FMResultSet *rs= [db executeQueryWithFormat:@"select * from User_Plan where username = %@ and planmain = %@",username,planmain];
   
    while ([rs next]) {
        UserPlan *model = [self new];
        model.planmain = [rs stringForColumn:@"planmain"];
        model.plancontent = [rs stringForColumn:@"plancontent"];
        [dataArr addObject:model];
        
    }
    
    return dataArr;

}
@end
