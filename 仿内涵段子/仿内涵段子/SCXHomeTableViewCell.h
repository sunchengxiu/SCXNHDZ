//
//  SCXHomeTableViewCell.h
//  仿内涵段子
//
//  Created by 孙承秀 on 16/9/28.
//  Copyright © 2016年 孙先森丶. All rights reserved.
//

#import "SCXBaseTableViewCell.h"
#import "SCXHomeAllModel.h"
#import "SCXHomeGroupModel.h"
#import "SCXBaseImageView.h"
#import "SCXCustomGIFImageView.h"
#import "SCXCustomVideoImageView.h"
#import "SCXBaseImageView.h"
#import "SCXCommentView.h"
#import "SCXHomeTableViewCellFrame.h"
#import "SCXUserInfoModel.h"
typedef NS_ENUM(NSInteger,SCXHomeCellDidClickItemType){
    SCXHomeCellDidClickItemTypeLIke=1,
    SCXHomeCellDidClickItemTypeDontLike,
    SCXHomeCellDidClickItemTypeComment,
    SCXHomeCellDidClickItemTypeShare

};
@protocol SCXHomeTableViewCellDelegate;
@interface SCXHomeTableViewCell : SCXBaseTableViewCell
/** 头像*/
@property (nonatomic, weak) SCXBaseImageView *iconImg;
/** 名字*/
@property (nonatomic, weak) UILabel *nameL;
/** 文本*/
@property (nonatomic, weak) UILabel *contentL;
/** 关闭*/
@property (nonatomic, weak) SCXBaseImageView *closeImg;
/** 分类*/
@property (nonatomic, weak) UIButton *version_Btn;
/** 关注*/
@property (nonatomic, weak) UIButton *attBtn;
/** 点赞*/
@property (nonatomic, weak) UIButton *likeCountBtn;
/** 踩*/
@property (nonatomic, weak) UIButton *dontLikeCountBtn;
/** 评论*/
@property (nonatomic, weak) UIButton *commentCountBtn;
/** 分享*/
@property (nonatomic, weak) UIButton *shareBtn;
/** 底部*/
@property (nonatomic, weak) UIView *bottomView;
/** 热门标签*/
@property (nonatomic, weak) UILabel *tagL;
/** 大图*/
@property (nonatomic, weak) SCXBaseImageView *largeImageCover;
/** 视频封面*/
@property (nonatomic, weak) SCXCustomVideoImageView *videoCover;
/** GIF大图*/
@property (nonatomic, weak) SCXCustomGIFImageView *gifCover;
/** 高亮的关键字*/
@property (nonatomic, copy) NSString *keyWord;
/** 精华*/
@property (nonatomic, weak) SCXBaseImageView *essImgCover;
/** 查看内涵精华*/
@property (nonatomic, weak) UIButton *lookEssBtn;
/** 详情页面*/
@property (nonatomic, assign) BOOL isDetail;
/**
 是否是home
 */
@property(nonatomic,assign)BOOL isFromHomeController;;

/**
 homeCellFrame
 */
@property(nonatomic,strong)SCXHomeTableViewCellFrame *cellFrame;

@property(nonatomic,weak)id <SCXHomeTableViewCellDelegate> delegate;
- (void)didDigg ;
- (void)didBury ;
- (void)cancelDigg;
- (void)cancelBury;
- (void)setCellFrame:(SCXHomeTableViewCellFrame *)cellFrame isDetail:(BOOL)isDetail ;
@end
@protocol SCXHomeTableViewCellDelegate <NSObject>

/**
 点击视频

 @param homeCEll        播放视频的cell
 @param videoUrl        视频URL
 @param videoImageVideo 视频所在的IMageView
 */
-(void)homeTableViewCell:(SCXHomeTableViewCell *)homeCEll withVideoUrl:(NSString *)videoUrl withVideoImageView:(SCXBaseImageView *)videoImageVideo;

/**
 查看点击的图片

 @param homeCEll  图片所在的cell
 @param imageView 图片的imageView
 @param index     当前点击的图片的index
 @param urls      图片的url数组
 */
-(void)homeTableViewCell:(SCXHomeTableViewCell *)homeCEll withImageView:(SCXBaseImageView *)imageView currentIndex:(NSInteger )index urls:(NSArray *)urls;
-(void)homeTableViewCellDidClickCloseButtonHandleWithHomentableViewCell:(SCXHomeTableViewCell *)cell;
-(void)homeTableViewCellDidClickIconImage:(SCXHomeTableViewCell *)cell andUserModel:(SCXUserInfoModel *)userModel;
-(void)SCXHomeTableViewCell:(SCXHomeTableViewCell *)cell didClickItemtype:(SCXHomeCellDidClickItemType)type;
@end
