//
//  PoetryModel.m
//  BaseProject
//
//  Created by jiyingxin on 15/10/28.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "PoetryModel.h"

@implementation PoetryModel
//把搜索结果FMResultSet类型转换为 包含PoetryModel的数组类型
+ (NSArray *)rsToPortryList:(FMResultSet *)rs{
    NSMutableArray *dataArr = [NSMutableArray new];
    while ([rs next]) {
        PoetryModel *model = [self new];
        model.kind = [rs stringForColumn:@"d_kind"];
        model.author=[rs stringForColumn:@"d_author"];
        model.title=[rs stringForColumn:@"d_title"];
        model.ID = [rs longForColumn:@"d_id"];
        model.shi = [rs stringForColumn:@"d_shi"];
        model.introShi=[rs stringForColumn:@"d_introshi"];
      
        [dataArr addObject:model];
    }
    return [dataArr copy];
}

+ (NSArray *)poetryListWithSearchStr:(NSString *)searchStr{
    FMDatabase *db = [self defaultDatabase];
//SQL语句 通配符  ss ->  %ss%
//如果要在format中输入%，需要转义符 %配合
    searchStr=[NSString stringWithFormat:@"%%%@%%", searchStr];
//    DDLogVerbose(@"searchStr: %@", searchStr);
    FMResultSet *rs = [db executeQueryWithFormat:@"select * from t_shi where d_title like %@ or d_author like %@", searchStr, searchStr];
    NSArray *arr = [self rsToPortryList:rs];
    [db close];
    return arr;
}



- (BOOL)removePoetry{
    FMDatabase *db = [PoetryModel defaultDatabase];
    BOOL success = [db executeUpdateWithFormat:@"delete from t_shi where d_id = %ld", _ID];
    [db close];
    return success;
}

//+(void)UpdateRemberWithTitle:(NSString *)title{
//    FMDatabase *db = [PoetryModel defaultDatabase];
//    [db executeUpdateWithFormat:@"update t_shi set d_rember = 1 where d_title = %@", title];
//    [db close];
//}
//+(void)resumeRemberWithTitle:(NSString *)title{
//    FMDatabase *db = [PoetryModel defaultDatabase];
//    [db executeUpdateWithFormat:@"update t_shi set d_rember = 0 where d_title = %@", title];
//    [db close];
//}


+ (NSArray *)poetryListWithKind:(NSString *)kind{
    FMDatabase *db = [self defaultDatabase];
//如果数据库语句需要传参 ⬇️
    FMResultSet *rs = [db executeQueryWithFormat:@"select * from T_SHI where d_kind = %@", kind];
    NSArray *arr = [self rsToPortryList:rs];
    [db close];
    return arr;
}
//+ (NSArray *)poetryListWithRember{
//    FMDatabase *db = [self defaultDatabase];
//    //如果数据库语句需要传参 ⬇️
//    FMResultSet *rs = [db executeQueryWithFormat:@"select * from T_SHI where d_rember = 1"];
//    NSArray *arr = [self rsToPortryList:rs];
//    [db close];
//    return arr;
//}
+ (NSArray *)poetryListWithAll{
    FMDatabase *db = [self defaultDatabase];
    //如果数据库语句需要传参 ⬇️
    FMResultSet *rs = [db executeQueryWithFormat:@"select * from T_SHI "];
    NSArray *arr = [self rsToPortryList:rs];
    [db close];
    return arr;
}
@end










