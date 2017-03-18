//
//  SCXPersonalView.h
//  仿内涵段子
//
//  Created by 孙承秀 on 16/10/9.
//  Copyright © 2016年 孙先森丶. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SCXUserInfoModel.h"
#import "SCXBaseImageView.h"
#import "SCXPersonalHeaderContentView.h"
#import "SCXPersonalHeaderFooterView.h"
#import "WMPlayer.h"
@protocol SCXPersonalViewDelegate;
@interface SCXPersonalView : UIView<SCXPersonalContentViewDelegate>

/**
 用户数据Model
 */
@property(nonatomic,strong)SCXUserInfoModel *userModel;

/**
 代理
 */
@property(nonatomic,weak)id <SCXPersonalViewDelegate> delegate;

/**
 名字
 */
@property(nonatomic,strong)UILabel *nameLabel;

/**
 封面
 */
@property(nonatomic,strong)UIImageView *coverImageView;
@property(nonatomic,strong)SCXBaseImageView *iconIma;

/**
 更换头像
 */
@property(nonatomic,strong)UILabel *changeLabel;
/**
 关注、粉丝、动态
 */
@property(nonatomic,strong)SCXPersonalHeaderContentView *contentView;

@end
@protocol SCXPersonalViewDelegate <NSObject>

-(void)personalHeaderView:(SCXPersonalView *)headerView didClickItemWithType:(SCXPersonalHeaderViewType)type;

@end
