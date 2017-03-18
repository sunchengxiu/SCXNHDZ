//
//  SCXHomeGroupModel.h
//  仿内涵段子
//
//  Created by 孙承秀 on 16/9/27.
//  Copyright © 2016年 孙先森丶. All rights reserved.
//

#import "SCXBaseModel.h"
#import "SCXElementGroupLargeImage.h"
#import "SCXElementGroupGifVideo.h"
#import "SCXUserInfoModel.h"
#import "SCXElementGroupDislike_reason.h"
#import "SCXElementGroupLarge_Image.h"
/**
 *  数据类型
 */
typedef NS_ENUM(NSUInteger, SCXGroupMediaType) {
    /** 大图*/
    SCXGroupMediaTypeImage = 1,
    /** Gif图片*/
    SCXGroupMediaTypeGIF = 2,
    /** 视频*/
    SCXGroupMediaTypeVideo = 3,
    /** 小图*/
   SCXGroupMediaTypeLittleImages = 4,
    /** 精华*/
    SCXGroupMediaTypeEssence = 5,
    
    //    http://i.snssdk.com/neihan/in_app/essence_detail/6327517973125595394/?item_id=6327517935317287425&refer=click_feed
    
    
};
/**
 *  groupModel
 */
@interface SCXHomeGroupModel : SCXBaseModel
/** 文本*/
@property (nonatomic, copy) NSString *text;
@property (nonatomic, copy) NSString *share_url;
@property (nonatomic, copy) NSString *category_name;
@property (nonatomic, copy) NSString *status_desc;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSString *m3u8_url;
@property (nonatomic, copy) NSString *cover_image_url;

@property (nonatomic, assign) NSInteger category_id;
@property (nonatomic, assign) NSInteger create_time;
@property (nonatomic, assign) NSInteger ID;
@property (nonatomic, assign) NSInteger favorite_count;
@property (nonatomic, assign) NSInteger user_favorite;
@property (nonatomic, assign) NSInteger share_type;
@property (nonatomic, assign) NSInteger is_can_share;
@property (nonatomic, assign) NSInteger category_type;
@property (nonatomic, assign) NSInteger go_detail_count;
@property (nonatomic, assign) NSInteger comment_count;
@property (nonatomic, assign) NSInteger label;
@property (nonatomic, assign) NSInteger share_count;
@property (nonatomic, assign) NSInteger id_str;
@property (nonatomic, assign) NSInteger type;
@property (nonatomic, assign) NSInteger status;
@property (nonatomic, assign) NSInteger thas_commentsype;
/** 踩过*/
@property (nonatomic, assign) NSInteger user_bury;
/** 顶过*/
@property (nonatomic, assign) NSInteger user_digg;
/** 踩*/
@property (nonatomic, assign) NSInteger bury_count;
@property (nonatomic, assign) NSInteger online_time;
@property (nonatomic, assign) NSInteger repin_count;
/** 点赞*/
@property (nonatomic, assign) NSInteger digg_count;
@property (nonatomic, assign) NSInteger has_hot_comments;
@property (nonatomic, assign) NSInteger user_repin;
@property (nonatomic, assign) NSInteger duration;

@property (nonatomic, assign) BOOL allow_dislike;
@property (nonatomic, assign) BOOL category_visible;
@property (nonatomic, assign) BOOL is_anonymous;
@property (nonatomic, assign) BOOL is_multi_image;
@property (nonatomic, assign) BOOL is_gif;
@property (nonatomic, assign) BOOL has_comments;
@property(nonatomic,assign)SCXGroupMediaType media_type;
@property (nonatomic, strong) SCXElementGroupLargeImage * video_360P;
@property (nonatomic, strong) SCXElementGroupLargeImage * video_720P;
@property (nonatomic, strong) SCXElementGroupLargeImage * video_480p;

@property (nonatomic, strong) SCXElementGroupLargeImage * large_cover;
@property (nonatomic, strong) SCXElementGroupLargeImage * medium_cover;
@property (nonatomic, strong) SCXElementGroupLargeImage * origin_video;

@property (nonatomic, strong) SCXElementGroupGifVideo * gifvideo;
/** 当前数据对应的用户信息*/
@property (nonatomic, strong) SCXUserInfoModel *user;

@property (nonatomic, strong) SCXElementGroupLarge_Image * large_image;
@property (nonatomic, strong) SCXElementGroupLarge_Image * middle_image;

@property (nonatomic, strong) NSMutableArray <SCXElementGroupDislike_reason *>* dislike_reason;
@property (nonatomic, strong) NSMutableArray <SCXElementGroupLargeImage *>* large_image_list;
@property (nonatomic, strong) NSMutableArray <SCXElementGroupLargeImage *>* thumb_image_list;

@end
