
//
//  SCXHomeTableViewCell.m
//  仿内涵段子
//
//  Created by 孙承秀 on 16/9/28.
//  Copyright © 2016年 孙先森丶. All rights reserved.
//

#import "SCXHomeTableViewCell.h"
#import <UIImageView+WebCache.h>
#import "SCXUtils.h"
#import "UIView+SCXTap.h"
#import "SCXElementGroupLarge_Image.h"
#import "SCXElementGroupLargeImageUrl.h"
#import "NSAttributedString+Size.h"
@implementation SCXHomeTableViewCell
- (UIView *)bottomView {
    if (!_bottomView) {
        UIView *bottom = [[UIView alloc] init];
        [self.contentView addSubview:bottom];
        _bottomView = bottom;
        bottom.backgroundColor = [UIColor colorWithRed:0.93f green:0.93f blue:0.93f alpha:1.00f];
    }
    return _bottomView;
}

- (UIButton *)likeCountBtn {
    if (!_likeCountBtn) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.contentView addSubview:btn];
        _likeCountBtn = btn;
        //[btn setTitleColor:kBottomBtnTextColor forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:13];
        btn.titleEdgeInsets = UIEdgeInsetsMake(0, 1, 0, 0);
        [btn setImage:[UIImage imageNamed:@"digupicon_comment"] forState:UIControlStateNormal];
        //[btn setBackgroundImage:[UIImage imageNamed:@"digupicon_comment"]  forState:UIControlStateNormal];
        btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        btn.tag = 11;
        btn.titleLabel.adjustsFontSizeToFitWidth = YES;
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _likeCountBtn;
}

- (UIButton *)dontLikeCountBtn {
    if (!_dontLikeCountBtn) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.contentView addSubview:btn];
        _dontLikeCountBtn = btn;
        //[btn setTitleColor:kBottomBtnTextColor forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:13];
        btn.titleEdgeInsets = UIEdgeInsetsMake(0, 1, 0, 0);
        [btn setImage:[UIImage imageNamed:@"digdownicon_textpage"] forState:UIControlStateNormal];
        btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        btn.tag = 12;
        btn.titleLabel.adjustsFontSizeToFitWidth = YES;
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _dontLikeCountBtn;
}

- (UIButton *)commentCountBtn {
    if (!_commentCountBtn) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.contentView addSubview:btn];
        _commentCountBtn = btn;
        btn.titleEdgeInsets = UIEdgeInsetsMake(0, 1, 0, 0);
       // [btn setTitleColor:kBottomBtnTextColor forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:13];
        btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [btn setImage:[UIImage imageNamed:@"commenticon_textpage"] forState:UIControlStateNormal];
        btn.tag = 13;
        btn.titleLabel.adjustsFontSizeToFitWidth = YES;
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _commentCountBtn;
}

- (UIButton *)version_Btn {
    if (!_version_Btn) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.contentView addSubview:btn];
        _version_Btn = btn;
        [btn setTitleColor:[UIColor colorWithRed:0.42f green:0.33f blue:0.27f alpha:1.00f] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:14];
        [btn addTarget:self action:@selector(versionBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        btn.layer.borderColor = [UIColor colorWithRed:0.42f green:0.33f blue:0.27f alpha:1.00f].CGColor;
        btn.layer.borderWidth = 1;
        btn.layer.cornerRadius = 10.0;
    }
    return _version_Btn;
}

- (UIButton *)attBtn {
    if (!_attBtn) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.contentView addSubview:btn];
        _attBtn = btn;
        [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:14];
        [btn setTitle:@"关注" forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(attBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        btn.layer.borderColor = [UIColor redColor].CGColor;
        btn.layer.borderWidth = 1;
        btn.layer.cornerRadius = 3.0;
    }
    return _attBtn;
}

- (UIButton *)shareBtn {
    if (!_shareBtn) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.contentView addSubview:btn];
        _shareBtn = btn;
       // [btn setTitleColor:kBottomBtnTextColor forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:14];
        btn.titleEdgeInsets = UIEdgeInsetsMake(0, 1, 0, 0);
        [btn setImage:[UIImage imageNamed:@"moreicon_textpage"] forState:UIControlStateNormal];
        btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        btn.tag = 14;
        btn.titleLabel.adjustsFontSizeToFitWidth = YES;
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _shareBtn;
}

