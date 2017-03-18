//
//  SCXPersonalHeaderFooterView.m
//  仿内涵段子
//
//  Created by 孙承秀 on 16/10/9.
//  Copyright © 2016年 孙先森丶. All rights reserved.
//

#import "SCXPersonalHeaderFooterView.h"

@implementation SCXPersonalHeaderFooterView

-(void)clickDefaultType{
    [self clickButton:self.publishBtn];
}
-(void)clickButton:(UIButton *)button{
    self.selectButton.selected=NO;
    button.selected=YES;
    self.selectButton=button;
    if ([self.delegate respondsToSelector:@selector(personalHeaderFoooterView:clickHeaderType:)]) {
        [self.delegate personalHeaderFoooterView:self clickHeaderType:button.tag];
    }
    [UIView animateWithDuration:0.3 animations:^{
        self.runningLineLayer.frame=CGRectMake(button.frame.origin.x, button.frame.origin.y, button.frame.size.width, button.frame.size.height);
    }];
}
-(void)layoutSubviews{
    [super layoutSubviews];
    CGFloat buttonW = 80;
    CGFloat buttonMargin = (ScreenWidth - 80 * 3) / 4.0;
    self.publishBtn.frame = CGRectMake(buttonMargin,  5, buttonW, self.frame.size.height * 0.5 - 1);
    self.colBtn.frame =  CGRectMake(self.publishBtn.frame.size.width+self.publishBtn.frame.origin.x + buttonMargin, self.publishBtn.frame.origin.y, buttonW, self.publishBtn.frame.size.height);
    self.commentBtn.frame = CGRectMake(self.colBtn.frame.size.width+self.colBtn.frame.origin.x + buttonMargin, self.colBtn.frame.origin.y, buttonW, self.colBtn.frame.size.height);
}
- (void)layoutSublayersOfLayer:(CALayer *)layer {
    [super layoutSublayersOfLayer:layer];
    if (self.selectButton == nil) {
        self.selectButton = self.publishBtn;
    }
    self.runningLineLayer.frame = CGRectMake(self.selectButton.frame.origin.x, self.frame.size.height - 2, self.colBtn.frame.size.width, 2);
}
- (CALayer *)lineLayer {
    if (!_lineLayer) {
        CALayer *line = [CALayer layer];
        [self.layer addSublayer:line];
        _lineLayer = line;
        line.backgroundColor = [kSeperatorColor CGColor];
    }
    return _lineLayer;
}

- (CALayer *)runningLineLayer {
    if (!_runningLineLayer) {
        CALayer *runningLineLayer = [CALayer layer];
        [self.layer addSublayer:runningLineLayer];
        _runningLineLayer = runningLineLayer;
        runningLineLayer.backgroundColor = [kCommonHighLightRedColor CGColor];
    }
    return _runningLineLayer;
}
- (UIButton *)commentBtn {
    if (!_commentBtn) {
        UIButton *commentBtn = [[UIButton alloc] init];
        [self addSubview:commentBtn];
        _commentBtn = commentBtn;
        [commentBtn addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
        [commentBtn setTitle:@"评论" forState:UIControlStateNormal];
        commentBtn.tag = 3;
        commentBtn.titleLabel.font = kFont(16);
        [commentBtn setTitleColor:kCommonBlackColor forState:UIControlStateNormal];
        [commentBtn setTitleColor:kCommonHighLightRedColor forState:UIControlStateSelected];
    }
    return _commentBtn;
}

- (UIButton *)colBtn {
    if (!_colBtn) {
        UIButton *col = [[UIButton alloc] init];
        [self addSubview:col];
        _colBtn = col;
        [col addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
        [col setTitle:@"收藏" forState:UIControlStateNormal];
        col.tag = 2;
        col.titleLabel.font = kFont(16);
        [col setTitleColor:kCommonBlackColor forState:UIControlStateNormal];
        [col setTitleColor:kCommonHighLightRedColor forState:UIControlStateSelected];
    }
    return _colBtn;
}

- (UIButton *)publishBtn {
    if (!_publishBtn) {
        UIButton *publishBtn = [[UIButton alloc] init];
        [self addSubview:publishBtn];
        _publishBtn = publishBtn;
        [publishBtn addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
        [publishBtn setTitle:@"投稿" forState:UIControlStateNormal];
        publishBtn.tag = 1;
        publishBtn.titleLabel.font = kFont(16);
        [publishBtn setTitleColor:kCommonBlackColor forState:UIControlStateNormal];
        [publishBtn setTitleColor:kCommonHighLightRedColor forState:UIControlStateSelected];
    }
    return _publishBtn;
}

@end
