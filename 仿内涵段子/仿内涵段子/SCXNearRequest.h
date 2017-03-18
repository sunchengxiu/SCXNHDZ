//
//  SCXNearRequest.h
//  仿内涵段子
//
//  Created by 孙承秀 on 16/10/8.
//  Copyright © 2016年 孙先森丶. All rights reserved.
//

#import "SCXBaseRequestHelp.h"

@interface SCXNearRequest : SCXBaseRequestHelp
/**
 筛选种类，-1全部，0女，1男，3不明
 */
@property(nonatomic,assign)NSInteger genter;
@property (nonatomic, copy) NSString *latitude;
@property (nonatomic, copy) NSString *longitude;
@end
