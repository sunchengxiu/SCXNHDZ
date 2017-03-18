//
//  SCXDetailCellFrame.m
//  仿内涵段子
//
//  Created by 孙承秀 on 16/10/10.
//  Copyright © 2016年 孙先森丶. All rights reserved.
//

#import "SCXDetailCellFrame.h"
#import <NSAttributedString+YYText.h>
#import "NSAttributedString+Size.h"
@implementation SCXDetailCellFrame
-(void)setCommentModel:(SCXHomeCommentModel *)commentModel{
    _commentModel = commentModel;
    
    // 头像
    CGFloat iconX = 20;
    CGFloat iconY = 15;
    CGFloat iconW = 40;
    CGFloat iconH = 40;
    self.iconImgF = CGRectMake(iconX, iconY, iconW, iconH);
    
    // 名字
    CGFloat nameH = 18;
    CGFloat nameX = CGRectGetMaxX(self.iconImgF) + 10;
    CGFloat nameY = 15;
    CGFloat nameW = ScreenWidth - nameX - 10 - 30;
    self.nameLF = CGRectMake(nameX, nameY, nameW, nameH);
    
    // 分享
    CGFloat shareW = (ScreenWidth - 20 ) / 7.0;
    CGFloat shareX = ScreenWidth - shareW - 15;
    CGFloat shareY = nameY;
    CGFloat shareH = nameH;
    self.shareBtnF = CGRectMake(shareX, shareY, shareW, shareH);
    
    // 喜欢
    CGFloat likeBtnY = shareY;
    CGFloat likeBtnW = shareW;
    CGFloat likeBtnX = CGRectGetMinX(self.shareBtnF) - shareW - 15;
    CGFloat likeBtnH = shareH;
    self.likeCountBtnF = CGRectMake(likeBtnX, likeBtnY, likeBtnW, likeBtnH);
    
    // 时间
    CGFloat timeX = nameX;
    CGFloat timeY = CGRectGetMaxY(self.nameLF) + 4;
    CGFloat timeW = ScreenWidth - timeX;
    CGFloat timeH = 15;
    self.timeLF = CGRectMake(timeX, timeY, timeW, timeH);
    CGFloat contentX = nameX;
    CGFloat contentY = CGRectGetMaxY(self.iconImgF) + 2;
    CGFloat contentW = ScreenWidth - nameX - 15;
    NSMutableString *content=[[NSMutableString alloc]initWithString:commentModel.text];
    NSMutableArray *arr=[[NSMutableArray alloc]initWithCapacity:0];
    for (SCXHomeCommentModel *model in commentModel.reply_comments) {
        if (model.user_name&&model.text) {
            NSString *userName=[NSString stringWithFormat:@"//%@:",model.user_name];
            [content appendString:userName];
            [content appendString:model.text];
            [arr addObject:userName];
        }
    }
    NSMutableAttributedString *attributeString=[[NSMutableAttributedString alloc]initWithString:content];
    [attributeString yy_setFont:[UIFont systemFontOfSize:16] range:NSMakeRange(0, attributeString.length)];
    CGFloat height=[attributeString heightWithConstrainedWidth:contentW];
    CGFloat contentH=height;
    self.contentLF=CGRectMake(contentX, contentY, contentW, contentH);
    self.cellHeight=CGRectGetMaxY(_contentLF)+10;
   

}
@end
