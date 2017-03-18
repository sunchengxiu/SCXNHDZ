//
//  SCXPersonalView.m
//  仿内涵段子
//
//  Created by 孙承秀 on 16/10/9.
//  Copyright © 2016年 孙先森丶. All rights reserved.
//

#import "SCXPersonalView.h"
#import "UIView+SCXTap.h"
@implementation SCXPersonalView

-(instancetype)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        self.backgroundColor=kWhiteColor;
    }
    return self;
}
-(void)setUserModel:(SCXUserInfoModel *)userModel{
    _userModel=userModel;
    [self.iconIma setImageWithUrl:userModel.avatar_url ];
     self.iconIma.layer.cornerRadius=40;
    self.nameLabel.text=userModel.name;
    self.contentView.fans_count=userModel.followers;
    self.contentView.follow_count=userModel.followings;
    self.contentView.share_count=userModel.point;
    //[self layoutIfNeeded];

}
#pragma mark-- 代理方法,关注、粉丝、动态
-(void)personalContentView:(SCXPersonalHeaderContentView *)contentView andButtonType:(SCXPersonalHeaderViewType)type{
    if ([self.delegate respondsToSelector:@selector(personalHeaderView:didClickItemWithType:)]) {
        [self.delegate personalHeaderView:self didClickItemWithType:type];
    }
}
-(void)layoutSubviews{
    [super layoutSubviews];
    /**
     *  封面
     */
    CGFloat coverX=0;
    CGFloat coverY=0;
    CGFloat coverW=ScreenWidth;
    CGFloat coverH=200;
    self.coverImageView.frame=CGRectMake(coverX, coverY, coverW, coverH);
    /**
     *  头像
     */
    CGFloat iconX=21;
    CGFloat iconY=self.coverImageView.frame.size.height-65;
    CGFloat iconW=80;
    CGFloat iconH=80;
    self.iconIma.frame=CGRectMake(iconX, iconY, iconW, iconH);
    self.iconIma.layer.cornerRadius=40;
    [self bringSubviewToFront:self.iconIma];
    /**
     *  更换头像
     */
    CGFloat changeX=0;
    CGFloat changeY=self.iconIma.frame.size.height/2-10;
    CGFloat changeW=self.iconIma.frame.size.width;
    CGFloat changeH=20;
    self.changeLabel.frame=CGRectMake(changeX, changeY, changeW, changeH);
    CGFloat nameX=self.iconIma.frame.size.width+self.iconIma.frame.origin.x+15;
    CGFloat nameY=self.iconIma.frame.origin.y+30;
    CGFloat nameW=ScreenWidth-nameX;
    CGFloat nameH=20;
    self.nameLabel.frame=CGRectMake(nameX, nameY, nameW, nameH);
    [self bringSubviewToFront:self.nameLabel];
    // 关注、粉丝、积分
    CGFloat countX = 0;
    CGFloat countY = self.coverImageView.frame.size.height+self.coverImageView.frame.origin.y;
    CGFloat countW = ScreenWidth;
    CGFloat countH = 79;
    self.contentView.frame = CGRectMake(countX, countY, countW, countH);
   

}
#pragma mark--懒加载
-(SCXBaseImageView *)iconIma{
    if (!_iconIma) {
        _iconIma=[[SCXBaseImageView alloc]init];
        _iconIma.layer.cornerRadius=40;
        _iconIma.clipsToBounds=YES;
        [self addSubview:_iconIma];
        [_iconIma setContentMode:UIViewContentModeScaleAspectFill];
        [self bringSubviewToFront:_iconIma];
        _iconIma.layer.borderColor=[UIColor whiteColor].CGColor;
        [_iconIma setBackgroundColor:kCommonBgColor];
        __block typeof(self)weakSelf=self;
        [_iconIma setTapWithHandleBlock:^{
            if ([weakSelf.delegate respondsToSelector:@selector(personalHeaderView:didClickItemWithType:)]) {
                [weakSelf.delegate personalHeaderView:weakSelf didClickItemWithType:SCXPersonalHeaderViewTypeAvatar];
            }
        }];
        
    }
    return _iconIma;
}
-(UIImageView *)coverImageView{
    if (!_coverImageView) {
        _coverImageView=[[UIImageView alloc]init];
        [self addSubview:_coverImageView];
        _coverImageView.image = [UIImage imageNamed:@"WechatIMG7"];
       
        _coverImageView.contentMode = UIViewContentModeScaleAspectFill;
        _coverImageView.layer.masksToBounds = YES;
    }
    return _coverImageView;
}
-(SCXPersonalHeaderContentView *)contentView{
    if (!_contentView) {
        _contentView=[[SCXPersonalHeaderContentView alloc]init];
        _contentView.delegate=self;
        [self addSubview:_contentView];
        _contentView.backgroundColor=[UIColor whiteColor];
    }
    return _contentView;
}
-(UILabel *)nameLabel{
    if (!_nameLabel) {
        UILabel *name = [[UILabel alloc] init];
        [self addSubview:name];
        _nameLabel = name;
        name.font = kFont(17);
        name.textColor = kCommonBlackColor;
    }
    return _nameLabel;
}
- (UILabel *)changeL {
    if (!_changeLabel) {
        UILabel *label = [[UILabel alloc] init];
        [self.iconIma addSubview:label];
        _changeLabel = label;
        label.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.6];
        label.text = @"更改头像";
        label.font = kFont(11);
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = kWhiteColor;
    }
    return _changeLabel;
}

@end
