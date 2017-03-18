//
//  SCXCustomController.m
//  仿内涵段子
//
//  Created by 孙承秀 on 16/9/29.
//  Copyright © 2016年 孙先森丶. All rights reserved.
//

#import "SCXCustomController.h"
@interface SCXCustomController ()<UIScrollViewDelegate>

@end

@implementation SCXCustomController
-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    self.scrollView.frame=self.view.bounds;
    self.scrollView.contentSize=CGSizeMake(ScreenWidth* [self numberOfChildViewControllerCounts], self.scrollView.frame.size.height);
}
#pragma mark--懒加载
-(UIScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView=[[UIScrollView alloc]init];
        [self.view addSubview:_scrollView];
        _scrollView.delegate=self;
        [_scrollView setShowsHorizontalScrollIndicator:NO];
        [_scrollView setShowsVerticalScrollIndicator:NO];
        _scrollView.pagingEnabled=YES;
        _scrollView.bounces=NO;
    }

    return _scrollView;
}
-(NSMutableDictionary *)displayVCs{
    if (!_displayVCs) {
        _displayVCs=[[NSMutableDictionary alloc]init];
    }
    return _displayVCs;
}
-(NSMutableDictionary *)memoryCaches{
    if (!_memoryCaches) {
        _memoryCaches=[[NSMutableDictionary alloc]init];
    }
    return _memoryCaches;
}
-(void)SCX_reloadData{
    [self.displayVCs removeAllObjects];
    [self.memoryCaches removeAllObjects];
    for (NSInteger i=0; i<self.childViewControllers.count; i++) {
        UIViewController *viewController=self.childViewControllers[i];
        [viewController willMoveToParentViewController:nil];
        [viewController.view removeFromSuperview ];
        [viewController removeFromParentViewController];
    }
    self.scrollView.frame=self.view.bounds;
    self.scrollView.contentSize=CGSizeMake(ScreenWidth* [self numberOfChildViewControllerCounts], self.view.frame.size.height);
    [self scrollViewDidScroll:self.scrollView];
}
-(void)setSelectIndex:(NSInteger)selectIndex{
    _selectIndex=selectIndex;
    [self.scrollView setContentOffset:CGPointMake(selectIndex*ScreenWidth, 0) animated:YES];
}
#pragma mark--ScrollView代理方法
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
     NSInteger currentPage = scrollView.contentOffset.x / self.view.frame.size.width;
    NSInteger start = currentPage == 0 ? currentPage : (currentPage );
    NSInteger end = (currentPage == [self numberOfChildViewControllerCounts] - 1) ? currentPage : (currentPage);
    
    for (NSInteger index = start; index <= end; index++) {
        UIViewController *viewController = [self.displayVCs objectForKey:@(index)];
        if (viewController == nil) {
            // 获取当前控制器
            [self instanceChildViewControllerAtIndex:index];
        }
    }
//    
//    // 将start之前和end之后的放入缓存中
//    for (NSInteger index = 0; index <= start - 1; index++) {
//        UIViewController *viewController = [self.displayVCs objectForKey:@(index)];
//        [self removeChildViewController:viewController atIndex:index];
//    }
//    
//    for (NSInteger index = end + 1; index <= [self numberOfChildViewControllerCounts] - 1; index++) {
//        UIViewController *viewController = [self.displayVCs objectForKey:@(index)];
//        [self removeChildViewController:viewController atIndex:index];
//    }
    
    if ([self.delegate respondsToSelector:@selector(customSliderViewController:sliderOffset:)]) {
        [self.delegate customSliderViewController:self sliderOffset:scrollView.contentOffset];
    }

}
-(void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView{

}
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    if ([self.delegate respondsToSelector:@selector(customSliderViewController:sliderOffset:)]) {
        [self.delegate customSliderViewController:self sliderOffset:scrollView.contentOffset];
    }
}
-(void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset{
    if ([self.delegate respondsToSelector:@selector(customSliderViewController:sliderOffset:)]) {
        [self.delegate customSliderViewController:self sliderOffset:scrollView.contentOffset];
    }
}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    if ([self.delegate respondsToSelector:@selector(customSliderViewController:sliderIndex:)]) {
        [self.delegate customSliderViewController:self sliderIndex:scrollView.contentOffset.x/ScreenWidth];
    }
}
#pragma mark--获取子控制器的个数
-(NSInteger)numberOfChildViewControllerCounts{
    if ([self.dataSource respondsToSelector:@selector(numberOfChildViewControllersInSliderViewController:)]) {
        return [self.dataSource numberOfChildViewControllersInSliderViewController:self];
    }
    return 0;
}
#pragma mark--获取，添加和移除控制器
-(void)addChildViewController:(UIViewController *)childController atIndex:(NSInteger)index{
    if ([self.childViewControllers containsObject:childController]) {
        return;
    }
    [self addChildViewController:childController];
    [childController didMoveToParentViewController:self];
    [self.displayVCs setObject:childController forKey:@(index)];
    [self.scrollView addSubview:childController.view];
    childController.view.frame=CGRectMake(ScreenWidth*index, 0, ScreenWidth, self.scrollView.frame.size.height);

}
-(void)removeChildViewController:(UIViewController *)childController atIndex:(NSInteger)index{
    if (childController==nil) {
        return;
    }
//    //移除控制器，放入缓存中
//    [childController removeFromParentViewController];
//    [childController willMoveToParentViewController:nil];
//    [childController.view removeFromSuperview];
    [self.displayVCs removeObjectForKey:@(index)];
    if (![self.memoryCaches objectForKey:@(index)]) {
        [self.memoryCaches setObject:childController forKey:@(index)];
    }
}
#pragma mark--从内存中获取一个controller
-(void)instanceChildViewControllerAtIndex:(NSInteger)index{
    UIViewController *viewController=[self.memoryCaches objectForKey:@(index)];
    if (viewController==nil) {
        [self.dataSource respondsToSelector:@selector(sliderViewController:viewControllerAtIndex:)];
        UIViewController *vc=[self.dataSource sliderViewController:self viewControllerAtIndex:index];
        [self addChildViewController:vc atIndex:index];
    }else{
        [self addChildViewController:viewController atIndex:index];
    }
}
@end
