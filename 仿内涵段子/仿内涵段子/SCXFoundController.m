//
//  SCXFoundController.m
//  仿内涵段子
//
//  Created by 孙承秀 on 16/9/20.
//  Copyright © 2016年 孙先森丶. All rights reserved.
//

#import "SCXFoundController.h"
#import "SCXCustomSegmentView.h"
#import "SCXNearViewController.h"
@implementation SCXFoundController
-(void)viewDidLoad{
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor redColor];
    [self setUpView];
}
#pragma mark--创建视图
-(void)setUpView{

    SCXCustomSegmentView *segmentView=[[SCXCustomSegmentView alloc]initSegmentWithTitles:[NSArray arrayWithObjects:@"热吧",@"订阅", nil]];
    self.navigationItem.titleView=segmentView;
    segmentView.frame=CGRectMake(0, 0, 130, 35);
    segmentView.customSegmentViewButtonClickHandleBlock=^(SCXCustomSegmentView *segmentView,NSString *title,NSInteger currentIndex){
    
    
    };
    [segmentView clickDefault];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"foundsearch"] style:UIBarButtonItemStylePlain target:self action:@selector(searchItemClick)];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"nearbypeople"] style:UIBarButtonItemStylePlain target:self action:@selector(nearByItemClick)];
    
}
#pragma 搜索按钮点击事件
-(void)searchItemClick{

}
#pragma mark--附近按钮点击事件
-(void)nearByItemClick{
    SCXNearViewController *near=[[SCXNearViewController alloc]init];
    [self pushViewController:near];
}
@end
