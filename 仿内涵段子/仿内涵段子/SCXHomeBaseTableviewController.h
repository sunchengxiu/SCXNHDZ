//
//  SCXHomeBaseTableviewController.h
//  仿内涵段子
//
//  Created by 孙承秀 on 16/9/27.
//  Copyright © 2016年 孙先森丶. All rights reserved.
//

#import "SCXBaseTableViewController.h"
#import "SCXBaseTableView.h"
#import "SCXHomeAllModel.h"
#import "SCXHomeTableViewCellFrame.h"
#import "SCXHomeTableViewCell.h"
#import "WMPlayer.h"
#import "SCXBaseImageView.h"
#import "SCXDetailViewController.h"
#import "SCXCustomShareView.h"
#import "SCXShareManager.h"
#import <MBProgressHUD.h>
#import "MBProgressHUD+NHAddition.h"
#import "SCXCustomShareView.h"
@class SCXBaseRequestHelp;
@interface SCXHomeBaseTableviewController : SCXBaseTableViewController<SCXHomeTableViewCellDelegate,WMPlayerDelegate>
/**
 *  home控制器的url
 */
@property(nonatomic,copy)NSString *url;
@property(nonatomic,strong)SCXBaseRequestHelp *request;
//@property(nonatomic,strong)SCXBaseTableView *tableView;
@property(nonatomic,strong)SCXHomeAllModel *allModel;
@property (nonatomic, strong) NSMutableArray *cellFrameArray;
@property(nonatomic,strong)WMPlayer *player;
@property (nonatomic, strong) NSIndexPath *indexPath;
@property (nonatomic, weak) SCXBaseImageView *videoImageView;
@property (nonatomic, assign) BOOL isSmallScreen;

/**
 *  初始化
 *
 *  @param url 请求的URl
 *
 *  @return
 */
- (instancetype)initWithUrl:(NSString *)url ;

@end
