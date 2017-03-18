//
//  SCXCheckCellFrame.m
//  仿内涵段子
//
//  Created by 孙承秀 on 16/10/13.
//  Copyright © 2016年 孙先森丶. All rights reserved.
//

#import "SCXCheckCellFrame.h"

@implementation SCXCheckCellFrame
- (NSMutableArray *)imageFrameArray {
    if (!_imageFrameArray) {
        _imageFrameArray = [NSMutableArray new];
    }
    return _imageFrameArray;
}

- (void)setModel:(SCXHomeAllModel *)model {
    _model = model;
    SCXHomeGroupModel *group = model.group;
    if (group == nil) {
        return ;
    }
    // 文本
    CGFloat contentX = 17;
    CGFloat contentW = ScreenWidth - 32;
    CGFloat contentH = [[SCXUtils attributeStringWithString:group.content withKeyWord:nil] heightWithConstrainedWidth:contentW] ;
    CGFloat contentY = 15;
    if (group.content.length == 0) {
        contentY = 8.0;
    }
    self.contentLF = CGRectMake(contentX, contentY, contentW, contentH);
    
    // 举报
    CGFloat reportBtnY = CGRectGetMaxY(self.contentLF) + 15;
    
    switch (group.media_type) {
        case SCXGroupMediaTypeImage: {
            CGFloat largeX = 20;
            CGFloat largeY = CGRectGetMaxY(self.contentLF) + 10;
            CGFloat largeW = ScreenWidth - 20 * 2;
            CGFloat largeH = largeW * group.large_image.height / group.large_image.width;
            self.largeImageCoverF = CGRectMake(largeX, largeY, largeW, largeH);
            reportBtnY = CGRectGetMaxY(self.largeImageCoverF) + 15;
        } break;
            
        case SCXGroupMediaTypeGIF: {
            CGFloat gifX = 20;
            CGFloat gifY = CGRectGetMaxY(self.contentLF) + 10;
            CGFloat gifW = ScreenWidth - 20 * 2;
            CGFloat gifH = gifW * group.large_image.height / group.large_image.width;
            self.gifCoverF = CGRectMake(gifX, gifY, gifW, gifH);
            reportBtnY = CGRectGetMaxY(self.gifCoverF) + 15;
        } break;
            
        case SCXGroupMediaTypeVideo: {
            CGFloat videoX = 20;
            CGFloat videoY = CGRectGetMaxY(self.contentLF) + 10;
            CGFloat videoW = ScreenWidth - 20 * 2;
            CGFloat videoH = videoW * group.video_720P.height / group.video_720P.width;
            self.videoCoverF = CGRectMake(videoX, videoY, videoW, videoH);
            reportBtnY = CGRectGetMaxY(self.videoCoverF) + 15;
        } break;
            
        case SCXGroupMediaTypeLittleImages: {
            [self.imageFrameArray removeAllObjects];
            if (group.large_image_list.count) {
                for (int i = 0; i < group.large_image_list.count; i++) {
                    int col = i % 3; // 第几列
                    int row = i / 3;
                    CGFloat margin = 15;
                    CGFloat imageW = (ScreenWidth - 15 * 4) / 3.0;
                    CGFloat imageX =  margin * (col + 1) + col * imageW;
                    CGFloat imageH = imageW;
                    CGFloat imageY = margin * (row + 1) + row * imageH + CGRectGetMaxY(self.contentLF) + 10;
                    CGRect imageRect = CGRectMake(imageX, imageY, imageW, imageH);
                    reportBtnY = CGRectGetMaxY(imageRect) + 15;
                    [self.imageFrameArray addObject:NSStringFromCGRect(imageRect)];
                }
            }
        } break;
            
        default:
            break;
    }
    
    CGFloat reportBtnX = 15;
    CGFloat reportBtnW = 50;
    CGFloat reportBtnH = 30;
    self.reportBtnF = CGRectMake(reportBtnX, reportBtnY, reportBtnW, reportBtnH);
    
    // 顶部白色区域
    CGFloat topContentLX = 0;
    CGFloat topContentLY = 0;
    CGFloat topContentLW = ScreenWidth;
    CGFloat topContentLH = CGRectGetMaxY(self.reportBtnF) + 10;
    self.topContentLF = CGRectMake(topContentLX, topContentLY, topContentLW, topContentLH);
    
    // 喜欢
    CGFloat likeX = 15;
    CGFloat likeY = CGRectGetMaxY(self.topContentLF) + 10;
    CGFloat likeW = 50;
    CGFloat likeH = 50;
    self.likeF = CGRectMake(likeX, likeY, likeW, likeH);
    
    // 喜欢
    CGFloat likeLX = likeX;
    CGFloat likeLY = CGRectGetMaxY(self.likeF) + 5;
    CGFloat likeLW = 50;
    CGFloat likeLH = 20;
    self.likeLF = CGRectMake(likeLX, likeLY, likeLW, likeLH);
    
    // 不喜欢
    CGFloat disLikeX = ScreenWidth - 15 - 50;
    CGFloat disLikeY = likeY;
    CGFloat disLikeW = likeW;
    CGFloat disLikeH = likeH;
    self.disLikeF = CGRectMake(disLikeX, disLikeY, disLikeW, disLikeH);
    
    // 不喜欢
    CGFloat disLikeLX = disLikeX;
    CGFloat disLikeLY = CGRectGetMaxY(self.disLikeF) + 5;
    CGFloat disLikeLW = 50;
    CGFloat disLikeLH = 20;
    self.disLikeLF = CGRectMake(disLikeLX, disLikeLY, disLikeLW, disLikeLH);
    
    // 动画
    CGFloat barX = CGRectGetMaxX(self.likeF) + 10;
    CGFloat barY = CGRectGetMinY(self.likeF);
    CGFloat barW = ScreenWidth - barX * 2.0;
    CGFloat barH = likeH;
    self.barF = CGRectMake(barX, barY, barW, barH);
    
    // 容器
    CGFloat scX = 0;
    CGFloat scY = 0;
    CGFloat scW = ScreenWidth;
    CGFloat scH = ScreenHeight - 64 - 49;
    self.scrollViewF = CGRectMake(scX, scY, scW, scH);
    self.cellHeight = scH;
    self.contentSize = CGSizeMake(ScreenWidth, CGRectGetMaxY(self.disLikeLF) + 10);
}
@end
