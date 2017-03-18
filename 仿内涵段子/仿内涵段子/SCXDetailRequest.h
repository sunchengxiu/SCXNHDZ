//
//  SCXDetailRequest.h
//  仿内涵段子
//
//  Created by 孙承秀 on 16/10/12.
//  Copyright © 2016年 孙先森丶. All rights reserved.
//

#import "SCXBaseRequestHelp.h"

@interface SCXDetailRequest : SCXBaseRequestHelp
@property (nonatomic, assign) NSInteger offset;
@property (nonatomic, assign) NSString *sort;
@property (nonatomic, assign) NSInteger group_id;
@end
