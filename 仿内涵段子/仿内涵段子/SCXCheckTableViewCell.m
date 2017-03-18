//
//  SCXCheckTableViewCell.m
//  仿内涵段子
//
//  Created by 孙承秀 on 16/10/13.
//  Copyright © 2016年 孙先森丶. All rights reserved.
//

#import "SCXCheckTableViewCell.h"
@implementation SCXCheckTableViewCell
- (void)setCellFrame:(SCXCheckCellFrame *)cellFrame {
    _cellFrame = cellFrame;
    NSLog(@"%f",cellFrame.scrollViewF.origin.y);
    // 容器
    self.scrollView.frame = CGRectMake(0, 0, cellFrame.scrollViewF.size.width, cellFrame.scrollViewF.size.height);
    self.scrollView.contentSize = cellFrame.contentSize;
    
    // 举报、顶部白色区域
    self.topContentL.frame = cellFrame.topContentLF;
    self.reportBtn.frame = cellFrame.reportBtnF;
    
    // 文本
    self.contentL.frame = cellFrame.contentLF;
    SCXHomeGroupModel *group = cellFrame.model.group;
    self.contentL.attributedText=[SCXUtils attributeStringWithString:group.content withKeyWord:nil];
    
    
    [self removeAllImages];
    
    // 判断类型设置数据
    switch (group.media_type) {
            
        case SCXGroupMediaTypeImage: { // 大图
            self.largeImageCover.frame = cellFrame.largeImageCoverF;
             SCXElementGroupLargeImageUrl *urlModel = group.large_image.url_list.firstObject;
            [self.largeImageCover setImageWithURL:[NSURL URLWithString:urlModel.url]];
        } break;
            
        case SCXGroupMediaTypeGIF: { // Gif
            self.gifCover.frame = cellFrame.gifCoverF;
            SCXElementGroupLargeImageUrl *urlModel = group.large_image.url_list.firstObject;
            [self.gifCover setImageWithURL:[NSURL URLWithString:urlModel.url] placeHolder:nil finishHandle:^(bool finish, UIImage *image) {
                
            } progressHandle:^(CGFloat progress) {
                self.gifCover.progress=progress;
            }];
            
        } break;
            
        case SCXGroupMediaTypeVideo: { // 视频
            self.videoCover.frame = cellFrame.videoCoverF;
            SCXElementGroupLargeImageUrl *urlModel = group.large_cover.url_list.firstObject;
            [self.videoCover setImageWithURL:[NSURL URLWithString:urlModel.url]];
        } break;
            
        case SCXGroupMediaTypeLittleImages: { // 小图
            for (int i = 0; i < cellFrame.imageFrameArray.count; i++) {
                NSString *rectStr = cellFrame.imageFrameArray[i];
                SCXBaseImageView *img = [[SCXBaseImageView alloc] init];
                [self.contentView addSubview:img];
                img.tag = i + 1;
                img.frame = CGRectFromString(rectStr);
                img.clipsToBounds = YES;
                img.contentMode = UIViewContentModeScaleAspectFill;
                img.userInteractionEnabled  = YES;
                [img addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageTapGest:)]];
                SCXElementGroupLargeImage *imageModel = group.large_image_list[i];
                [img sd_setImageWithURL:[NSURL URLWithString:imageModel.url]];
            }
        }  break;
            
        default:
            break;
    }
    
    // 喜欢
    self.likeBtn.frame = cellFrame.likeF;
    self.likeL.frame = cellFrame.likeLF;
    
    // 动画
    [self removeBar];
    self.bar.frame = cellFrame.barF;
    
    // 不喜欢
    self.disLikeBtn.frame = cellFrame.disLikeF;
    self.disLikeL.frame = cellFrame.disLikeLF;
}
- (void)removeAllImages {
    _videoCover.image = nil;
    _gifCover.image = nil;
    _largeImageCover.image = nil;
    [_gifCover removeFromSuperview];
    [_videoCover removeFromSuperview];
    [_largeImageCover removeFromSuperview];
    _gifCover = nil;
    _videoCover = nil;
    _largeImageCover = nil;
    for (int i = 0; i < 9; i++) {
        SCXBaseImageView *img = [self.contentView viewWithTag:i + 1];
        if (img != nil || img.superview) {
            [img removeFromSuperview];
            img = nil;
        }
    }
}
- (void)removeBar {
    [self.bar removeFromSuperview];
    _bar = nil;
    
    UIWebView *web1 = (UIWebView *)[self.likeBtn viewWithTag:1];
    [web1 removeFromSuperview];
    UIWebView *web2 = (UIWebView *)[self.disLikeBtn viewWithTag:1];
    [web2 removeFromSuperview];
}
- (UILabel *)likeL {
    if (!_likeL) {
        UILabel *label = [[UILabel alloc] init];
        [self.scrollView addSubview:label];
        _likeL = label;
        label.text = @"好笑";
        label.font = kFont(12);
        label.textColor = kCommonBlackColor;
        label.textAlignment = NSTextAlignmentCenter;
    }
    return _likeL;
}

