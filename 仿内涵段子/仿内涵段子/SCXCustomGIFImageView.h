//
//  SCXCustomGIFImageView.h
//  仿内涵段子
//
//  Created by 孙承秀 on 16/10/1.
//  Copyright © 2016年 孙先森丶. All rights reserved.
//

#import "SCXBaseImageView.h"

@interface SCXCustomGIFImageView : SCXBaseImageView
@property(nonatomic,weak)CAShapeLayer *shareLayer;
@property(nonatomic,assign)CGFloat progress;
@end
