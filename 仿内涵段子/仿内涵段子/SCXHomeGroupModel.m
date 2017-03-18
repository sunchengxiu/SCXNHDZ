//
//  SCXHomeGroupModel.m
//  仿内涵段子
//
//  Created by 孙承秀 on 16/9/27.
//  Copyright © 2016年 孙先森丶. All rights reserved.
//

#import "SCXHomeGroupModel.h"

@implementation SCXHomeGroupModel
+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{
             @"video_360P": @"360p_video",
             @"video_720P": @"720p_video" ,
             @"video_480P":@"480p_video",
             };
}
+ (NSDictionary *)mj_objectClassInArray {
    return @{
             @"dislike_reason":NSStringFromClass([SCXElementGroupDislike_reason class]),
             @"large_image_list":NSStringFromClass([SCXElementGroupLargeImage class]),
             @"thumb_image_list":NSStringFromClass([SCXElementGroupLargeImage class]),
             };
}
@end
