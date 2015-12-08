//
//  ChangePageViewController.h
//  BaseProject
//
//  Created by ios－23 on 15/11/12.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ChangePageViewController;

@protocol ChangePageViewControllerDelegate <NSObject>

-(void)change:(ChangePageViewController *)changeVC didInPutImage:(UIImage *)image;

@end

@interface ChangePageViewController : UIViewController
@property (nonatomic,weak)id<ChangePageViewControllerDelegate> delegate;
@end
