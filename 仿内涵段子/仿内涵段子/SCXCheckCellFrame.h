//
//  SCXCheckCellFrame.h
//  仿内涵段子
//
//  Created by 孙承秀 on 16/10/13.
//  Copyright © 2016年 孙先森丶. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SCXHomeServerModel.h"
#import "SCXHomeAllModel.h"
#import "SCXHomeGroupModel.h"
#import "SCXUtils.h"
#import "NSAttributedString+Size.h"
@interface SCXCheckCellFrame : NSObject

@property (nonatomic, strong) SCXHomeAllModel *model;
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
/** 举报*/
@property (nonatomic, assign) CGRect reportBtnF;
/** 顶部白色区域*/
@property (nonatomic, assign) CGRect topContentLF;
/** 容器*/
@property (nonatomic, assign) CGRect scrollViewF;
/** scrollView的contentSize*/
@property (nonatomic, assign) CGSize contentSize;
/** 喜欢*/
@property (nonatomic, assign) CGRect likeF;
/** 不喜欢*/
@property (nonatomic, assign) CGRect disLikeF;
/** 喜欢*/
@property (nonatomic, assign) CGRect likeLF;
/** 不喜欢*/
@property (nonatomic, assign) CGRect disLikeLF;
/** 动画*/
@property (nonatomic, assign) CGRect barF;
/** 高度*/
@property (nonatomic, assign) CGFloat cellHeight;
@end
