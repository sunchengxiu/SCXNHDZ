//
//  SCXCostomAnimationView.m
//  仿内涵段子
//
//  Created by 孙承秀 on 16/9/20.
//  Copyright © 2016年 孙先森丶. All rights reserved.
//

#import "SCXCostomAnimationView.h"

@implementation SCXCostomAnimationView
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
