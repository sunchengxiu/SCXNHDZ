//
//  SCXBaseController.m
//  仿内涵段子
//
//  Created by 孙承秀 on 16/9/20.
//  Copyright © 2016年 孙先森丶. All rights reserved.
//

#import "SCXBaseController.h"
#import "UIViewController+SCXLoadingView.h"
#import "UIView+AnimationView.h"
@implementation SCXBaseController

-(void)viewDidLoad{
    [super viewDidLoad];
    self.edgesForExtendedLayout=UIRectEdgeNone;
    self.automaticallyAdjustsScrollViewInsets=YES;
   // self.view.backgroundColor=[UIColor whiteColor];
   
   
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    /**
     * 这个方法是为controller写了一个类别，直接用self调用即可，也非常的简单易用.
     * [self showLoadingView];
     */
    /**这个方法是单独为UIVEW写一个类别，调用非常简单，直接调用方法就行了.*/
   // [self.view showAnimationView];
    
}
#pragma mark -- 自动以加载动画,这个方法是单独的建一个类，生成一个动画
-(void)showAnimatonView{

    SCXCostomAnimationView *animationView=[[SCXCostomAnimationView alloc]init];
    _animationView=animationView;
    [_animationView showInView:self.view];
    [self.view bringSubviewToFront:_animationView];
    
}
-(void)stopAnimationView{
    [_animationView stopAnimation];
    [_animationView removeFromSuperview];
    _animationView=nil;
}
#pragma mark -- 重写系统的一些有关控制器方法
/***推出一个控制器*/
-(void)pushViewController:(UIViewController *)viewController{
    if (![viewController isKindOfClass:[UIViewController class]]) {
        return;
    }
    if (viewController==nil) {
        return;
    }
    if (viewController.hidesBottomBarWhenPushed==NO) {
        viewController.hidesBottomBarWhenPushed=YES;
    }
    [self.navigationController pushViewController:viewController animated:YES];

}
/**弹出一个控制器*/
-(void)presentViewController:(UIViewController *)viewController{
    if (![viewController isKindOfClass:[UIViewController class]]) {
        return;
    }
    if (viewController==nil) {
        return;
    }
    [self presentViewController:viewController animated:YES completion:^{
        
    }];

}
/**回到一个控制器*/
-(void)popViewController:(UIViewController *)viewController{
    if ([viewController isKindOfClass:[UIViewController class]]) {
        return;
    }
    if (viewController==nil) {
        return;
    }
    [self.navigationController popViewControllerAnimated:YES];
    
}
/**回到根控制器*/
-(void)popToRootViewController:(UIViewController *)viewController{
    if ([viewController isKindOfClass:[UIViewController class]]) {
        return;
    }
    if (viewController==nil) {
        return;
    }
    [self.navigationController popToRootViewControllerAnimated:YES];
}
/**回到指定的控制器*/
-(void)popToViewController:(UIViewController *)viewController{
    if ([viewController isKindOfClass:[UIViewController class]]) {
        return;
    }
    if (viewController==nil) {
        return;
    }
    [self.navigationController popToViewController:viewController animated:YES];
    
}
/**销毁一个控制器*/
-(void)dismissViewController:(UIViewController *)viewController{
    if (![viewController isKindOfClass:[UIViewController class]]) {
        return;
    }
    if (viewController==nil) {
        return;
    }
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];

}
/**移除一个子控制器*/
-(void)removeChildViewController:(UIViewController *)viewController{
    if (viewController==nil) {
        return;
    }
    [viewController.view removeFromSuperview];
    [viewController willMoveToParentViewController:nil];

    [viewController removeFromParentViewController];
}
/**添加一个子控制器*/
-(void)adMydChildViewController:(UIViewController *)childViewController{

    if (childViewController==nil) {
        return;
    }
    [childViewController willMoveToParentViewController:self];
    [self.view addSubview:childViewController.view];
    childViewController.view.frame=self.view.bounds;
    [self addChildViewController:childViewController];
}

@end
