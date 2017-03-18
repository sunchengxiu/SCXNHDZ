//
//  SCXElementGroupGifVideo.h
//  仿内涵段子
//
//  Created by 孙承秀 on 16/9/27.
//  Copyright © 2016年 孙先森丶. All rights reserved.
//

#import "SCXBaseModel.h"
#import "SCXElementGroupLargeImage.h"
@interface SCXElementGroupGifVideo : SCXBaseModel
@property (nonatomic, strong) SCXElementGroupLargeImage *video_360P;
@property (nonatomic, strong) SCXElementGroupLargeImage *video_720P;
@property (nonatomic, strong) SCXElementGroupLargeImage *video_480P;
@property (nonatomic, copy) NSString *mp4_url;
@property (nonatomic, copy) NSString *cover_image_uri;
@property (nonatomic, assign) NSInteger video_height;
@property (nonatomic, assign) CGFloat duration;
@property (nonatomic, assign) NSInteger video_width;
@end
