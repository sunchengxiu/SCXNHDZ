//
//  SCXNearViewController.h
//  仿内涵段子
//
//  Created by 孙承秀 on 16/10/8.
//  Copyright © 2016年 孙先森丶. All rights reserved.
//

#import "SCXBaseTableViewController.h"
#import "SCXLocationManager.h"
@interface SCXNearViewController : SCXBaseTableViewController

/**
 筛选种类，-1全部，0女，1男，3不明
 */
@property(nonatomic,assign)NSInteger genter;

@end
