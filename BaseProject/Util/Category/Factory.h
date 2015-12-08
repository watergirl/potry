//
//  Factory.h
//  BaseProject
//
//  Created by ios－23 on 15/11/12.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Factory : NSObject
/** 向某个控制器上，添加菜单按钮 */
+ (void)addMenuItemToVC:(UIViewController *)vc;

/** 向某个控制器上，添加返回按钮 */
+ (void)addBackItemToVC:(UIViewController *)vc;
@end
