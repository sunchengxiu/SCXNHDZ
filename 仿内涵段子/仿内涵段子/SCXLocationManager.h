//
//  SCXLocationManager.h
//  仿内涵段子
//
//  Created by 孙承秀 on 16/10/8.
//  Copyright © 2016年 孙先森丶. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^LocationManagerDidUpDateLocationHandleBlock  )(CLLocation *location,NSString *latitude,NSString *longitude);
@interface SCXLocationManager : NSObject<AMapLocationManagerDelegate>
singleH(locationManager)

/**
 是否允许定位
 */
@property(nonatomic,assign)BOOL canLocation;

/**
 是否有经纬度
 */
@property(nonatomic,assign)BOOL isHasLocation;

/**
 开始连续定位
 */
-(void)startSerialLocation;
@property(nonatomic,strong)AMapLocationManager *locationManager;

/**
 停止定位
 */
-(void)stopSeriallocation;
@property(nonatomic,copy)LocationManagerDidUpDateLocationHandleBlock updateLocationblock;
-(BOOL)isHasLocation;
-(BOOL)isCanLocation;
@end
