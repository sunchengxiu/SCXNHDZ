//
//  SCXElementGroupLargeImage.m
//  仿内涵段子
//
//  Created by 孙承秀 on 16/9/27.
//  Copyright © 2016年 孙先森丶. All rights reserved.
//

#import "SCXElementGroupLargeImage.h"

@implementation SCXElementGroupLargeImage
+(NSDictionary *)mj_objectClassInArray{
    return @{
             @"url_list":NSStringFromClass([SCXElementGroupLargeImageUrl class]),
             };

}
@end