- (UIButton *)lookEssBtn {
    if (!_lookEssBtn) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.contentView addSubview:btn];
        _lookEssBtn = btn;
        //[btn setTitleColor:kRedColor forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:13];
        [btn setTitle:@"查看内涵精华 >" forState:UIControlStateNormal];
    }
    return _lookEssBtn;
}

- (UILabel *)nameL {
    if (!_nameL) {
        UILabel *label = [[UILabel alloc] init];
        [self.contentView addSubview:label];
        _nameL = label;
        label.font =[UIFont systemFontOfSize:14];
        label.textColor = [UIColor blackColor];
    }
    return _nameL;
}

- (UILabel *)contentL {
    if (!_contentL) {
        UILabel *label = [[UILabel alloc] init];
        [self.contentView addSubview:label];
        _contentL = label;
        label.font = [UIFont systemFontOfSize:14];
        label.textColor = [UIColor blackColor];
        label.numberOfLines = 0;
    }
    return _contentL;
}

- (UILabel *)tagL {
    if (!_tagL) {
        UILabel *label = [[UILabel alloc] init];
        [self.contentView addSubview:label];
        _tagL = label;
        _tagL.backgroundColor = [UIColor colorWithRed:0.99f green:0.44f blue:0.40f alpha:1.00f];
        label.numberOfLines = 0;
        label.font = [UIFont systemFontOfSize:14];
        label.textColor = [UIColor blackColor];
    }
    return _tagL;
}

- (SCXBaseImageView *)iconImg {
    if (!_iconImg) {
        SCXBaseImageView *img = [[SCXBaseImageView alloc] init];
        [self.contentView addSubview:img];
        _iconImg = img;
        __block typeof (self)weakSelf=self;
        [self.iconImg setTapWithHandleBlock:^{
            if ([weakSelf.delegate respondsToSelector:@selector(homeTableViewCellDidClickIconImage:andUserModel:)]) {
                [weakSelf.delegate homeTableViewCellDidClickIconImage:weakSelf andUserModel:weakSelf.cellFrame.model.group.user];
            }
        }];
        
    }
    return _iconImg;
}

- (SCXBaseImageView *)largeImageCover {
    if (!_largeImageCover) {
        SCXBaseImageView *img = [[SCXBaseImageView alloc] init];
        [self.contentView addSubview:img];
        _largeImageCover = img;
        //img.backgroundColor = kSeperatorColor;
        img.userInteractionEnabled  = YES;
        [img addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(coverImageTapGest:)]];
    }
    return _largeImageCover;
}

- (SCXBaseImageView *)essImgCover {
    if (!_essImgCover) {
        SCXBaseImageView *img = [[SCXBaseImageView alloc] init];
        [self.contentView addSubview:img];
        _essImgCover = img;
       // img.backgroundColor = kSeperatorColor;
        img.userInteractionEnabled  = YES;
        [img addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(coverImageTapGest:)]];
    }
    return _largeImageCover;
}

