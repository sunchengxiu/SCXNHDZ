//
//  UIViewController+SCXLoadingView.m
//  仿内涵段子
//
//  Created by 孙承秀 on 16/9/21.
//  Copyright © 2016年 孙先森丶. All rights reserved.
//

#import "UIViewController+SCXLoadingView.h"
#import <objc/runtime.h>
#import "UIView+Frame.h"
const static char *loadingViewKey;
@interface UIViewControllerLoadView : UIView
@property(nonatomic,strong)UILabel *label;
@property(nonatomic,strong)UIActivityIndicatorView *activityView;
@end
@implementation UIViewControllerLoadView
#pragma mark--懒加载
-(UILabel *)label{
    if (_label==nil) {
        _label=[[UILabel alloc]init];
        [self addSubview:_label];
        [_label setText:@"正在加载..."];
        [_label setTextColor:[UIColor blackColor]];
        [_label setFont:[UIFont systemFontOfSize:13]];
    }
    return _label;
}
-(UIActivityIndicatorView *)activityView{
    if (_activityView==nil) {
        _activityView=[[UIActivityIndicatorView alloc]init];
        [self addSubview:_activityView];
        [_activityView setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleGray];
    }
    return _activityView;
}
- (void)startAnimating {
    [self.activityView startAnimating];
}

- (void)layoutSubviews {
    [super layoutSubviews];

    self.label.frame = CGRectMake(self.width / 2.0 - 30, self.height / 2.0 - 40, 80, 40);
    self.activityView.frame = CGRectMake(self.width / 2.0 - 70, self.label.y, 40, 40);
}

@end
@implementation UIViewController (SCXLoadingView)
#pragma mark -- runtime动态绑定机制
-(UIView *)loadingView{
    return  objc_getAssociatedObject(self, &loadingViewKey  );
}
-(void)setLoadingView:(UIView *)loadView{
    return objc_setAssociatedObject(self, &loadingViewKey, loadView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
-(void)showLoadingView{
    [self showLoadingViewWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 44)];
}
-(void)showLoadingViewWithFrame:(CGRect)frame{
    if (!self.loadingView) {
        UIViewControllerLoadView *loadingView=[[UIViewControllerLoadView alloc]init];
        self.loadingView = loadingView;
        loadingView.frame = frame;
       // loadingView.backgroundColor=[UIColor redColor];
        [self.view addSubview:self.loadingView];
        loadingView.center = self.view.center;
        loadingView.centerY = self.view.centerY - 50;
        [loadingView startAnimating];
    }
}
-(void)hideLoadingView{
    if (self.loadingView) {
        [self.loadingView removeFromSuperview];
    }
}
@end
