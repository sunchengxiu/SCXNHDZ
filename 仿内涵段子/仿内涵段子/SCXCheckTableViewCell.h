//
//  SCXCheckTableViewCell.h
//  仿内涵段子
//
//  Created by 孙承秀 on 16/10/13.
//  Copyright © 2016年 孙先森丶. All rights reserved.
//

#import "SCXBaseTableViewCell.h"
#import "SCXBaseImageView.h"
#import "SCXCustomGIFImageView.h"
#import "SCXCheckProgressBar.h"
#import "SCXCheckCellFrame.h"
#import "SCXElementGroupLargeImageUrl.h"
#import <UIImageView+WebCache.h>
#import "UIButton+Addition.h"
#import "UIView+Layer.h"
@protocol SCXCheckTableViewCellDelegate;
@interface SCXCheckTableViewCell : UICollectionViewCell
/** 滚动视图(容器)*/
@property (nonatomic, weak) UIScrollView *scrollView;
/** 文本*/
@property (nonatomic, weak) UILabel *contentL;
/** 顶部白色区域*/
@property (nonatomic, weak) UIView *topContentL;
/** 举报*/
@property (nonatomic, weak) UIButton *reportBtn;
/** 大图*/
@property (nonatomic, weak) SCXBaseImageView *largeImageCover;
/** 视频封面*/
@property (nonatomic, weak) SCXBaseImageView *videoCover;
/** Gif图*/
@property (nonatomic, weak) SCXCustomGIFImageView *gifCover;
/** 喜欢*/
@property (nonatomic, weak) UIButton *likeBtn;
/** 喜欢*/
@property (nonatomic, weak) UILabel *likeL;
/** 不喜欢*/
@property (nonatomic, weak) UIButton *disLikeBtn;
/** 不喜欢*/
@property (nonatomic, weak) UILabel *disLikeL;
/** 底部bar*/
@property (nonatomic, weak) SCXCheckProgressBar *bar;
@property(nonatomic,strong)SCXCheckCellFrame  *cellFrame;
@property(nonatomic,weak)id <SCXCheckTableViewCellDelegate>delegate;
@end
@protocol SCXCheckTableViewCellDelegate <NSObject>

/** 点击浏览大图*/
- (void)checkTableViewCell:(SCXCheckTableViewCell *)cell
         didClickImageView:(UIImageView *)imageView
              currentIndex:(NSInteger)currentIndex
                      urls:(NSArray <NSURL *>*)urls;

/** 点击举报*/
- (void)checkTableViewCell:(SCXCheckTableViewCell *)cell didClickReport:(BOOL)didClickReport;

/** 点击喜欢和不喜欢*/
- (void)checkTableViewCell:(SCXCheckTableViewCell *)cell didFinishLoadingHandleWithLikeFlag:(BOOL)likeFlag;
@end
