//
//  SCXHomeCommentModel.h
//  仿内涵段子
//
//  Created by 孙承秀 on 16/9/27.
//  Copyright © 2016年 孙先森丶. All rights reserved.
//

#import "SCXBaseModel.h"
/**
 *  神评论
 */
@interface SCXHomeCommentModel : SCXBaseModel

@property (nonatomic, copy) NSString *text;
@property (nonatomic, copy) NSString *share_url;
@property (nonatomic, copy) NSString *user_name;
@property (nonatomic, copy) NSString *user_profile_image_url;
@property (nonatomic, copy) NSString *platform;
@property (nonatomic, copy) NSString *platformid;
@property (nonatomic, copy) NSString *user_profile_url;
@property (nonatomic, copy) NSString *avatar_url;

@property (nonatomic, assign) BOOL user_verified;

@property (nonatomic, assign) NSInteger create_time;
@property (nonatomic, assign) NSInteger user_bury;
/** 用户ID*/
@property (nonatomic, assign) NSInteger user_id;
@property (nonatomic, assign) NSInteger ID;
@property (nonatomic, assign) NSInteger is_digg;
@property (nonatomic, assign) NSInteger status;
@property (nonatomic, assign) NSInteger share_type;
@property (nonatomic, assign) NSInteger group_id;
@property (nonatomic, assign) NSInteger comment_id;
@property (nonatomic, strong) NSArray <SCXHomeCommentModel *>*reply_comments;
@end
