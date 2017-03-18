//
//  SCXHomeModel.h
//  仿内涵段子
//
//  Created by 孙承秀 on 16/9/26.
//  Copyright © 2016年 孙先森丶. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SCXBaseModel.h"
@interface SCXHomeModel : SCXBaseModel
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *url;
@property (nonatomic, assign) NSInteger type;
@property (nonatomic, assign) NSInteger refresh_interval;
@end
