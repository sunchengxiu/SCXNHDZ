//
//  SCXTabrBarController.m
//  仿内涵段子
//
//  Created by 孙承秀 on 16/9/20.
//  Copyright © 2016年 孙先森丶. All rights reserved.
//

#import "SCXTabrBarController.h"
#import "SCXBaseController.h"
#import "SCXBaseNavigationController.h"
#import "SCXHomeController.h"
#import "SCXFoundController.h"
#import "SCXCheckController.h"
#import "SCXtextController.h"
#import "SCXHomeModel.h"
#import "SCXRequestManager.h"
#import "SCXBaseRequestHelp.h"
#import "UIView+AnimationView.h"
@implementation SCXTabrBarController
+ (void)initialize
{
    [[UITabBar appearance] setTranslucent:YES];
    [[UITabBar appearance] setBarTintColor:[UIColor colorWithRed:0.97f green:0.97f blue:0.97f alpha:1.0f]];
    UITabBarItem *item=[UITabBarItem appearance];
    [item setTitlePositionAdjustment:UIOffsetMake(0, 0.15)];
    NSMutableDictionary *dic=[NSMutableDictionary dictionary];
    dic[NSFontAttributeName]=[UIFont systemFontOfSize:13];
    dic[NSForegroundColorAttributeName]=[UIColor colorWithRed:0.63f green:0.63f blue:0.63f alpha:1.0f];
    [item setTitleTextAttributes:dic forState:UIControlStateNormal];
    
    NSMutableDictionary *dic1=[NSMutableDictionary dictionary];
    dic1[NSFontAttributeName]=[UIFont systemFontOfSize:13];
    dic1[NSForegroundColorAttributeName]=[UIColor colorWithRed:0.33f green:0.33f blue:0.33f alpha:1.0f];
    [item setTitleTextAttributes:dic forState:UIControlStateSelected];
    
    
}
-(void)viewDidLoad{

    [super viewDidLoad];
    [[[[UIApplication sharedApplication] delegate] window] showAnimationView];
    self.view.backgroundColor=[UIColor whiteColor];
    [self addChildViewControllerWithChildName:@"首页" andImage:@"home" andControllerClassName:[SCXHomeController description]];
    [self addChildViewControllerWithChildName:@"发现" andImage:@"Found" andControllerClassName:[SCXFoundController description]];
    [self addChildViewControllerWithChildName:@"审核" andImage:@"audit" andControllerClassName:[SCXCheckController description]];
    [self addChildViewControllerWithChildName:@"消息" andImage:@"newstab" andControllerClassName:[SCXtextController description]];
    SCXBaseRequestHelp *request=[SCXBaseRequestHelp SCX_Request];
    request.SCX_url=HOMEAPI;
    [request SCX_sendRequestWithComplement:^(id responseObject, BOOL success, NSString *message) {
        [[[[UIApplication sharedApplication] delegate] window] hideAnimationView];
        if (success) {
            
            SCXBaseNavigationController *nav=(SCXBaseNavigationController *)self.viewControllers.firstObject;
            NSLog(@"%@",nav.viewControllers );
            SCXHomeController *controller=(SCXHomeController *)nav.viewControllers.firstObject;
            controller.models=[SCXHomeModel objectArrayWithKeyValuesArray:responseObject];
        }
    } ];
    
}
#pragma mark -- 添加子控制器
-(void)addChildViewControllerWithChildName:(NSString *)childName andImage:(NSString *)imageName andControllerClassName:(NSString *)className{
    UIViewController *class=[NSClassFromString(className) new] ;
    SCXBaseNavigationController *nav=[[SCXBaseNavigationController alloc]initWithRootViewController:class];
    nav.tabBarItem.title=childName;
    nav.tabBarItem.image=[[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    nav.tabBarItem.selectedImage=[[UIImage imageNamed:[imageName stringByAppendingString:@"_press"]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
   
    [self addChildViewController:nav];
}
@end
