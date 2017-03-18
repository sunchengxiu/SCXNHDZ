//
//  SCXHomeController.m
//  仿内涵段子
//
//  Created by 孙承秀 on 16/9/20.
//  Copyright © 2016年 孙先森丶. All rights reserved.
//

#import "SCXHomeController.h"
#import "SCXHomeBaseTableviewController.h"
@implementation SCXHomeController

singleM(HomeController)

#pragma mark--懒加载
-(NSMutableArray<NSString *> *)titles{
    if (_titles==nil) {
        _titles=[[NSMutableArray alloc]initWithCapacity:0];
    }
    return _titles;
}
-(NSMutableArray<NSString *> *)urls{

    if (_urls==nil) {
        _urls=[[NSMutableArray alloc]initWithCapacity:0];
    }
    return _urls;
}
-(NSMutableArray *)viewControllers{

    if (!_viewControllers) {
        _viewControllers=[NSMutableArray new];
    }
    return _viewControllers;
}
-(SCXCustomController *)sliderViewController{
    if (_sliderViewController==nil) {
        _sliderViewController=[[SCXCustomController alloc]init];
        [self addChildViewController:_sliderViewController];
       
        _sliderViewController.delegate=self;
        _sliderViewController.dataSource=self;
        [_sliderViewController willMoveToParentViewController:self];
         _sliderViewController.view.frame = CGRectMake(0, self.headerScrollView.frame.size.height, ScreenWidth, ScreenHeight-self.headerScrollView.frame.size.height-50);
        [self.view addSubview:_sliderViewController.view];
        
    }
    return _sliderViewController;
}
-(SCXHeaderScrollView *)headerScrollView{
    if (!_headerScrollView) {
        _headerScrollView=[[SCXHeaderScrollView alloc]init];
        _headerScrollView.frame=CGRectMake(0, 0, ScreenWidth, 40);
        [self.view addSubview:_headerScrollView];
        
    }
    return _headerScrollView;
}
-(void)viewDidLoad{
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
}
-(void)setModels:(NSMutableArray *)models{
    if (models.count==0) {
        return;
    }
    _models=models;
    for (SCXHomeModel *model  in models) {
       
        if ([model.name isKindOfClass:[NSString class]]) {
            [self.titles addObject:model.name];
            NSLog(@"%@",model.name);
        }
        if ([model.url isKindOfClass:[NSString class]]) {
            NSLog(@"%@",model.url);
            [self.urls addObject:model.url];
            SCXHomeBaseTableviewController *homeBase = [[SCXHomeBaseTableviewController alloc] initWithUrl:model.url];
            //homeBase.view.frame=CGRectMake(0,0,ScreenWidth, ScreenHeight-40-64-50);
            [self.viewControllers addObject:homeBase];
           
        }
    }
    __block typeof(self)weakSelf=self;
    self.view.userInteractionEnabled=YES;
    self.headerScrollView.titlesArray=self.titles;
    self.headerScrollView.clickTitleHandleBlock=^(SCXHeaderScrollView *headerView,NSString *title,NSInteger index){
        [weakSelf.sliderViewController setSelectIndex:index];
    
    };
    [self.sliderViewController SCX_reloadData];

}
#pragma mark--datasource delegate
-(NSInteger)numberOfChildViewControllersInSliderViewController:(SCXCustomController *)controller{

    return self.viewControllers.count;
}
-(UIViewController *)sliderViewController:(SCXCustomController *)sliderViewController viewControllerAtIndex:(NSInteger)index{
    return self.viewControllers[index];

}
-(void)customSliderViewController:(SCXCustomController *)sliderViewController sliderIndex:(NSInteger)index{

    
}
-(void)customSliderViewController:(SCXCustomController *)sliderViewController sliderOffset:(CGPoint)offset{
    self.headerScrollView.contentOfSet=offset;

}

@end
