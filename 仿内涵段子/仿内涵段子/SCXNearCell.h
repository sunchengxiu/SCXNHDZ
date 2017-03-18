//
//  SCXNearCell.h
//  仿内涵段子
//
//  Created by 孙承秀 on 16/10/8.
//  Copyright © 2016年 孙先森丶. All rights reserved.
//

#import "SCXBaseTableViewCell.h"
#import "SCXNearModel.h"
#import "SCXBaseImageView.h"
@interface SCXNearCell : SCXBaseTableViewCell
@property(nonatomic,strong)SCXNearModel *model;
/** 头像*/
@property (nonatomic, weak) SCXBaseImageView *iconImg;
/** 名字*/
@property (nonatomic, weak) UILabel *nameL;
/** 描述*/
@property (nonatomic, weak) UILabel *descL;
/** 距离*/
@property (nonatomic, weak) UILabel *distanceL;
/** 时间*/
@property (nonatomic, weak) UILabel *timeL;
/** 订阅*/
@property (nonatomic, weak) UIButton *sexBtn;

/**
 分割线
 */
@property (nonatomic, weak) CALayer *lineLayer;
@end
