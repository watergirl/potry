//
//  UserPlan.h
//  BaseProject
//
//  Created by ios－23 on 15/11/15.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "BaseModel.h"

@interface UserPlan : BaseModel
@property (nonatomic,strong)NSString *username;
@property (nonatomic,strong)NSString *planmain;
@property (nonatomic,strong)NSString *plancontent;

+(NSArray *)planWithuserName:(NSString *)username;
+(void)insertPlanWithusername:(NSString *)username planMain:(NSString *)planmain planContent:(NSString *)plancontent;
+(void)deletatePlanWithusername:(NSString *)username PlanMain:(NSString *)planmain;
+(NSArray *)PlanWithusername:(NSString *)username PlanMain:(NSString *)planmain;
+(BOOL)exitPlanWithusername:(NSString *)username PlanMain:(NSString *)planmain;
@end
