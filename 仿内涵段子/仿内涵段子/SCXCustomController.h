//
//  SCXCustomController.h
//  仿内涵段子
//
//  Created by 孙承秀 on 16/9/29.
//  Copyright © 2016年 孙先森丶. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol SCXCustomSliderViewControllerDataSource;
@protocol SCXCustomSliderViewControllerDelegate;
@interface SCXCustomController : UIViewController
@property(nonatomic,strong)UIScrollView *scrollView;
@property(nonatomic,strong)NSMutableDictionary *displayVCs;
@property(nonatomic,strong)NSMutableDictionary *memoryCaches;
@property(nonatomic,assign)NSInteger selectIndex;
/**
 *  sliderViewControllerDelegate
 */
@property(nonatomic,weak)id <SCXCustomSliderViewControllerDelegate > delegate;
/**
 *  sliderViewControllerDatasource
 */
@property(nonatomic,weak)id <SCXCustomSliderViewControllerDataSource > dataSource;
/**
 *  刷新列表
 */
-(void)SCX_reloadData;
@end
@protocol SCXCustomSliderViewControllerDataSource <NSObject>
/**
 *  获取当前控制器下的所有子控制器
 *
 *  @param controller 当前控制器
 *
 *  @return 子控制器的个数
 */
-(NSInteger)numberOfChildViewControllersInSliderViewController:(SCXCustomController *)controller;
/**
 *  获取指定位置的controller
 *
 *  @param sliderViewController 当前sliderController
 *  @param index                要获取的位置
 *
 *  @return 指定位置的controller
 */
-(UIViewController *)sliderViewController:(SCXCustomController *)sliderViewController viewControllerAtIndex:(NSInteger)index;

@end
@protocol SCXCustomSliderViewControllerDelegate <NSObject>

@optional
/**
 *  sliderViewController偏移量
 *
 *  @param sliderViewController sliderViewController
 *  @param offset               偏移量
 */
-(void)customSliderViewController:(SCXCustomController *)sliderViewController sliderOffset:(CGPoint)offset;
/**
 *  sliderViewController位置
 *
 *  @param sliderViewController sliderViewController
 *  @param index                位置
 */
-(void)customSliderViewController:(SCXCustomController *)sliderViewController sliderIndex:(NSInteger)index;

@end