- (SCXCustomVideoImageView *)videoCover {
    if (!_videoCover) {
        SCXCustomVideoImageView *img = [[SCXCustomVideoImageView alloc] init];
        [self.contentView addSubview:img];
        [img setUserInteractionEnabled:YES];
        _videoCover = img;
        __block typeof(self)weakSelf=self;
        img.playButtonHandleblock=^(UIButton * playButton){
            if ([self.delegate respondsToSelector:@selector(homeTableViewCell:withVideoUrl:withVideoImageView:)]) {
                SCXElementGroupLargeImageUrl *urlModel=weakSelf.cellFrame.model.group.video_360P.url_list.firstObject;
                [self.delegate homeTableViewCell:weakSelf withVideoUrl:urlModel.url withVideoImageView:weakSelf.videoCover];
            }
        
        };
//        img.backgroundColor = kSeperatorColor;
//        img.userInteractionEnabled = YES;
//        WeakSelf(weakSelf);
//        img.homeTableCellVideoDidBeginPlayHandle = ^(UIButton *playBtn) {
//            if (weakSelf.searchCellFrame) {
//                if ([weakSelf.delegate respondsToSelector:@selector(homeTableViewCell:didClickVideoWithVideoUrl:videoCover:)]) {
//                    NHHomeServiceDataElementGroupLargeImageUrl *urlVideoModel = weakSelf.searchCellFrame.group.video_360P.url_list.firstObject;
//                    [weakSelf.delegate homeTableViewCell:weakSelf didClickVideoWithVideoUrl:urlVideoModel.url videoCover:weakSelf.videoCover];
//                }
//            } else {
//                if ([weakSelf.delegate respondsToSelector:@selector(homeTableViewCell:didClickVideoWithVideoUrl:videoCover:)]) {
//                    NHHomeServiceDataElementGroupLargeImageUrl *urlVideoModel = weakSelf.cellFrame.model.group.video_360P.url_list.firstObject;
//                    [weakSelf.delegate homeTableViewCell:weakSelf didClickVideoWithVideoUrl:urlVideoModel.url videoCover:weakSelf.videoCover];
//                }
//            }
//        };
    }
    return _videoCover;
}

- (SCXCustomGIFImageView *)gifCover {
    if (!_gifCover) {
        SCXCustomGIFImageView *img = [[SCXCustomGIFImageView alloc] init];
        [self.contentView addSubview:img];
        _gifCover = img;
        //img.backgroundColor = kSeperatorColor;
        img.userInteractionEnabled  = YES;
        [img addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(coverImageTapGest:)]];
        
    }
    return _gifCover;
}

- (SCXBaseImageView *)closeImg {
    if (!_closeImg) {
        SCXBaseImageView *img = [[SCXBaseImageView alloc] init];
        [self.contentView addSubview:img];
        _closeImg = img;
        img.image = [UIImage imageNamed:@"dislike"];
        __block typeof(self)weakSelf=self;
        [img setUserInteractionEnabled:YES];
        [img setTapWithHandleBlock:^{
            if ([weakSelf.delegate respondsToSelector:@selector(homeTableViewCellDidClickCloseButtonHandleWithHomentableViewCell:)]) {
                [self.delegate homeTableViewCellDidClickCloseButtonHandleWithHomentableViewCell:self];
            }
        }];
    }
    return _closeImg;
}

