//
//  SCXHomeTableViewCellFrame.h
//  NeiHan
//
//  Created by Charles on 16/8/30.
//  Copyright © 2016年 Charles. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "SCXHomeAllModel.h"

@interface SCXHomeTableViewCellFrame : NSObject {
    
}

/** 评论*/
@property (nonatomic, strong) NSMutableArray *commentFrameArray;
/** 关注*/
@property (nonatomic, assign) CGRect attBtnF;
/** 数量*/
@property (nonatomic, assign) CGRect countF;
/** 头像*/
@property (nonatomic, assign)  CGRect iconImgF;
/** 名字*/
@property (nonatomic, assign) CGRect nameLF;
/** 文本*/
@property (nonatomic, assign) CGRect contentLF;
/** 图片frame数组*/
@property (nonatomic, strong) NSMutableArray *imageFrameArray;
/** 大图*/
@property (nonatomic, assign) CGRect largeImageCoverF;
/** 视频封面*/
@property (nonatomic, assign) CGRect videoCoverF;
/** Gif图*/
@property (nonatomic, assign) CGRect gifCoverF;
@property (nonatomic, assign) CGRect essenceCoverF;
/** 热门标签*/
@property (nonatomic, assign) CGRect tagF;
/** 关闭*/
@property (nonatomic, assign) CGRect closeImgF;
/** 分类*/
@property (nonatomic, assign) CGRect version_BtnF;
/** 点赞*/
@property (nonatomic, assign) CGRect likeCountBtnF;
/** 踩*/
@property (nonatomic, assign) CGRect dontLikeCountBtnF;
/** 评论*/
@property (nonatomic, assign) CGRect commentCountBtnF;
/** 分享*/
@property (nonatomic, assign) CGRect shareBtnF;
/** 查看内涵精华*/
@property (nonatomic, assign) CGRect lookEssEnceF;
/** 底部视图*/
@property (nonatomic, assign) CGRect bottomViewF;
@property (nonatomic, assign) double cellHeight;
@property (nonatomic, strong)SCXHomeAllModel  *model;

- (void)setModel:(SCXHomeAllModel *)model isDetail:(BOOL)isDetail;

@end
