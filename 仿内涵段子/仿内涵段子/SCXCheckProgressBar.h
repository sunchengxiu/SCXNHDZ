//
//  SCXCheckProgressBar.h
//  仿内涵段子
//
//  Created by 孙承秀 on 16/10/13.
//  Copyright © 2016年 孙先森丶. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^SCXCheckTableViewProgressBarFinishLoadingHandle)();
@interface SCXCheckProgressBar : UIView
+ (instancetype)bar;

// leftScale + rightScale = 1
@property (nonatomic, assign) CGFloat leftScale;
@property (nonatomic, assign) CGFloat rightScale;
@property (nonatomic, weak) UILabel *leftL;
@property (nonatomic, weak) UILabel *rightL;
@property (nonatomic, weak) CAShapeLayer *leftLayer;
@property (nonatomic, weak) CAShapeLayer *rightLayer;
@property(nonatomic,strong)SCXCheckTableViewProgressBarFinishLoadingHandle handle;
/** 加载loading完毕时候的回调*/
- (void)setUpCheckTableViewProgressBarFinishLoadingHandle:(SCXCheckTableViewProgressBarFinishLoadingHandle)finishLoadingHandle;

@end
