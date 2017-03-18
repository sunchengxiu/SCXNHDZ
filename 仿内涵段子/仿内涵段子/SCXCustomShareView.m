//
//  SCXCustomShareView.m
//  仿内涵段子
//
//  Created by 孙承秀 on 16/10/12.
//  Copyright © 2016年 孙先森丶. All rights reserved.
//

#import "SCXCustomShareView.h"
#import "UIView+SCXTap.h"
@implementation SCXCustomShareView
+(instancetype)shareViwWithType:(SCXShareViewType)type{
    return [self shareViewWithType:type hasrepinFlag:NO];
}
+(instancetype)shareViewWithType:(SCXShareViewType)type hasrepinFlag:(BOOL)hasRepinFlag{
    SCXCustomShareView *shareView=[[SCXCustomShareView alloc]init];
    shareView.type=type;
    shareView.hasRepinFlag=hasRepinFlag;
    return shareView;

}
-(void)setUpDidClickShareHandBlock:(SCXShareViewDidClickShareHandBlock)shareBlock{
    _shareBlock=shareBlock;
}
-(void)setUpDidClickBottomHandleBlock:(SCXShareViewDidClickBottomViewHandleblock)bottomBlock{
    _bottomBlock=bottomBlock;
}
-(void)showInView:(UIView *)view{
    self.frame=CGRectMake(0, 0, ScreenWidth, ScreenHeight);
    self.bgView.frame=self.frame;
   
    [self configShareView];
    [view.window addSubview:self.blurView];
    [view.window addSubview:self];
    
    [self layoutIfNeeded];
    self.contentView.alpha=0;
    [UIView animateKeyframesWithDuration:0.3 delay:0 options:UIViewKeyframeAnimationOptionCalculationModeLinear animations:^{
        
        _blurView.dynamic=NO;
        [FXBlurView setUpdatesDisabled];
        self.contentView.alpha=1;
        self.contentView.frame=CGRectMake(0, ScreenHeight-self.contentView.frame.size.height, ScreenWidth, self.contentView.frame.size.height);
    } completion:^(BOOL finished) {
        
    }];
}
-(void)configShareView{
    CGFloat buttonW=(ScreenWidth-20*2)/4;
    CGFloat contentH=buttonW*2+70+20*3+40;
    /**
     *  下方容器视图
     */
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left);
        make.right.mas_equalTo(self.mas_right);
        make.height.mas_equalTo(contentH);
       // make.top.mas_equalTo(self.mas_bottom).offset(-contentH);
    }];
    /**
     *  标题视图
     */
    [self.titleL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left);
        make.right.mas_equalTo(self.mas_right);
        make.top.mas_equalTo(self.contentView.mas_top);
        make.height.mas_equalTo(25);
    }];
    /**
     *  背景视图
     */
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self);
    }];
    UILabel *lastLabel=nil;
    /**
     *  分享平台
     */
    for (int i=0; i<self.titleArray.count; i++) {
        int row=i/4;
        int col=i%4;
        UIView *imageView=[[UIView alloc]init];
        [self.contentView addSubview:imageView];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView.mas_left).offset(20+col*buttonW);
            make.top.mas_equalTo(self.titleL.mas_bottom).offset(row*buttonW);
            make.width.mas_equalTo(buttonW);
            make.height.mas_equalTo(buttonW*0.7);
        }];
        UIImageView *img = [[UIImageView alloc] init];
        [imageView addSubview:img];
        img.contentMode = UIViewContentModeCenter;
        img.image = [UIImage imageNamed:self.imageArray[i]];
        imageView.userInteractionEnabled=YES;
        img.userInteractionEnabled=YES;
        img.tag=i+1;
        [img addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(shareTap:)]];
        [img mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(imageView.mas_left);
            make.right.mas_equalTo(imageView.mas_right);
            make.top.mas_equalTo(imageView);
            make.height.mas_equalTo(buttonW*0.7);
        }];
        UILabel *label=[[UILabel alloc]init];
        [self.contentView addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView.mas_left).offset(20+col*buttonW);
            make.top.mas_equalTo(imageView.mas_bottom).offset(0);
            make.width.mas_equalTo(buttonW);
            make.height.mas_equalTo(20);
        }];
        [label setTextAlignment:NSTextAlignmentCenter];
        [label setText:self.titleArray[i]];
        [label setFont:[UIFont systemFontOfSize:13]];
        if (i>=self.titleArray.count-1) {
            lastLabel=label;
        }
    }
    [self layoutIfNeeded];
    /**
     *  分割线
     */
    CALayer *lineLayer=[CALayer layer];
    [self.contentView.layer addSublayer:lineLayer];
    lineLayer.frame=CGRectMake(15, lastLabel.frame.size.height+lastLabel.frame.origin.y+10, ScreenWidth-30, 1);
    [lineLayer setBackgroundColor:kSeperatorColor.CGColor];
    /**
     *  复制、收藏、举报按钮
     */
    if (self.type==SCXShareViewTypeShowCopyAndCollect) {
        CGFloat btnW=70;
        CGFloat margin=25;
        CGFloat leftMargin=(ScreenWidth -btnW*3-margin*2)/2;
        for (int i=0; i<self.bottomTitleArray.count; i++) {
            UIImageView *imageView=[[UIImageView alloc]init];
            [self.contentView addSubview:imageView];
            imageView.contentMode=UIViewContentModeCenter;
            [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(self.contentView).offset(leftMargin+btnW*i+margin*(1));
                make.top.mas_equalTo(lastLabel.mas_bottom).offset(10);
                make.width.mas_equalTo(btnW);
                make.height.mas_equalTo(btnW);
                
            }];
            [imageView setImage:[UIImage imageNamed:self.bottomImageArray[i]]];
            imageView.userInteractionEnabled=YES;
            imageView.tag=100+i;
            [imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(bottomTap:)]];
            UILabel *label=[[UILabel alloc]init];
            [label setFont:[UIFont systemFontOfSize:13]];
            [self.contentView addSubview:label];
            [label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(self.contentView).offset(leftMargin+btnW*i+margin*(1));
                make.top.mas_equalTo(imageView.mas_bottom).offset(5);
                make.width.mas_equalTo(btnW);
                make.height.mas_equalTo(20);
                
            }];
            [label setText:self.bottomTitleArray[i]];
            [label setTextAlignment:NSTextAlignmentCenter];
            if (i>=self.bottomTitleArray.count-1) {
                lastLabel=label;
            }
        }
    }
    /**
     *  取消按钮
     */
    [self.cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(lastLabel.mas_bottom).offset(15);
        make.left.mas_equalTo(self.contentView.mas_left);
        make.right.mas_equalTo(self.contentView.mas_right);
        make.height.mas_equalTo(35);
    }];
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left);
        make.right.mas_equalTo(self.mas_right);
        make.top.mas_equalTo(self.mas_bottom).offset(ScreenHeight);
    }];
    //[self layoutIfNeeded];
}
#pragma mark--懒加载
- (UILabel *)titleL {
    if (!_titleL) {
        UILabel *title = [[UILabel alloc] init];
        _titleL = title;
        [self.contentView addSubview:_titleL];
        
        title.text = @"分享到";
        title.font = kFont(14);
        title.textColor = kCommonGrayTextColor;
        title.textAlignment = NSTextAlignmentCenter;
    }
    return _titleL;
}

