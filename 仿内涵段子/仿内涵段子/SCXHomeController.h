//
//  SCXHomeController.h
//  仿内涵段子
//
//  Created by 孙承秀 on 16/9/20.
//  Copyright © 2016年 孙先森丶. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SCXBaseController.h"
#import "single.h"
#import "SCXHomeModel.h"
#import "SCXCustomController.h"
#import "SCXHeaderScrollView.h"
@interface SCXHomeController : SCXBaseController<SCXCustomSliderViewControllerDataSource,SCXCustomSliderViewControllerDelegate>
singleH(HomeController)
/**home控制器数据数组，里面存在的是homeModel*/
@property(nonatomic)NSMutableArray<SCXHomeModel *> *models;
/**标题数组*/
@property(nonatomic,copy)NSMutableArray<NSString *> *titles;
/**url数组*/
@property(nonatomic,copy)NSMutableArray<NSString *> *urls;

/**
 controller数组
 */
@property(nonatomic,strong)NSMutableArray *viewControllers;

/**
 滑动controller
 */
@property(nonatomic,strong)SCXCustomController  *sliderViewController;

/**
 头部ScrollView
 */
@property(nonatomic,strong)SCXHeaderScrollView *headerScrollView;

@end
