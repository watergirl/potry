//
//  AppDelegate.m
//  BaseProject
//
//  Created by jiyingxin on 15/10/21.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "AppDelegate.h"
#import "AppDelegate+Category.h"
#import "UMSocial.h"
#import "UMSocialWechatHandler.h"

#import <SMS_SDK/SMSSDK.h>
@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    return  [UMSocialSnsService handleOpenURL:url];
}
- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation
{
    return  [UMSocialSnsService handleOpenURL:url];
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    //shareSDK
    [SMSSDK registerApp:@"bc3dab22d3b0" withSecret:@"a53be7934b63cee61c50d30cf20b40e5"];
    
    
    
    [UMSocialData setAppKey:@"5632e65ae0f55a556a0013d9"];
    
    //设置微信AppId、appSecret，分享url
    //iOS9以后，xcode7增加了代码压缩功能，ENABLE_BITCODE。 此功能很多第三方库不支持， 需要手动关闭.
    // Targets->Build Setting-搜索bitcode->改为NO
    [UMSocialWechatHandler setWXAppId:@"wx945b58aef3a271f0" appSecret:@"0ae78dd42761fd9681b04833c79a857b" url:@"http://www.umeng.com/social"];
    
    [self initializeWithApplication:application];
    [self movePoetryDBToDoc];

    return YES;
}
/*
 因为要对数据库中的数据进行删除操作，但是app目录下的文件都是只读的，所以我们要复制一份到document文件夹下，以后就都对docment文件夹下的数据库做操作
 */
- (void)movePoetryDBToDoc{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Poetry" ofType:@"bundle"];
    path = [path stringByAppendingPathComponent:@"sqlite.db"];
//    NSLog(@"path %@", path);
    
    NSString *docPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
    docPath = [docPath stringByAppendingPathComponent:@"sqlite.db"];
    NSLog(@"docPath %@", docPath);
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:docPath]) {
        [fileManager copyItemAtPath:path toPath:docPath error:nil];
    }
}


@end