- (void)setCellFrame:(SCXHomeTableViewCellFrame *)cellFrame isDetail:(BOOL)isDetail {
    _isDetail = isDetail;
    self.cellFrame = cellFrame;
}
- (void)setCellFrame:(SCXHomeTableViewCellFrame *)cellFrame {
    
    if (_cellFrame == cellFrame && _cellFrame) {
        return ;
    }
    _cellFrame = cellFrame;
    
    
    SCXHomeGroupModel *group = nil;
    
    if ([cellFrame isMemberOfClass:[SCXHomeTableViewCellFrame class]]) {
        group = cellFrame.model.group;
    } else {
        /*
        NHDiscoverSearchCommonCellFrame *searchCellFrame = (NHDiscoverSearchCommonCellFrame *)cellFrame;
        group = searchCellFrame.group;
         */
    }
    
    if (group == nil){
        return;
    }
    
    [self removeAllImages];
    
    [self removeAllCommentViews];
    
    
    // 精华
    if (group.media_type == 5) {
        self.essImgCover.frame = cellFrame.essenceCoverF;
        SCXElementGroupLargeImageUrl *urlModel = group.large_cover.url_list.firstObject;
        [self.essImgCover setImageWithUrl:urlModel.url];
        
        self.lookEssBtn.frame = cellFrame.lookEssEnceF;
        [self.lookEssBtn setBackgroundColor:[UIColor blueColor   ]];
        self.bottomView.frame = cellFrame.bottomViewF;
        return ;
    }
    
    // 头像
    self.iconImg.frame = cellFrame.iconImgF;
    self.iconImg.layer.cornerRadius = cellFrame.iconImgF.size.height / 2.0;
    [self.iconImg sd_setImageWithURL:[NSURL URLWithString:group.user.avatar_url]];
    
    // 名字
    self.nameL.frame = cellFrame.nameLF;
    self.nameL.text = group.user.name;
    
    // 热门
    if ([group.status_desc containsString:@"热门"] != NSNotFound) {
        self.tagL.frame = cellFrame.tagF;
        self.tagL.numberOfLines=0;
        [self.tagL setFont:[UIFont systemFontOfSize:8   ]];
        self.tagL.text = @"热门";
    } else {
        [self.tagL removeFromSuperview];
        _tagL = nil;
    }
    
    
    // 分类
    self.version_Btn.frame = cellFrame.version_BtnF;
    [self.version_Btn setTitle:group.category_name forState:UIControlStateNormal];
    
    
    // 文本
    self.contentL.frame = cellFrame.contentLF;
    self.contentL.attributedText = [SCXUtils attributeStringWithString:group.content withKeyWord:self.keyWord];
        
    // 判断类型设置数据
    switch (group.media_type) {
            
        case SCXGroupMediaTypeImage: { // 大图
            self.largeImageCover.frame = cellFrame.largeImageCoverF;
            SCXElementGroupLargeImageUrl *urlModel = group.large_image.url_list.firstObject;
            [self.largeImageCover setImageWithUrl:urlModel.url];
        } break;
            
        case SCXGroupMediaTypeGIF: { // Gif
            self.gifCover.frame = cellFrame.gifCoverF;
            SCXElementGroupLargeImageUrl *urlModel = group.large_image.url_list.firstObject;
            [self.gifCover setImageWithURL:[NSURL URLWithString:urlModel.url] placeHolder:nil finishHandle:nil progressHandle:^(CGFloat progress) {
                NSLog(@"%f",progress);
                self.gifCover.progress=progress;
            }];
           
        } break;
            
        case SCXGroupMediaTypeVideo: { // 视频
            self.videoCover.frame = cellFrame.videoCoverF;
            SCXElementGroupLargeImageUrl *urlModel = group.large_cover.url_list.firstObject;
            [self.videoCover setImageWithUrl:urlModel.url];
        } break;
            
        case SCXGroupMediaTypeLittleImages: { // 小图
            for (int i = 0; i < cellFrame.imageFrameArray.count; i++) {
                SCXElementGroupLargeImage *imageModel = group.thumb_image_list[i];
                NSString *rectStr = cellFrame.imageFrameArray[i];
                SCXBaseImageView *img = nil;
                if (imageModel.is_gif) {
                    img = [[SCXCustomGIFImageView alloc] init];
                } else {
                    img = [[SCXBaseImageView alloc] init];
                }
                [self.contentView addSubview:img];
                img.tag = i + 1;
                img.frame = CGRectFromString(rectStr);
                img.clipsToBounds = YES;
                img.contentMode = UIViewContentModeScaleAspectFill;
                img.userInteractionEnabled  = YES;
                [img addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageTapGest:)]];
                [img setImageWithUrl:imageModel.url];
            }
        }  break;
            
        default:
            break;
    }
    
    
    // 如果是从详情页面进入，有关注按钮
    if (self.isDetail) {
        self.attBtn.hidden = NO;
        self.attBtn.frame = cellFrame.attBtnF;
    } else {
        self.attBtn.hidden = YES;
    }
    
    if (self.isFromHomeController) {
        self.closeImg.hidden = NO;
        self.closeImg.frame = cellFrame.closeImgF;
    } else {
        self.closeImg.hidden = YES;
    }
    // 评论
    if (cellFrame.model.comments.count) {
        for (int i = 0; i < cellFrame.commentFrameArray.count; i++) {
            CGRect commentRect = CGRectFromString( cellFrame.commentFrameArray[i]);
            SCXCommentView *commentView = [[SCXCommentView alloc] init];
            [self.contentView addSubview:commentView];
            commentView.tag = 100 + i;
            [commentView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(self).mas_equalTo(15);
                make.right.mas_equalTo(self).mas_equalTo(-15);
                make.top.mas_equalTo(self).offset(commentRect.origin.y);
                
            }];
          //  commentView.frame = commentRect;
            commentView.commentModel = cellFrame.model.comments[i];
        }
    }
    // 点赞
    self.likeCountBtn.frame = cellFrame.likeCountBtnF;
    [self.likeCountBtn setTitle:[NSString stringWithFormat:@"%ld",group.digg_count] forState:UIControlStateNormal];
    [self.likeCountBtn setImage:[UIImage imageNamed:group.user_digg ? @"digupicon_textpage_press" : @"digupicon_textpage"] forState:UIControlStateNormal];
    [self.likeCountBtn setTitleColor:group.user_digg ? [UIColor redColor] : [UIColor grayColor] forState:UIControlStateNormal];
    
    // 分享
    self.shareBtn.frame = cellFrame.shareBtnF;
    [self.shareBtn setTitle:[NSString stringWithFormat:@"%ld",group.share_count] forState:UIControlStateNormal];
    
    // 踩
    self.dontLikeCountBtn.frame = cellFrame.dontLikeCountBtnF;
    [self.dontLikeCountBtn setTitle:[NSString stringWithFormat:@"%ld",group.bury_count] forState:UIControlStateNormal];
    [self.dontLikeCountBtn setImage:[UIImage imageNamed:group.user_bury ? @"digdownicon_textpage_press" : @"digdownicon_textpage"] forState:UIControlStateNormal];
    [self.dontLikeCountBtn setTitleColor:group.user_bury ? [UIColor redColor] : [UIColor grayColor]  forState:UIControlStateNormal];
    
    // 评论
    self.commentCountBtn.frame = cellFrame.commentCountBtnF;
    [self.commentCountBtn setTitle:[NSString stringWithFormat:@"%ld",group.comment_count] forState:UIControlStateNormal];
    
    self.bottomView.frame = cellFrame.bottomViewF;
}
- (void)removeAllImages {
    for (int i = 0; i < 9; i++) {
        SCXBaseImageView *img = [self.contentView viewWithTag:i + 1];
        if (img != nil || img.superview) {
            [img removeFromSuperview];
            img = nil;
        }
    }
    
    [_gifCover removeFromSuperview];
    [_videoCover removeFromSuperview];
    [_largeImageCover removeFromSuperview];
    
    _gifCover.image = nil;
    _videoCover.image = nil;
    _largeImageCover.image = nil;
    
    _gifCover = nil;
    _videoCover = nil;
    _largeImageCover = nil;
}

