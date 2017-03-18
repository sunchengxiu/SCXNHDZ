//
//  SCXCostomAnimationView.h
//  仿内涵段子
//
//  Created by 孙承秀 on 16/9/20.
//  Copyright © 2016年 孙先森丶. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SCXCostomAnimationView : UIView
@property(nonatomic,strong)UIImageView *imageView;
@property(nonatomic,strong)NSMutableArray *imageArray;
-(void)showInView:(UIView *)view;
-(void)stopAnimation;
@end
