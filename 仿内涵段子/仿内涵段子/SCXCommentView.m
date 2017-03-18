//
//  SCXCommentView.m
//  仿内涵段子
//
//  Created by 孙承秀 on 16/10/2.
//  Copyright © 2016年 孙先森丶. All rights reserved.
//

#import "SCXCommentView.h"

@implementation SCXCommentView

/**
 初始化方法

 @return
 */
- (instancetype)init {
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:0.97f green:0.97f blue:0.97f alpha:1.00f];
       // self.frame=[UIScreen mainScreen].bounds;
       
    }
    return self;
}
-(void)setCommentModel:(SCXHomeCommentModel *)commentModel{
    _commentModel=commentModel;
   
    [self.iconImg sd_setImageWithURL:[NSURL URLWithString:commentModel.user_profile_image_url]];
    self.nameL.text=commentModel.user_name;
    self.contentL.attributedText=[SCXUtils attributeStringWithString:commentModel.text withKeyWord:nil];
    [self.likeCountBtn setTitle:[NSString stringWithFormat:@"%ld",commentModel.user_bury] forState:UIControlStateNormal
     ];
    
}
#pragma mark--懒加载
- (UIButton *)likeCountBtn {
    if (!_likeCountBtn) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:btn];
        _likeCountBtn = btn;
        [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:13];
        btn.titleEdgeInsets = UIEdgeInsetsMake(0, 3, 0, 0);
        [btn setImage:[UIImage imageNamed:@"digupicon_comment"] forState:UIControlStateNormal];
        btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [btn addTarget:self action:@selector(likeCountBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _likeCountBtn;
}
- (UIButton *)shareBtn {
    if (!_shareBtn) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:btn];
        _shareBtn = btn;
        btn.titleLabel.font = [UIFont systemFontOfSize:13];
        btn.titleEdgeInsets = UIEdgeInsetsMake(0, 3, 0, 0);
        [btn setImage:[UIImage imageNamed:@"moreicon_textpage"] forState:UIControlStateNormal];
        btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        [btn addTarget:self action:@selector(shareBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _shareBtn;
}
- (UILabel *)nameL {
    if (!_nameL) {
        UILabel *label = [[UILabel alloc] init];
        [self addSubview:label];
        _nameL = label;
        label.font = [UIFont systemFontOfSize:14];
        label.textColor = [UIColor blackColor];
        label.lineBreakMode = NSLineBreakByTruncatingTail;
    }
    return _nameL;
}
- (UILabel *)contentL {
    if (!_contentL) {
        UILabel *label = [[UILabel alloc] init];
        [self addSubview:label];
        _contentL = label;
        label.font = [UIFont systemFontOfSize:16];
        label.textColor = [UIColor blackColor];
        label.numberOfLines = 0;
        [label setTapWithHandleBlock:^{
            if ([self.commentDelegate respondsToSelector:@selector(commentView:replayWithCommentModel:)]) {
                [self.commentDelegate commentView:self replayWithCommentModel:self.commentModel ];
            }
        }];
    }
    return _contentL;
}

- (UIImageView *)iconImg {
    if (!_iconImg) {
        UIImageView *img = [[UIImageView alloc] init];
        [self addSubview:img];
        _iconImg = img;
        img.layer.masksToBounds = YES;
        img.backgroundColor = [UIColor colorWithRed:0.86f green:0.85f blue:0.80f alpha:1.00f];
    }
    return _iconImg;
}
#pragma mark--按钮点击事件
-(void)likeCountBtnClick:(UIButton *)button{

    if ([self.commentDelegate respondsToSelector:@selector(commentView:likeWithCommentModel:)]) {
        [self.commentDelegate commentView:self likeWithCommentModel:self.commentModel];
    }
}
-(void)shareBtnClick:(UIButton *)button{
    if ([self.commentDelegate respondsToSelector:@selector(commentView:shareWithCommentModel:)]) {
        [self.commentDelegate commentView:self shareWithCommentModel:self.commentModel];
    }
}
#pragma mark--配置视图
-(void)layoutSubviews{
    [super layoutSubviews];
    [self.iconImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).offset(20);
        make.top.mas_equalTo(self).offset(15);
        make.width.mas_equalTo(35);
        make.height.mas_equalTo(35);
    }];
    self.iconImg.layer.cornerRadius=35/2;
    [self.shareBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.mas_right).offset(-5);
        make.top.mas_equalTo(self.mas_top).offset(15);
        make.height.mas_equalTo(35);
    }];
    [self.likeCountBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.shareBtn.mas_left   ).offset(-10);
        make.top.mas_equalTo(self.mas_top).offset(15);
        make.height.mas_equalTo(35);
    }];
    [self.nameL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.iconImg.mas_right).offset(10);
        make.top.mas_equalTo(self).offset(15);
        make.right.mas_equalTo(self.likeCountBtn.mas_left).offset(-10);
    }];
    [self.contentL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.iconImg).offset(5);
        make.top.mas_equalTo(self.nameL.mas_bottom).offset(10);
        make.right.mas_equalTo(self).offset(-15);
    }];
    [self.contentL setTextColor:[UIColor blackColor]];
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.iconImg.mas_top).offset(-10);
        make.bottom.mas_equalTo(self.contentL.mas_bottom).offset(10);
    }];
    [self layoutIfNeeded];
}
@end
