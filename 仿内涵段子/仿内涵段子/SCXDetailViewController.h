//
//  SCXDetailViewController.h
//  仿内涵段子
//
//  Created by 孙承秀 on 16/10/12.
//  Copyright © 2016年 孙先森丶. All rights reserved.
//

#import "SCXBaseTableViewController.h"
#import "SCXHomeTableViewCellFrame.h"
#import "SCXBaseImageView.h"
#import "SCXDetailCellFrame.h"
#import "SCXHomeTableViewCell.h"
#import "SCXDetailTableViewCell.h"
#import "SCXDetailRequest.h"
#import "SCXHomeCommentModel.h"
#import "WMPlayer.h"
#import "SCXPersonalZoneViewController.h"
#import "MJPhoto.h"
#import "MJPhotoBrowser.h"
#import "SCXCustomShareView.h"
#import "SCXShareManager.h"
#import "MBProgressHUD+NHAddition.h"
@class SCXDiscoverCellFrame;
@interface SCXDetailViewController : SCXBaseTableViewController<SCXHomeTableViewCellDelegate,SCXDetailCellDelegate,WMPlayerDelegate>
-(instancetype)initWithCellFrame:(SCXHomeTableViewCellFrame *)cellFrame;
-(instancetype)initWithSearchCellFrame:(SCXDiscoverCellFrame *)cellFrame;
@property(nonatomic,strong)SCXDiscoverCellFrame *searchCellFrame;
@property(nonatomic,strong)SCXHomeTableViewCellFrame *cellFrame;
@property (nonatomic, strong) NSMutableArray *commentCellFrameArray;
@property (nonatomic, strong) NSMutableArray *topCommentCellFrameArray;
@property (nonatomic, strong) NSMutableArray *topDataArray;
@property (nonatomic, strong) NSIndexPath *indexPath;
@property (nonatomic, weak) SCXBaseImageView *imageView;
@property (nonatomic, assign) BOOL isSmallScreen;
@property(nonatomic,strong)WMPlayer *wmplayer;
@end
