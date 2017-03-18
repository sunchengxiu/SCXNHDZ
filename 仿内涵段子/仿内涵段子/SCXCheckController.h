//
//  SCXCheckController.h
//  仿内涵段子
//
//  Created by 孙承秀 on 16/9/20.
//  Copyright © 2016年 孙先森丶. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SCXBaseController.h"
#import "SCXCheckCellFrame.h"
#import "SCXCheckTableViewCell.h"
#import "RFLayout.h"
#import "SCXCheckRequest.h"
#import "MJPhotoBrowser.h"
#import "MJPhoto.h"
@interface SCXCheckController : SCXBaseController<UIGestureRecognizerDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,SCXCheckTableViewCellDelegate>
@property(nonatomic,strong)UICollectionView *collectionView;
@property(nonatomic,strong)NSMutableArray *dataArray;
@property(nonatomic,strong)NSMutableArray *cellFrameArray;
@property(nonatomic,assign)CGPoint preOffset;
@end
