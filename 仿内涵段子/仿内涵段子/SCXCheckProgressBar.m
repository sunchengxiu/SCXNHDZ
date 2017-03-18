//
//  SCXCheckProgressBar.m
//  仿内涵段子
//
//  Created by 孙承秀 on 16/10/13.
//  Copyright © 2016年 孙先森丶. All rights reserved.
//

#import "SCXCheckProgressBar.h"

@implementation SCXCheckProgressBar
+(instancetype)bar{
    return [[self alloc]init];
}
-(void)showLeftAndRightLabelAnimation{
    [self.leftL.layer removeAllAnimations];
    [self.rightL.layer removeAllAnimations];
    self.leftL.frame = CGRectMake(5, self.frame.size.height / 2.0 - 15, 30, 10);
    self.rightL.frame = CGRectMake(self.frame.size.width - 35, self.frame.size.height / 2.0 - 15, 30, 10);
    CABasicAnimation *animation=[CABasicAnimation animationWithKeyPath:@"transform.scale"];
    animation.fromValue=@(0.5);
    animation.toValue=@(1.0);
    animation.duration=0.2f;
    /**
     *  CA_EXTERN NSString * const kCAMediaTimingFunctionLinear
     *  匀速
     CA_EXTERN NSString * const kCAMediaTimingFunctionEaseIn
     *  先慢后快
     CA_EXTERN NSString * const kCAMediaTimingFunctionEaseOut
     *  线快后慢
     CA_EXTERN NSString * const kCAMediaTimingFunctionEaseInEaseOut
     *  嫌慢后快再慢
     CA_EXTERN NSString * const kCAMediaTimingFunctionDefault
     *  动画中间比较快
     */
    animation.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [self.rightL.layer addAnimation:animation forKey:nil];
    [self.leftL.layer addAnimation:animation forKey:nil];
    [self performSelector:@selector(handleBlock) withObject:nil afterDelay:0.5];

}
-(void)setLeftScale:(CGFloat)leftScale{
    _leftScale=leftScale;
    NSInteger leftFloat=leftScale*100;
    NSString *text=[NSString stringWithFormat:@"%ld%%",leftFloat];
    self.leftL.text=text;
    UIRectCorner rectCorner=UIRectCornerAllCorners;
    CGFloat height=10;
    if (leftScale==1.0) {
        rectCorner=UIRectCornerAllCorners;
    }
    else{
        //设置指定位置的圆角
        rectCorner=UIRectCornerTopLeft|UIRectCornerBottomLeft;
    }
    UIBezierPath *bezierPathOne=[UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, self.frame.size.height/2-height/2, 0, height) byRoundingCorners:rectCorner cornerRadii:CGSizeMake(5.0f, 5.0f)];
    UIBezierPath *bezierPathtwo=[UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, self.frame.size.height/2-height/2, self.leftScale*self.frame.size.width, height) byRoundingCorners:rectCorner cornerRadii:CGSizeMake(5, 5)];
    CGFloat durtion=0.8;
    [self performSelector:@selector(showLeftAndRightLabelAnimation) withObject:nil afterDelay:durtion];
    CABasicAnimation *animation=[CABasicAnimation animationWithKeyPath:@"path"];
    animation.removedOnCompletion=NO;
   // animation.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.duration=0.8;
    /**
     *  fillMode的作用就是决定当前对象过了非active时间段的行为. 比如动画开始之前,动画结束之后。如果是一个动画CAAnimation,则需要将其removedOnCompletion设置为NO,要不然fillMode不起作用.
     
     下面来讲各个fillMode的意义
     kCAFillModeRemoved 这个是默认值,也就是说当动画开始前和动画结束后,动画对layer都没有影响,动画结束后,layer会恢复到之前的状态
     kCAFillModeForwards 当动画结束后,layer会一直保持着动画最后的状态
     kCAFillModeBackwards 这个和kCAFillModeForwards是相对的,就是在动画开始前,你只要将动画加入了一个layer,layer便立即进入动画的初始状态并等待动画开始.你可以这样设定测试代码,将一个动画加入一个layer的时候延迟5秒执行.然后就会发现在动画没有开始的时候,只要动画被加入了layer,layer便处于动画初始状态
     kCAFillModeBoth 理解了上面两个,这个就很好理解了,这个其实就是上面两个的合成.动画加入后开始之前,layer便处于动画初始状态,动画结束后layer保持动画最后的状态.
     */
    animation.fillMode=kCAFillModeForwards;
    animation.fromValue=(__bridge id _Nullable)(bezierPathOne.CGPath);
    animation.toValue=(__bridge id _Nullable)(bezierPathtwo.CGPath);
    [self.leftLayer addAnimation:animation forKey:nil];
}
-(void)setRightScale:(CGFloat)rightScale{
    _rightScale=rightScale;
    NSInteger rightData=rightScale*100;
    NSString *text=[NSString stringWithFormat:@"%ld%%",rightData];
    self.rightL.text=text;
    CGFloat height=10;
    UIRectCorner rectCorner=UIRectCornerAllCorners;
    if (rightScale==1.0) {
        rectCorner=UIRectCornerAllCorners;
    }
    else{
        rectCorner=UIRectCornerTopRight|UIRectCornerBottomRight;
    }
    UIBezierPath *bezierPathTwo=[UIBezierPath bezierPathWithRoundedRect:CGRectMake(self.frame.size.width * ( 1 - self.rightScale), self.frame.size.height / 2.0 - height / 2.0, self.frame.size.width * self.rightScale, height) byRoundingCorners:rectCorner cornerRadii:CGSizeMake(5, 5)];
    UIBezierPath *bezierPath=[UIBezierPath bezierPathWithRoundedRect:CGRectMake(self.frame.size.width , self.frame.size.height / 2.0 - height / 2.0, 0, height) byRoundingCorners:rectCorner cornerRadii:CGSizeMake(5, 5)];
    CABasicAnimation *animation=[CABasicAnimation animationWithKeyPath:@"path"];
    animation.duration=0.8;
    animation.removedOnCompletion=NO;
    animation.fillMode=kCAFillModeForwards;
    animation.fromValue=(__bridge id _Nullable)(bezierPath.CGPath);
    animation.toValue=(__bridge id _Nullable)(bezierPathTwo.CGPath);
    [self.rightLayer addAnimation:animation forKey:nil];
}
-(void)setUpCheckTableViewProgressBarFinishLoadingHandle:(SCXCheckTableViewProgressBarFinishLoadingHandle)finishLoadingHandle{

    _handle=finishLoadingHandle;
}
-(void)handleBlock{
    if (self.handle) {
        self.handle();
    }

}
- (UILabel *)leftL {
    if (!_leftL) {
        UILabel *label = [[UILabel alloc] init];
        [self addSubview:label];
        _leftL = label;
        label.font = kFont(11);
        label.textColor = [UIColor colorWithRed:1.00f green:0.50f blue:0.64f alpha:1.00f];
    }
    return _leftL;
}

- (UILabel *)rightL {
    if (!_rightL) {
        UILabel *label = [[UILabel alloc] init];
        [self addSubview:label];
        _rightL = label;
        label.font = kFont(11);
        label.textColor = [UIColor colorWithRed:0.48f green:0.82f blue:0.90f alpha:1.00f];
    }
    return _rightL;
}

- (CAShapeLayer *)leftLayer {
    if (!_leftLayer) {
        CAShapeLayer *layer = [CAShapeLayer layer];
        [self.layer addSublayer:layer];
        _leftLayer = layer;
        layer.fillColor = [UIColor colorWithRed:1.00f green:0.50f blue:0.64f alpha:1.00f].CGColor;
    }
    return _leftLayer;
}

- (CAShapeLayer *)rightLayer {
    if (!_rightLayer) {
        CAShapeLayer *layer = [CAShapeLayer layer];
        [self.layer addSublayer:layer];
        _rightLayer = layer;
        layer.fillColor = [UIColor colorWithRed:0.48f green:0.82f blue:0.90f alpha:1.00f].CGColor;
    }
    return _rightLayer;
}

@end
