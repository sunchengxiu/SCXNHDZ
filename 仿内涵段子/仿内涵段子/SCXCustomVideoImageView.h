//
//  SCXCustomVideoImageView.h
//  仿内涵段子
//
//  Created by 孙承秀 on 16/10/1.
//  Copyright © 2016年 孙先森丶. All rights reserved.
//

#import "SCXBaseImageView.h"

@interface SCXCustomVideoImageView : SCXBaseImageView
@property(nonatomic,strong)UIButton *playButton;
@property(nonatomic,copy)void (^playButtonHandleblock)(UIButton *button);
@end
