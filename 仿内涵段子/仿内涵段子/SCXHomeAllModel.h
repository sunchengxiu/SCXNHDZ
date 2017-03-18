//
//  SCXHomeElementModel.h
//  仿内涵段子
//
//  Created by 孙承秀 on 16/9/27.
//  Copyright © 2016年 孙先森丶. All rights reserved.
//

#import "SCXBaseModel.h"
#import "SCXHomeGroupModel.h"
#import "SCXHomeCommentModel.h"
/**
 *  总数据Model
 */
@interface SCXHomeAllModel : SCXBaseModel
/** 列表数据*/
@property (nonatomic, strong)SCXHomeGroupModel   *group;
/** 列表中神评论*/
@property (nonatomic, strong) NSMutableArray <SCXHomeCommentModel *>*comments;
@property (nonatomic, assign) NSInteger type;
@property (nonatomic, assign) NSInteger display_time;
@property (nonatomic, assign) NSInteger online_time;
@end