- (UILabel *)disLikeL {
    if (!_disLikeL) {
        UILabel *label = [[UILabel alloc] init];
        [self.scrollView addSubview:label];
        _disLikeL = label;
        label.text = @"不好笑";
        label.font = kFont(12);
        label.textColor = kCommonBlackColor;
        label.textAlignment = NSTextAlignmentCenter;
    }
    return _disLikeL;
}

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        UIScrollView *sc = [[UIScrollView alloc] init];
        [self.contentView addSubview:sc];
        _scrollView = sc;
        sc.backgroundColor = [UIColor colorWithRed:0.93f green:0.93f blue:0.93f alpha:1.00f];
        sc.showsVerticalScrollIndicator = NO;
        sc.showsHorizontalScrollIndicator = NO;
    }
    return _scrollView;
}

- (UIView *)topContentL {
    if (!_topContentL) {
        UIView *top = [[UIView alloc] init];
        [self.scrollView addSubview:top];
        _topContentL = top;
        top.backgroundColor = kWhiteColor;
    }
    return _topContentL;
}

- (UIButton *)reportBtn {
    if (!_reportBtn) {
        WeakSelf(weakSelf);
        UIButton *report = [UIButton buttonWithTitle:@"举报" normalColor:kCommonTintColor selectedColor:kCommonTintColor fontSize:15 touchBlock:^{
            [weakSelf reportBtnClick];
        }];
        [self.scrollView addSubview:report];
        _reportBtn = report;
        report.layerCornerRadius = 3.0;
        report.layerBorderColor = kCommonTintColor;
        report.layerBorderWidth = 1.0;
    }
    return _reportBtn;
}

