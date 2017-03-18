//
//  UIView+SCXTap.m
//  仿内涵段子
//
//  Created by 孙承秀 on 16/10/1.
//  Copyright © 2016年 孙先森丶. All rights reserved.
//

#import "UIView+SCXTap.h"
#import <objc/runtime.h>
static const char *tapKey;
static const char *blockKey;
@implementation UIView (SCXTap)
-(void)setTapWithHandleBlock:(void(^)(void))tapHandleBlock{
    self.userInteractionEnabled=YES;
    UITapGestureRecognizer *tap=objc_getAssociatedObject(self, &tapKey);
    if (tap==nil) {
        tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapGestureHandle:)];
        [self addGestureRecognizer:tap];
        objc_setAssociatedObject(self, &tapKey, tap, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    objc_setAssociatedObject(self, &blockKey, tapHandleBlock, OBJC_ASSOCIATION_RETAIN_NONATOMIC);

}
-(void)tapGestureHandle:(UITapGestureRecognizer *)tap{
    if (tap.state==UIGestureRecognizerStateRecognized) {
        void (^handle)(void)=objc_getAssociatedObject(self, &blockKey);
        if (handle) {
            handle();
        }
    }
    

}
@end
