//
//  SCXHomeServerModel.h
//  仿内涵段子
//
//  Created by 孙承秀 on 16/9/27.
//  Copyright © 2016年 孙先森丶. All rights reserved.
//

#import "SCXBaseModel.h"
#import "SCXHomeAllModel.h"
/**
 *  第一层数据
 */
@interface SCXHomeServerModel : SCXBaseModel
@property (nonatomic, assign) BOOL has_more;
@property (nonatomic, copy) NSString *tip;
@property (nonatomic, assign) NSInteger min_time;
@property (nonatomic, assign) NSInteger max_time;
@property (nonatomic, strong) NSMutableArray<SCXHomeAllModel *> *data;
@end
