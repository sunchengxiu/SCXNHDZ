//
//  SCXHomeCommentModel.m
//  仿内涵段子
//
//  Created by 孙承秀 on 16/9/27.
//  Copyright © 2016年 孙先森丶. All rights reserved.
//

#import "SCXHomeCommentModel.h"

@implementation SCXHomeCommentModel
+ (NSDictionary *)mj_objectClassInArray {
    return @{
             @"reply_comments":NSStringFromClass([SCXHomeCommentModel class]),
             };
}
@end
