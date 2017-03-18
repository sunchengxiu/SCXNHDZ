//
//  SCXCustomScrollViewItemLabel.m
//  仿内涵段子
//
//  Created by 孙承秀 on 16/10/11.
//  Copyright © 2016年 孙先森丶. All rights reserved.
//

#import "SCXCustomScrollViewItemLabel.h"

@implementation SCXCustomScrollViewItemLabel

-(void)setProgress:(CGFloat)progress{
    _progress=progress;
    [self setNeedsDisplay];
}
-(void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    [_fillColor set];
    CGRect newRect=rect;
    newRect.size.width=rect.size.width*_progress;
    UIRectFillUsingBlendMode(newRect, kCGBlendModeSourceIn);

}

@end
