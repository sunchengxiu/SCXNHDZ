//
//  UIView+SCXTap.h
//  仿内涵段子
//
//  Created by 孙承秀 on 16/10/1.
//  Copyright © 2016年 孙先森丶. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (SCXTap)
/**
 *  为View添加手势操作
 *
 *  @param tapHandleBlock 手势回调
 */
-(void)setTapWithHandleBlock:(void(^)(void))tapHandleBlock;
@end
