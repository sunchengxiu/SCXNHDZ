//
//  SCXPersonalHeaderContentView.m
//  仿内涵段子
//
//  Created by 孙承秀 on 16/10/9.
//  Copyright © 2016年 孙先森丶. All rights reserved.
//
#import "SCXPersonalHeaderContentView.h"

@interface SCXHeaderButton : UIButton
@property (nonatomic, assign) NSInteger count;
@property (nonatomic, copy) NSString *text;
@property (nonatomic, weak) UILabel *topLabel;
@property (nonatomic, weak) UILabel *bottomLabel;
@property (nonatomic, assign)  SCXPersonalHeaderViewType type;
@end
@implementation SCXHeaderButton

- (void)setText:(NSString *)text {
    _text = text;
    self.bottomLabel.text = text;
}

- (void)setCount:(NSInteger)count {
    _count = count;
    // 如果count <= 0 则显示0 不要显示负数
    self.topLabel.text = [NSString stringWithFormat:@"%ld", count <= 0 ? 0 : (long)count];
}
- (void)layoutSubviews {
    [super layoutSubviews];
    
    //    CGFloat labelH = self.frame.size.height / 2.0;
    CGFloat labelW = self.frame.size.width;
    self.topLabel.frame = CGRectMake(0, 5, labelW, 20);
    self.bottomLabel.frame = CGRectMake(0, self.topLabel.frame.size.height+self.topLabel.frame.origin.y, labelW, 20);
}

- (UILabel *)topLabel {
    if (!_topLabel) {
        UILabel *topL = [[UILabel alloc] init];
        [self addSubview:topL];
        _topLabel = topL;
        topL.textAlignment = NSTextAlignmentCenter;
        topL.text = [NSString stringWithFormat:@"%ld", (long)self.count];
        topL.font = [UIFont systemFontOfSize:16];
        topL.textColor = kCommonBlackColor;
    }
    return _topLabel;
}

- (UILabel *)bottomLabel {
    if (!_bottomLabel) {
        UILabel *bottomL = [[UILabel alloc] init];
        [self addSubview:bottomL];
        _bottomLabel = bottomL;
        bottomL.textAlignment = NSTextAlignmentCenter;
        bottomL.text = self.text;
        bottomL.font = [UIFont systemFontOfSize:12];
        bottomL.textColor = kCommonBlackColor;
    }
    return _bottomLabel;
}


@end
@interface SCXPersonalHeaderContentView()
@property(nonatomic,strong)SCXHeaderButton *likeButton;
@property(nonatomic,strong)SCXHeaderButton *pointButton;
@property(nonatomic,strong)SCXHeaderButton *fansButton;
@end
@implementation SCXPersonalHeaderContentView
-(void)setShare_count:(NSInteger)share_count{
    _share_count=share_count;
    self.pointButton.count=share_count;
    //[self layoutIfNeeded];
}
-(void)setFans_count:(NSInteger)fans_count{
    _fans_count=fans_count;
    self.fansButton.count=fans_count;
}
-(void)setFollow_count:(NSInteger)follow_count{
    _follow_count=follow_count;
    self.likeButton.count=follow_count;
}
-(void)buttonClick:(SCXHeaderButton *)button{
    if ([self.delegate respondsToSelector:@selector(personalContentView:andButtonType:)]) {
        [self.delegate personalContentView:self andButtonType:button.type];
    }
}
- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat leftRightMargin = ScreenWidth < 375 ? 40 : 50;
    CGFloat margin = ScreenWidth < 375 ? 25 : 30;
    CGFloat btnW = (ScreenWidth - leftRightMargin * 2 - margin * 2 ) / 3.0;
    CGFloat btnY = 15;
    CGFloat btnH = self.frame.size.height - btnY;
    
    self.likeButton.frame = CGRectMake(leftRightMargin,  btnY, btnW, btnH);
    self.fansButton.frame = CGRectMake(self.likeButton.frame.size.width+self.likeButton.frame.origin.x + margin, btnY, btnW, btnH);
    self.pointButton.frame = CGRectMake(self.fansButton.frame.size.width+self.fansButton.frame.origin.x + margin, btnY, btnW, btnH);
}
- (void)layoutSublayersOfLayer:(CALayer *)layer {
    [super layoutSublayersOfLayer:layer];
    CGFloat layerW = self.layer.frame.size.width;
    CGFloat layerH = self.layer.frame.size.height;
    self.topLayer.frame = CGRectMake(0, 0, layerW, 1);
    self.bottomLayer.frame = CGRectMake(0, layerH - 1, layerW, 1);
}
- (CALayer *)topLayer {
    if (!_topLayer) {
        CALayer *topLayer = [CALayer layer];
        [self.layer addSublayer:topLayer];
        _topLayer = topLayer;
        topLayer.backgroundColor = kSeperatorColor.CGColor;
    }
    return _topLayer;
}

- (CALayer *)bottomLayer {
    if (!_bottomLayer) {
        CALayer *bottomLayer = [CALayer layer];
        [self.layer addSublayer:bottomLayer];
        _bottomLayer = bottomLayer;
        bottomLayer.backgroundColor = kSeperatorColor.CGColor;
    }
    return _bottomLayer;
}
-(SCXHeaderButton *)likeButton{
    if (!_likeButton) {
        _likeButton=[SCXHeaderButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:_likeButton];
        [_likeButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        _likeButton.type=SCXPersonalHeaderViewTypeAtt;
        _likeButton.text=@"关注";
    }
    return _likeButton;
}
- (SCXHeaderButton *)fansButton {
    if (!_fansButton) {
        SCXHeaderButton *fans = [SCXHeaderButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:fans];
        _fansButton = fans;
        [fans addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        fans.type = SCXPersonalHeaderViewTypeFans;
        fans.text = @"粉丝";
    }
    return _fansButton;
}

- (SCXHeaderButton *)pointButton {
    if (!_pointButton) {
        SCXHeaderButton *state = [SCXHeaderButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:state];
        _pointButton = state;
        [state addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        state.type = SCXPersonalHeaderViewTypeInteger;
        state.text = @"积分";
    }
    return _pointButton;
}

@end
