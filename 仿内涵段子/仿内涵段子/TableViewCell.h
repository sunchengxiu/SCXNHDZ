//
//  TableViewCell.h
//  仿内涵段子
//
//  Created by 孙承秀 on 16/10/5.
//  Copyright © 2016年 孙先森丶. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SCXHomeAllModel.h"
#import "SCXHomeGroupModel.h"
#import "SCXBaseImageView.h"
#import "SCXCustomGIFImageView.h"
#import "SCXCustomVideoImageView.h"
#import "SCXBaseImageView.h"
#import "SCXCommentView.h"
@interface TableViewCell : UITableViewCell
/**
 *  精华imageView
 */
@property(nonatomic,strong)UIImageView *essenceImageView;
/**
 *  精华Button
 */
@property(nonatomic,strong)UIButton *essenceButton;
/**
 *  底部视图
 */
@property(nonatomic,strong)UIView *bottomView;
/**
 *  热门label
 */
@property(nonatomic,strong)UILabel *hotLabel;
/**
 *  头像
 */
@property(nonatomic,strong)SCXBaseImageView *iconImageView;
/**
 *  名字
 */
@property(nonatomic,strong)UILabel *nameLabel;
/**
 *  分类
 */
@property(nonatomic,strong)UIButton *versionButton;
/**
 *  文本
 */
@property(nonatomic,strong)UILabel *contentLabel;
/**
 *  大图
 */
@property(nonatomic,strong)SCXBaseImageView *largeImageView;
/**
 *  GIF
 */
@property(nonatomic,strong)SCXCustomGIFImageView *GIFImageView;

/**
 video视图
 */
@property(nonatomic,strong)SCXCustomVideoImageView *videoImageView;

/**
 配置数据
 
 @param model model
 */
-(void)configFrameWithModel:(SCXHomeAllModel *)model;

/**
 关注按钮
 */
@property(nonatomic,strong)UIButton *likeButton;

/**
 是否是详情页
 */
@property(nonatomic,assign)BOOL isDetail;

/**
 用来判断是否有关闭的按钮
 */
@property(nonatomic,assign)BOOL isFromHomeController;

/**
 关闭按钮
 */
@property(nonatomic,strong)SCXBaseImageView *closeImageView;

/**
 神评论视图
 */
@property(nonatomic,strong)SCXCommentView  *commentView;\

/**
 赞
 */
@property(nonatomic,strong)UIButton *supportButton;

/**
 用来控制全局的View线，无用，主要用于masonry适配
 */
@property(nonatomic,strong)UIView *lineView;

/**
 踩
 */
@property(nonatomic,strong)UIButton  *dontLikebutton;

/**
 评论
 */
@property(nonatomic,strong)UIButton *commentButton;

/**
 分享
 */
@property(nonatomic,strong)UIButton *shareButton;

/**
 底部视图
 */
@property(nonatomic,strong)UIView *bottomLineView;

/**
 获取行高
 
 @param tableView tableView
 @param model     数据源
 
 @return 行高
 */
+(CGFloat)heightForRowWithTableView:(UITableView *)tableView andModel:(SCXHomeAllModel *)model;
-(void)setData:(SCXHomeAllModel *)model;
@property(nonatomic,strong)SCXCommentView *lastCommentView;
@property(nonatomic,assign)CGFloat lastPoint;
@property(nonatomic,strong)UIView *lastView;;

@end