- (UIButton *)likeBtn {
    if (!_likeBtn) {
        UIButton *btn = [[UIButton alloc] init];
        [self.scrollView addSubview:btn];
        _likeBtn = btn;
        [btn addTarget:self action:@selector(likeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [btn setImage:[UIImage imageNamed:@"digupicon_review_press_1"] forState:UIControlStateNormal];
    }
    return _likeBtn;
}

- (UIButton *)disLikeBtn {
    if (!_disLikeBtn) {
        UIButton *btn = [[UIButton alloc] init];
        [self.scrollView addSubview:btn];
        _disLikeBtn = btn;
        [btn addTarget:self action:@selector(disLikeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [btn setImage:[UIImage imageNamed:@"digdownicon_review_press_1"] forState:UIControlStateNormal];
    }
    return _disLikeBtn;
}

- (UILabel *)contentL {
    if (!_contentL) {
        UILabel *label = [[UILabel alloc] init];
        [self.scrollView addSubview:label];
        _contentL = label;
        label.font = kFont(16);
        label.textColor = kBlackColor;
        label.numberOfLines = 0;
    }
    return _contentL;
}

- (SCXBaseImageView *)largeImageCover {
    if (!_largeImageCover) {
        SCXBaseImageView *img = [[SCXBaseImageView alloc] init];
        [self.scrollView addSubview:img];
        _largeImageCover = img;
        img.layer.masksToBounds = YES;
        img.backgroundColor = kCommonBgColor;
        img.userInteractionEnabled  = YES;
        [img addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(coverImageTapGest:)]];
    }
    return _largeImageCover;
}

- (SCXBaseImageView *)videoCover {
    if (!_videoCover) {
        SCXBaseImageView *img = [[SCXBaseImageView alloc] init];
        [self.scrollView addSubview:img];
        _videoCover = img;
        img.layer.masksToBounds = YES;
        img.backgroundColor = kCommonBgColor;
    }
    return _videoCover;
}

- (SCXCustomGIFImageView*)gifCover {
    if (!_gifCover) {
        SCXCustomGIFImageView *img = [[SCXCustomGIFImageView alloc] init];
        [self.scrollView addSubview:img];
        _gifCover = img;
        img.layer.masksToBounds = YES;
        img.backgroundColor = kCommonBgColor;
        img.userInteractionEnabled  = YES;
        [img addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(coverImageTapGest:)]];
    }
    return _gifCover;
}

- (SCXCheckProgressBar *)bar {
    if (!_bar) {
        SCXCheckProgressBar *bar = [SCXCheckProgressBar bar];
        [self.scrollView addSubview:bar];
        WeakSelf(weakSelf);
        [bar setUpCheckTableViewProgressBarFinishLoadingHandle:^{
            //            if ([weakSelf.delegate respondsToSelector:@selector(checkTableViewCellDidFinishLoadingHandle:)]) {
            //                [weakSelf.delegate checkTableViewCellDidFinishLoadingHandle:weakSelf];
            //            }
            // 简单直接的判断，看看有没有loading视图就知道有没有点击过
            BOOL likeFlag = [self.likeBtn viewWithTag:1] != nil;
            if ([weakSelf.delegate respondsToSelector:@selector(checkTableViewCell:didFinishLoadingHandleWithLikeFlag:)]) {
                [weakSelf.delegate checkTableViewCell:weakSelf didFinishLoadingHandleWithLikeFlag:likeFlag];
            }
        }];
      
        _bar = bar;
    }
    return _bar;
}
- (void)addGifForButton:(UIButton *)btn imagename:(NSString *)imagename {
    UIWebView *webView=[[UIWebView alloc]init];
    [btn addSubview:webView];
    webView.opaque=NO;
    webView.backgroundColor=self.scrollView.backgroundColor;
    webView.tag=1;
    NSLog(@"%@",NSStringFromCGRect(btn.bounds));
    NSLog(@"%@",NSStringFromCGRect(btn.frame));
    webView.frame=btn.bounds;
    webView.scalesPageToFit=YES;
    NSData *data=[NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:imagename ofType:nil]];
    [webView loadData:data MIMEType:@"image/gif" textEncodingName:@"" baseURL:[NSURL new]];
    
    
}
-(void)coverImageTapGest:(UITapGestureRecognizer *)tap{
    SCXBaseImageView *imageView = (SCXBaseImageView *)tap.view;
    SCXElementGroupLargeImageUrl *urlModel = self.cellFrame.model.group.large_image.url_list.firstObject;
    if ([self.delegate respondsToSelector:@selector(checkTableViewCell:didClickImageView:currentIndex:urls:)]) {
        [self.delegate checkTableViewCell:self didClickImageView:imageView currentIndex:0 urls:@[[NSURL URLWithString:urlModel.url]]];
    }

}
-(void)imageTapGest:(UITapGestureRecognizer *)tap{

    SCXBaseImageView *imageView = (SCXBaseImageView *)tap.view;
    NSMutableArray *urls = [NSMutableArray array];
    
    for (int i = 0; i < self.cellFrame.imageFrameArray.count; i++) {
        SCXElementGroupLargeImage *imageModel = self.cellFrame.model.group.large_image_list[i];
        [urls addObject:[NSURL URLWithString:imageModel.url]];
    }
    if ([self.delegate respondsToSelector:@selector(checkTableViewCell:didClickImageView:currentIndex:urls:)]) {
        [self.delegate checkTableViewCell:self didClickImageView:imageView currentIndex:imageView.tag - 1 urls:urls];
    }
}
-(void)disLikeBtnClick:(UIButton *)button{
    [self addGifForButton:button imagename:@"digdownicon_review_press.gif"];
    CGFloat leftScale = 1 - (self.cellFrame.model.group.bury_count + 1)* 1.0 / (self.cellFrame.model.group.digg_count + self.cellFrame.model.group.bury_count + 1) ;
    [self showPercentWithLeftScale:leftScale];
}
-(void)likeBtnClick:(UIButton *)button{
    [self addGifForButton:button imagename:@"digupicon_review_press.gif"];
    CGFloat leftScale = (self.cellFrame.model.group.digg_count + 1) * 1.0 / (self.cellFrame.model.group.digg_count + 1 + self.cellFrame.model.group.bury_count);
    [self showPercentWithLeftScale:leftScale];
}
// 进度条
- (void)showPercentWithLeftScale:(CGFloat)leftScale {
    self.bar.leftScale = leftScale;
    self.bar.rightScale = 1 - leftScale;
}
-(void)reportBtnClick{
    if ([self.delegate respondsToSelector:@selector(checkTableViewCell:didClickReport:)]) {
        [self.delegate checkTableViewCell:self didClickReport:YES];
    }
}
@end
