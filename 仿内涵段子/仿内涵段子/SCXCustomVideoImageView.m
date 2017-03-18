//
//  SCXCustomVideoImageView.m
//  仿内涵段子
//
//  Created by 孙承秀 on 16/10/1.
//  Copyright © 2016年 孙先森丶. All rights reserved.
//

#import "SCXCustomVideoImageView.h"

@implementation SCXCustomVideoImageView
#pragma mark--懒加载 
-(UIButton *)playButton{
    if (!_playButton) {
        UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:button];
        _playButton=button;
        
        __block typeof(self)weakSelf=self;
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(44, 44));
            make.center.equalTo(weakSelf);
        }];
        [button addTarget:self action:@selector(playButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _playButton;
}
-(instancetype)init{
    self=[super init];
    if (self) {
        [self.playButton setImage:[UIImage imageNamed:@"play"] forState:UIControlStateNormal];
    }
    return self;
}
-(void)playButtonClick:(UIButton *)button{
    if (_playButtonHandleblock) {
        _playButtonHandleblock(button);
    }

}
@end
