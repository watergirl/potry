//
//  ShiListViewController.h
//  BaseProject
//
//  Created by jiyingxin on 15/10/29.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import <UIKit/UIKit.h>


//因为UITableViewCell 是基础风格，不带右侧详情
//为了变为共有，即被其他类引用，需要在.h文件中声明


@interface ShiListViewController : UIViewController
- (id)initWithKind:(NSString *)kind;
@property(nonatomic,strong) NSString *kind;

@end

@interface PoetryCell : UITableViewCell

@end