- (void)removeAllCommentViews {
    for (int i = 0; i < 9; i++) {
        SCXCommentView *commentView = [self.contentView viewWithTag:i + 100];
        if (commentView != nil || commentView.superview) {
            [commentView removeFromSuperview];
        }
    }
}
-(void)coverImageTapGest:(UITapGestureRecognizer *)tap{
    SCXBaseImageView *imageView=(SCXBaseImageView *)tap.view;
    SCXElementGroupLargeImageUrl *urlModel=self.cellFrame.model.group.large_image.url_list.firstObject;
    if ([self.delegate respondsToSelector:@selector(homeTableViewCell:withImageView:currentIndex:urls:)]) {
        [self.delegate homeTableViewCell:self withImageView:imageView currentIndex:0 urls:@[[NSURL URLWithString:urlModel.url]]];
    }

}
-(void)imageTapGest:(UITapGestureRecognizer *)tap{
    SCXBaseImageView *imageView=(SCXBaseImageView *)tap.view;
    NSMutableArray *arr=[[NSMutableArray alloc]initWithCapacity:0];
    for (NSInteger i=0; i<self.cellFrame.model.group.large_image_list.count; i++) {
        SCXElementGroupLargeImage *imageModel=self.cellFrame.model.group.large_image_list[i];
        [arr addObject:[NSURL URLWithString:imageModel.url]];
    }
    if ([self.delegate respondsToSelector:@selector(homeTableViewCell:withImageView:currentIndex:urls:)]) {
        [self.delegate homeTableViewCell:self withImageView:imageView currentIndex:imageView.tag-1 urls:arr];
    }
}
#pragma mark--按钮点击事件
-(void)btnClick:(UIButton *)btn{
    if ([self.delegate respondsToSelector:@selector(SCXHomeTableViewCell:didClickItemtype:)]) {
        [self.delegate SCXHomeTableViewCell:self didClickItemtype:btn.tag-10];
    }
}
// 点赞
- (void)didDigg {
    //digupicon_comment
    [self.likeCountBtn setImage:[UIImage imageNamed:@"digupicon_textpage_press"] forState:UIControlStateNormal];
    [self animationWithBtn:self.likeCountBtn isCancel:NO];
    [self.likeCountBtn setTitle:kIntegerToStr(self.likeCountBtn.currentTitle.integerValue + 1) forState:UIControlStateNormal];
}

