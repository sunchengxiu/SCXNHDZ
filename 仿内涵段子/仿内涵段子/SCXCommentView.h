//
//  SCXCommentView.h
//  仿内涵段子
//
//  Created by 孙承秀 on 16/10/2.
//  Copyright © 2016年 孙先森丶. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <UIImageView+WebCache.h>
#import "SCXHomeCommentModel.h"
#import "SCXUtils.h"
#import "UIView+SCXTap.h"
@class SCXHomeCommentModel;
@protocol SCXHomeConmmentDelegate;
@interface SCXCommentView : UIView

/**
 神评论Model
 */
@property(nonatomic,strong)SCXHomeCommentModel *commentModel;

/**
 神评论代理方法
 */
@property(nonatomic,weak)id <SCXHomeConmmentDelegate>commentDelegate;
/** 头像*/
@property (nonatomic, weak) UIImageView *iconImg;
/** 名字*/
@property (nonatomic, weak) UILabel *nameL;
/** 文本*/
@property (nonatomic, weak) UILabel *contentL;
/** 点赞*/
@property (nonatomic, weak) UIButton *likeCountBtn;
/** 分享*/
@property (nonatomic, weak) UIButton *shareBtn;
@end
@protocol SCXHomeConmmentDelegate <NSObject>

/**
 分享按钮代理方法

 @param commentView  神评论视图
 @param commentModel 神评论Model
 */
-(void)commentView:(SCXCommentView *)commentView shareWithCommentModel:(SCXHomeCommentModel *)commentModel;

/**
 回复代理方法·

 @param commentView  神评论视图
 @param commentModel 神评论Model
 */
-(void)commentView:(SCXCommentView *)commentView replayWithCommentModel:(SCXHomeCommentModel *)commentModel;

/**
 赞

 @param commentView  神评论视图
 @param commentModel 神评论Model
 */
-(void)commentView:(SCXCommentView *)commentView likeWithCommentModel:(SCXHomeCommentModel *)commentModel;

/**
 点击神评论用户头像代理方法

 @param commentView  神评论视图
 @param commentModel 神评论model
 */
-(void)commentView:(SCXCommentView *)commentView clickUserNameWithCommentModel:(SCXHomeCommentModel *)commentModel;



@end
