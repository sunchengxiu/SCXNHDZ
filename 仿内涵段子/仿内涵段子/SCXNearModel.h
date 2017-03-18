//
//  SCXNearModel.h
//  仿内涵段子
//
//  Created by 孙承秀 on 16/10/8.
//  Copyright © 2016年 孙先森丶. All rights reserved.
//

#import "SCXBaseModel.h"

@interface SCXNearModel : SCXBaseModel
@property (nonatomic, copy) NSString *distance;
@property (nonatomic, copy) NSString *screen_name;
@property (nonatomic, assign) NSInteger user_id;
@property (nonatomic, copy) NSString *desc;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *avatar_url;
@property (nonatomic, assign) NSInteger gender;
@property (nonatomic, assign) NSInteger last_update;
@end
