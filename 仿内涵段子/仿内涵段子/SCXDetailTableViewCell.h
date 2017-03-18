//
//  SCXDetailTableViewCell.h
//  仿内涵段子
//
//  Created by 孙承秀 on 16/10/10.
//  Copyright © 2016年 孙先森丶. All rights reserved.
//

#import "SCXBaseTableViewCell.h"
#import "SCXDetailCellFrame.h"
#import "SCXHomeAllModel.h"
#import "SCXHomeCommentModel.h"
#import "SCXBaseImageView.h"
#import <YYLabel.h>
@protocol SCXDetailCellDelegate;
@interface SCXDetailTableViewCell : SCXBaseTableViewCell<UIGestureRecognizerDelegate>
@property (nonatomic, strong) SCXDetailCellFrame *cellFrame;
@property(nonatomic,weak)id <SCXDetailCellDelegate>delegate;
/** 头像*/
@property (nonatomic, weak) SCXBaseImageView *iconImg;
/** 名字*/
@property (nonatomic, weak) UILabel *nameL;
/** 文本*/
@property (nonatomic, weak) YYLabel *contentL;
/** 时间*/
@property (nonatomic, weak) UILabel *timeL;
/** 点赞*/
@property (nonatomic, weak) UIButton *likeCountBtn;
/** 分享*/
@property (nonatomic, weak) UIButton *shareBtn;
@end
@protocol SCXDetailCellDelegate <NSObject>

-(void)detailTableViewCell:(SCXDetailTableViewCell *)cell didClickShareButton:(SCXHomeCommentModel *)commentModel;
-(void)detailTableViewCell:(SCXDetailTableViewCell *)cell didClickLikeButton:(SCXHomeCommentModel *)commentModel;
-(void)detailTableViewCell:(SCXDetailTableViewCell *)cell didClickUserNameButton:(SCXHomeCommentModel *)commentModel;
-(void)detailTableViewCell:(SCXDetailTableViewCell *)cell didClickReplayButton:(SCXHomeCommentModel *)commentModel;
@end
