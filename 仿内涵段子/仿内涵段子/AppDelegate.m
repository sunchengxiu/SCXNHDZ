//
//  AppDelegate.m
//  仿内涵段子
//
//  Created by 孙承秀 on 16/9/20.
//  Copyright © 2016年 孙先森丶. All rights reserved.
//

#import "AppDelegate.h"
#import "SCXTabrBarController.h"
#import <Bugly/Bugly.h>
#import "SCXLocationManager.h"
#import "SCXShareManager.h"
@interface AppDelegate ()<BuglyDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [[SCXShareManager sharedManager] registerAllPlatforms];
    self.window=[[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    [AMapServices sharedServices].apiKey=AMKEY;
    [[SCXLocationManager sharedlocationManager] startSerialLocation];
    [self setUpBugly];
    SCXTabrBarController *tabbar=[[SCXTabrBarController alloc]init];
    self.window.rootViewController=tabbar;
    [self.window makeKeyAndVisible];
    return YES;
}
-(void)setUpBugly{
    BuglyConfig *config=[[BuglyConfig alloc]init];
    config.debugMode=YES;
    //卡顿开关
    config.blockMonitorEnable=YES;
    /**
     *  卡顿间隔时间
     */
    config.blockMonitorTimeout=2;
    /**
     * 控制自定义日志上报，默认值为BuglyLogLevelSilent，即关闭日志记录功能。
     * 如果设置为BuglyLogLevelWarn，则在崩溃时会上报Warn、Error接口打印的日志
     */
    config.reportLogLevel=BuglyLogLevelWarn;
    
    config.delegate=self;
    [Bugly startWithAppId:BUGLY_APP_ID developmentDevice:YES config:config];
    [Bugly setUserIdentifier:[NSString stringWithFormat:@"User: %@", [UIDevice currentDevice].name]];
    
    [Bugly setUserValue:[NSProcessInfo processInfo].processName forKey:@"Process"];
    
}
- (NSString *)attachmentForException:(NSException *)exception {
    NSLog(@"(%@:%d) %s %@",[[NSString stringWithUTF8String:__FILE__] lastPathComponent], __LINE__, __PRETTY_FUNCTION__,exception);
    
    return @"This is an attachment";
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url];
    if (!result) {
        // 其他如支付等SDK的回调
    }
    return result;
}
@end