- (UIButton *)cancelBtn {
    if (!_cancelBtn) {
       // UIButton *cancel = [UIButton buttonWithTitle:@"取消" normalColor:kCommonBlackColor selectedColor:kCommonBlackColor fontSize:16 target:self action:@selector(dismiss)];
        UIButton *cancel=[[UIButton alloc]init];
        [cancel setTitle:@"取消" forState:UIControlStateNormal];
        [cancel setTitleColor:kCommonBlackColor forState:UIControlStateNormal];
        [cancel.titleLabel setFont:[UIFont systemFontOfSize:16]];
        [cancel addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
        _cancelBtn = cancel;
        [self.contentView addSubview:_cancelBtn];
        
    }
    return _cancelBtn;
}

- (UIView *)bgView {
    if (!_bgView) {
        UIView *bg = [[UIView alloc] init];
        
        _bgView = bg;
        [self addSubview:_bgView];
       // bg.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.4];
        [bg setBackgroundColor:[UIColor clearColor]];
        __block typeof(self)weakSelf=self;
        [bg setTapWithHandleBlock:^{
            [weakSelf dismiss];
        }];
    }
   
    return _bgView;
}
-(FXBlurView *)blurView{
    if (_blurView==nil) {
        self.blurView=[[FXBlurView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
        self.blurView.blurRadius=20;
        self.blurView.tintColor=[UIColor whiteColor];
        
    }
    return _blurView;
}

- (UIView *)contentView {
    if (!_contentView) {
        UIView *content = [[UIView alloc] init];
        
        _contentView = content;
        [self addSubview:_contentView];
        content.backgroundColor = [UIColor whiteColor];
    }
    return _contentView;
}

- (NSArray *)titleArray {
    if (!_titleArray) {
        _titleArray = @[@"手机QQ", @"QQ空间", @"微信", @"朋友圈", @"微博"];
    }
    return _titleArray;
}

- (NSArray *)bottomTitleArray {
    if (!_bottomTitleArray) {
        _bottomTitleArray = @[@"复制", @"收藏", @"举报"];
    }
    return _bottomTitleArray;
}

- (NSArray *)bottomImageArray {
    if (!_bottomImageArray) {
        _bottomImageArray = @[@"url_popover", self.hasRepinFlag ?  @"favorite_popover_select" : @"favorite_popover", @"report_popover"];
    }
    return _bottomImageArray;
}

- (NSArray *)imageArray {
    if (!_imageArray) {
        _imageArray = @[@"qq_popover", @"qqkongjian_popover", @"weixin_popover",@"weixinpengyou_popover", @"invite-weibo"];
    }
    return _imageArray;
}
#pragma mark--方法
-(void)dismiss{
    [self dismissWithBlock:nil];
}
-(void)dismissWithBlock:(void (^)())block{
    [UIView animateKeyframesWithDuration:0.3 delay:0 options:UIViewKeyframeAnimationOptionCalculationModeLinear animations:^{
        [self.contentView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.mas_bottom).offset(self.contentView.frame.size.height);
        }];
        self.contentView.alpha=0;
    } completion:^(BOOL finished) {
        [self.contentView removeFromSuperview];
        [self.bgView removeFromSuperview];
        [self removeFromSuperview];
        self.contentView=nil;
        self.bgView=nil;
        [self.blurView clearImage];
        [self.blurView removeFromSuperview];
        if (finished) {
            if (block) {
                block();
            }
        }
    }];
}
#pragma mar--点击方法
-(void)shareTap:(UITapGestureRecognizer *)tap{
    WeakSelf(weakSelf);
    [self dismissWithBlock:^{
        if (weakSelf.shareBlock) {
            weakSelf.shareBlock(weakSelf,weakSelf.titleArray[tap.view.tag-1],tap.view.tag-1,tap.view.tag-1+1);
        }
    }];
}
-(void)bottomTap:(UITapGestureRecognizer *)tap{
    WeakSelf(weakSelf);
    [self dismissWithBlock:^{
        if (weakSelf.bottomBlock) {
            weakSelf.bottomBlock(weakSelf,weakSelf.bottomTitleArray[tap.view.tag-100],tap.view.tag-100);
        }
    }];
}
@end
