//
//  SCXDetailTableViewCell.m
//  仿内涵段子
//
//  Created by 孙承秀 on 16/10/10.
//  Copyright © 2016年 孙先森丶. All rights reserved.
//

#import "SCXDetailTableViewCell.h"
#import "NSString+Addition.h"
#import <UIImageView+WebCache.h>
#import <NSAttributedString+YYText.h>
#import "UIView+SCXTap.h"
@implementation SCXDetailTableViewCell
-(void)setCellFrame:(SCXDetailCellFrame *)cellFrame{
    _cellFrame=cellFrame;
    SCXHomeCommentModel *model=cellFrame.commentModel;
    
    // 头像
    self.iconImg.frame = cellFrame.iconImgF;
    self.iconImg.layer.cornerRadius = cellFrame.iconImgF.size.height / 2.0;
    [self.iconImg sd_setImageWithURL:[NSURL URLWithString:model.user_profile_image_url]];
    
    // 名字
    self.nameL.frame = cellFrame.nameLF;
    self.nameL.text = model.user_name;
    
    // 时间
    self.timeL.frame = cellFrame.timeLF;
    self.timeL.text = [[NSString stringWithFormat:@"%ld",(model.create_time)] convertTimesTampWithDateFormat:@"yyyy-MM-dd HH:mm"];
    NSMutableString *content=[[NSMutableString alloc]initWithString:model.text];
    NSMutableArray *replayArray=[[NSMutableArray alloc]initWithCapacity:0];
    if (model.reply_comments.count) {
        for (SCXHomeCommentModel *commentModel in model.reply_comments) {
            if (commentModel.user_name&&commentModel.text) {
                NSString *replayName=[NSString stringWithFormat:@"@%@:",commentModel.user_name];
                [replayArray addObject:replayName];
                [content appendString:replayName];
                [content appendString:commentModel.text];
            }
            
        }
    }
    NSMutableAttributedString *attributeString=[[NSMutableAttributedString alloc]initWithString:content];
    [attributeString yy_setFont:kFont(16) range:NSMakeRange(0, attributeString.length)];
    [attributeString yy_setColor:kCommonBlackColor range:NSMakeRange(0, attributeString.length)];
    __block typeof(self)weakSelf=self;
    for (NSString *name in replayArray) {
        NSRange range=[content rangeOfString:[name substringToIndex:name.length-1] ];
        if (range.location!=NSNotFound) {
            [attributeString yy_setTextHighlightRange:range color:kCommonHighLightRedColor backgroundColor:nil userInfo:nil tapAction:^(UIView *containerView, NSAttributedString *text, NSRange range, CGRect rect) {
                if ([weakSelf.delegate respondsToSelector:@selector(detailTableViewCell:didClickUserNameButton:)]) {
                    [weakSelf.delegate detailTableViewCell:weakSelf didClickUserNameButton:model];
                }
            } longPressAction:^(UIView *containerView, NSAttributedString *text, NSRange range, CGRect rect) {
                
            }];
        }
    }
    self.contentL.frame=cellFrame.contentLF;
    self.contentL.attributedText=attributeString;
}
// 分享
- (void)shareBtnClick:(UIButton *)btn {
    if ([self.delegate respondsToSelector:@selector(detailTableViewCell:didClickShareButton:)]) {
        [self.delegate detailTableViewCell:self didClickShareButton:self.cellFrame.commentModel];
    }
}

// 点赞
- (void)likeCountBtnClick:(UIButton *)btn {
    if ([self.delegate respondsToSelector:@selector(detailTableViewCell:didClickLikeButton:)]) {
        [self.delegate detailTableViewCell:self didClickLikeButton:self.cellFrame.commentModel];
    }
}

- (UILabel *)timeL {
    if (!_timeL) {
        UILabel *label = [[UILabel alloc] init];
        [self.contentView addSubview:label];
        _timeL = label;
        label.font = kFont(11);
        label.textColor = kCommonGrayTextColor;
    }
    return _timeL;
}

- (UIButton *)likeCountBtn {
    if (!_likeCountBtn) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.contentView addSubview:btn];
        _likeCountBtn = btn;
        [btn setTitleColor:kCommonGrayTextColor forState:UIControlStateNormal];
        btn.titleLabel.font = kFont(13.0);
        btn.titleEdgeInsets = UIEdgeInsetsMake(0, 30, 0, 0);
        [btn setImage:[UIImage imageNamed:@"digupicon_comment"] forState:UIControlStateNormal];
        btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [btn addTarget:self action:@selector(likeCountBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _likeCountBtn;
}

- (UIButton *)shareBtn {
    if (!_shareBtn) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.contentView addSubview:btn];
        _shareBtn = btn;
        [btn setTitleColor:kCommonGrayTextColor forState:UIControlStateNormal];
        btn.titleLabel.font = kFont(13.0);
        btn.titleEdgeInsets = UIEdgeInsetsMake(0, 30, 0, 0);
        [btn setImage:[UIImage imageNamed:@"moreicon_textpage"] forState:UIControlStateNormal];
        btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        [btn addTarget:self action:@selector(shareBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _shareBtn;
}

- (UILabel *)nameL {
    if (!_nameL) {
        UILabel *label = [[UILabel alloc] init];
        [self.contentView addSubview:label];
        _nameL = label;
        label.font = kFont(14);
        label.textColor = kCommonBlackColor;
    }
    return _nameL;
}

- (YYLabel *)contentL {
    if (!_contentL) {
        YYLabel *label = [[YYLabel alloc] init];
        [self.contentView addSubview:label];
        _contentL = label;
        label.numberOfLines = 0;
    }
    return _contentL;
}

- (SCXBaseImageView *)iconImg {
    if (!_iconImg) {
        SCXBaseImageView *img = [[SCXBaseImageView alloc] init];
        [self.contentView addSubview:img];
        _iconImg = img;
        img.layer.masksToBounds = YES;
        img.backgroundColor = kCommonBgColor;
        __block typeof(self)weakSelf=self;
        [img setTapWithHandleBlock:^{
            if ([weakSelf.delegate respondsToSelector:@selector(detailTableViewCell:didClickUserNameButton:)]) {
                [weakSelf.delegate detailTableViewCell:weakSelf didClickUserNameButton:weakSelf.cellFrame.commentModel];
            }
        }];
        
    }
    return _iconImg;
}


@end