// 踩
- (void)didBury {
    //digdownicon_textpage
    [self.dontLikeCountBtn setImage:[UIImage imageNamed:@"digdownicon_textpage_press"] forState:UIControlStateNormal];
    [self animationWithBtn:self.dontLikeCountBtn isCancel:NO];
    [self.dontLikeCountBtn setTitle:kIntegerToStr(self.dontLikeCountBtn.currentTitle.integerValue + 1) forState:UIControlStateNormal];
}
// 点赞
- (void)cancelDigg {
    //digupicon_comment
    [self.likeCountBtn setImage:[UIImage imageNamed:@"digupicon_comment"] forState:UIControlStateNormal];
    [self animationWithBtn:self.likeCountBtn isCancel:YES];
    [self.likeCountBtn setTitle:kIntegerToStr(self.likeCountBtn.currentTitle.integerValue - 1) forState:UIControlStateNormal];
}

// 踩
- (void)cancelBury {
    //digdownicon_textpage
    [self.dontLikeCountBtn setImage:[UIImage imageNamed:@"digdownicon_textpage"] forState:UIControlStateNormal];
    [self animationWithBtn:self.dontLikeCountBtn isCancel:YES];
    [self.dontLikeCountBtn setTitle:kIntegerToStr(self.dontLikeCountBtn.currentTitle.integerValue - 1) forState:UIControlStateNormal];
}

- (void)animationWithBtn:(UIButton *)btn isCancel:(BOOL)cancel{
    
    UILabel *label = [[UILabel alloc] init];
    label.text = @" + 1";
    label.textColor = kCommonHighLightRedColor;
    label.font = kBoldFont(14);
    [self.contentView addSubview:label];
    label.textAlignment = NSTextAlignmentCenter;
    label.frame = btn.frame;
    label.frame=CGRectMake(btn.frame.origin.x,btn.frame.origin.y-20, btn.frame.size.width, btn.frame.size.height);
    label.transform=CGAffineTransformMakeScale(0.2, 0.2);
    label.alpha=0.5;
    if (!cancel) {
        [btn setTitleColor:kCommonHighLightRedColor forState:UIControlStateNormal];
        [UIView animateWithDuration:0.2 animations:^{
            label.transform=CGAffineTransformMakeScale(1.2, 1.2);
            label.alpha=1.0;
        } completion:^(BOOL finished) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [label removeFromSuperview];
                
            });
        }];
        [UIView animateWithDuration:0.2 animations:^{
            btn.transform=CGAffineTransformMakeScale(0.9, 0.9);
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.2 animations:^{
                btn.transform=CGAffineTransformIdentity;
            } completion:^(BOOL finished) {
                
            }];
        }];
    }
    else{
        [btn setTitleColor:kCommonBlackColor forState:UIControlStateNormal];
        label.textColor = kCommonBlackColor;
        label.text=@" - 1";
        [UIView animateWithDuration:0.2 animations:^{
            label.transform=CGAffineTransformMakeScale(1.2, 1.2);
            label.alpha=1.0;
        } completion:^(BOOL finished) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [label removeFromSuperview];
                
            });
        }];
        [UIView animateWithDuration:0.2 animations:^{
            btn.transform=CGAffineTransformMakeScale(0.9, 0.9);
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.2 animations:^{
                btn.transform=CGAffineTransformMakeScale(1.0, 1.0);
            } completion:^(BOOL finished) {
                
            }];
        }];

    
    }
    
}

@end
