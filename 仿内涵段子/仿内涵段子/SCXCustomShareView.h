//
//  SCXCustomShareView.h
//  仿内涵段子
//
//  Created by 孙承秀 on 16/10/12.
//  Copyright © 2016年 孙先森丶. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SCXShareManager.h"
#import "FXBlurView.h"
typedef NS_ENUM(NSInteger,SCXShareViewType) {
SCXShareViewTypeShowCopyAndCollect,
    SCXShareViewTypeDontShowCopyAndCollect


};
@class SCXCustomShareView;
typedef void(^SCXShareViewDidClickShareHandBlock)(SCXCustomShareView * shareView,NSString *title,NSInteger index,SCXShareManagerType type);
typedef void(^SCXShareViewDidClickBottomViewHandleblock)(SCXCustomShareView *shareView,NSString *title,NSInteger index);
@interface SCXCustomShareView : UIView
+(instancetype)shareViewWithType:(SCXShareViewType)type hasrepinFlag:(BOOL)hasRepinFlag;
+(instancetype)shareViwWithType:(SCXShareViewType)type;
-(void)showInView:(UIView *)view;
-(void)dismiss;
-(void)dismissWithBlock:(void (^)())block;
-(void)setUpDidClickShareHandBlock:(SCXShareViewDidClickShareHandBlock)shareBlock;
-(void)setUpDidClickBottomHandleBlock:(SCXShareViewDidClickBottomViewHandleblock)bottomBlock;
/** 分享到*/
@property (nonatomic, weak) UILabel *titleL;
/** 背景视图*/
@property (nonatomic, weak) UIView *bgView;
/** 取消*/
@property (nonatomic, weak) UIButton *cancelBtn;
/** 标题数组*/
@property (nonatomic, strong) NSArray *titleArray;
/** 图片数组*/
@property (nonatomic, strong) NSArray *imageArray;
@property (nonatomic, strong) NSArray *bottomTitleArray;

@property (nonatomic, strong) NSArray *bottomImageArray;
@property (nonatomic, weak) UIView *contentView;
@property (nonatomic, assign) SCXShareViewType type;
@property(nonatomic,strong)FXBlurView *blurView;

/** 是否已经收藏*/
@property (nonatomic, assign) BOOL hasRepinFlag;
@property(nonatomic,copy)SCXShareViewDidClickShareHandBlock shareBlock;
@property(nonatomic,copy)SCXShareViewDidClickBottomViewHandleblock bottomBlock;

@end
