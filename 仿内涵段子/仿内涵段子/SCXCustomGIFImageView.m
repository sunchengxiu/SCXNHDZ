//
//  SCXCustomGIFImageView.m
//  仿内涵段子
//
//  Created by 孙承秀 on 16/10/1.
//  Copyright © 2016年 孙先森丶. All rights reserved.
//

#import "SCXCustomGIFImageView.h"

@implementation SCXCustomGIFImageView
-(void)setProgress:(CGFloat)progress{
    _progress=progress;
    //NSLog(@"-------%f",progress);
    if (progress>=1.0) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [_shareLayer removeFromSuperlayer];
            _shareLayer=nil;
            return ;
        });
    }
    else{
       // dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            UIBezierPath *path=[UIBezierPath bezierPathWithRect:CGRectMake(0, 0, self.frame.size.width*progress, 15)];
            self.shareLayer.path=path.CGPath;
       // });
       
    }

}
-(CAShapeLayer *)shareLayer{
    if (!_shareLayer) {
        _shareLayer=[CAShapeLayer layer];
        [self.layer addSublayer:_shareLayer];
        _shareLayer.fillColor=[UIColor orangeColor].CGColor;
    }
    return _shareLayer;
}
@end
