//
//  SCXPersonalZoneViewController.h
//  仿内涵段子
//
//  Created by 孙承秀 on 16/10/9.
//  Copyright © 2016年 孙先森丶. All rights reserved.
//

#import "SCXBaseTableViewController.h"
#import "SCXUserInfoModel.h"
#import "SCXHomeTableViewCell.h"
#import "SCXHomeController.h"
#import "SCXPersonalHeaderContentView.h"
#import "SCXBaseImageView.h"
#import "SCXPersonalHeaderContentView.h"
#import "SCXPersonalHeaderFooterView.h"
#import "WMPlayer.h"
#import "SCXPersonalView.h"
#import "SCXPersonalRequest.h"
#import "SCXDetailCellFrame.h"
#import "SCXDetailTableViewCell.h"
#import "SCXHomeServerModel.h"
@interface SCXPersonalZoneViewController : SCXBaseTableViewController<SCXPersonalViewDelegate,SCXHomeTableViewCellDelegate,SCXPersonalHeaderFooterViewDelegate,SCXPersonalContentViewDelegate>
-(instancetype)initWithUserModel:(SCXUserInfoModel *)userModel;
-(instancetype)initWIthUserID:(NSInteger )userID;
@property(nonatomic,strong)SCXUserInfoModel *userModel;
@property(nonatomic,assign)NSInteger userID;
@property(nonatomic,strong)NSMutableArray *cellFrameArray;
/**
 关注、粉丝、动态
 */
@property(nonatomic,strong)SCXPersonalView *contentView;

/**
 头部视图
 */
@property(nonatomic,strong)SCXPersonalHeaderFooterView *headerFooterView;
@property(nonatomic,strong)NSIndexPath  *indexPath;

@property(nonatomic,strong) SCXBaseImageView *imageView;

/**
 是否小屏
 */
@property(nonatomic,assign)BOOL isSmallScreen;

/**
 头部视图种类
 */
@property(nonatomic,assign)SCXPersonalHeaderFooterViewType headerFooterType;

/**
 最头部视图Type
 */
@property(nonatomic,assign)SCXPersonalHeaderViewType headerViewType;
@property(nonatomic,strong)WMPlayer *SCX_player;
@end
