//
//  UIView+AnimationView.m
//  仿内涵段子
//
//  Created by 孙承秀 on 16/9/21.
//  Copyright © 2016年 孙先森丶. All rights reserved.
//

#import "UIView+AnimationView.h"
#import <objc/runtime.h>
const static char *animationViewKey;
@interface SCXAnimationView : UIView
@property(nonatomic,strong)UIImageView *imageView;
@property(nonatomic,strong)NSMutableArray *imageArray;
-(void)showInView:(UIView *)view;
-(void)stopAnimation;
@end
@implementation SCXAnimationView
-(instancetype)init{
    if (self=[super init]) {
        self.backgroundColor=[UIColor colorWithRed:0.1 green:0.1 blue:0.1 alpha:0.1];
        
    }
    return self;
}
/**懒加载*/
-(UIImageView *)imageView{
    if (_imageView==nil) {
        _imageView=[[UIImageView alloc] init];
        [self addSubview:_imageView];
        for (NSInteger i = 0; i < 17; i++) {
            UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"refreshjoke_loading_%ld", i % 17]];
            [self.imageArray addObject:image];
            self.imageView.animationDuration=1.0;
            self.imageView.animationRepeatCount=0;
            self.imageView.animationImages=self.imageArray;
        }
        
    }
    return _imageView;
}
-(NSMutableArray *)imageArray{
    if (_imageArray==nil) {
        _imageArray=[[NSMutableArray alloc]initWithCapacity:0];
    }
    return _imageArray;
}
#pragma mark -- 动画
-(void)showInView:(UIView *)view{
    
    if (view==nil) {
        view=[UIApplication sharedApplication ].keyWindow;
    }
    [view addSubview:self];
    self.frame=view.bounds;
    self.imageView.frame=CGRectMake(0, 0, 70, 100);
    
    self.imageView.center=self.center;
    
    [self.imageView startAnimating];
    
}
-(void)stopAnimation{
    [self.imageArray removeAllObjects];
    [self.imageView removeFromSuperview];
    self.imageView=nil;
    [self removeFromSuperview];
    
}
@end
@implementation UIView (AnimationView)
#pragma mark -- 运行时动态绑定
-(UIView *)animationView{
    return objc_getAssociatedObject(self, &animationViewKey);

}
-(void)setAnimationView:(UIView *)animationView{
    objc_setAssociatedObject(self, &animationViewKey, animationView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
-(void)showAnimationView{
    [self showAnimationViewWithFrame:[UIScreen mainScreen].bounds];
}
-(void)showAnimationViewWithFrame:(CGRect)frame{
    if (self.animationView==nil) {
        SCXAnimationView *animation=[[SCXAnimationView alloc]init];
        self.animationView=animation;
        animation.frame=frame;
        [self addSubview:animation];
        [animation showInView:self];
    }
}
-(void)hideAnimationView{
    if (self.animationView) {
        [self.animationView removeFromSuperview];
    }
}
@end
