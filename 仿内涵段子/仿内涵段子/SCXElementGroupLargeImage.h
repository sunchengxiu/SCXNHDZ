//
//  SCXElementGroupLargeImage.h
//  仿内涵段子
//
//  Created by 孙承秀 on 16/9/27.
//  Copyright © 2016年 孙先森丶. All rights reserved.
//

#import "SCXBaseModel.h"
#import "SCXElementGroupLargeImageUrl.h"
@interface SCXElementGroupLargeImage : SCXBaseModel
@property (nonatomic, copy) NSString *url;
@property (nonatomic, copy) NSString *uri;
@property (nonatomic, assign) NSInteger height;
@property (nonatomic, assign) NSInteger width;
@property (nonatomic, assign) BOOL is_gif;
@property (nonatomic, strong) NSMutableArray <SCXElementGroupLargeImageUrl *>*url_list;
@end
