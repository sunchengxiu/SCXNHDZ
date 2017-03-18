//
//  SCXShareManager.h
//  仿内涵段子
//
//  Created by 孙承秀 on 16/10/12.
//  Copyright © 2016年 孙先森丶. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "single.h"
typedef NS_ENUM(NSInteger,SCXShareManagerType) {
SCXShareManagerTypeQQ=1,
    SCXShareManagerTypeQZone,
    SCXShareManagerTypeWechatSession,
    SCXShareManagerTypeWechat,
    SCXShareManagerTypeWeibo

};
@interface SCXShareManager : NSObject
singleH(Manager)
-(void)shareWithShareType:(SCXShareManagerType)type image:(UIImage *)image url:(NSString *)url content:(NSString *)content cobtroller:(UIViewController *)controller;
-(void)registerAllPlatforms;
@end
