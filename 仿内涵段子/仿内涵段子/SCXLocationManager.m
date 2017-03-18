//
//  SCXLocationManager.m
//  仿内涵段子
//
//  Created by 孙承秀 on 16/10/8.
//  Copyright © 2016年 孙先森丶. All rights reserved.
//

#import "SCXLocationManager.h"
#import "SCXFileCacheManager.h"
@implementation SCXLocationManager
singleM(locationManager)
-(void)startSerialLocation{

    if (self.canLocation==NO) {
        return;
    }
    /**
     *  开始连续定位
     *
     *  调用此方法会cancel掉所有的单次定位请求。
     */
    [self.locationManager startUpdatingLocation];
}
-(void)stopSeriallocation{
    [self.locationManager stopUpdatingLocation];
}
-(AMapLocationManager *)locationManager{
    if (!_locationManager) {
        _locationManager=[[AMapLocationManager alloc]init];
        _locationManager.delegate=self;
        /**
         *  指定定位是否会被系统自动暂停。默认为YES。
         */
        _locationManager.pausesLocationUpdatesAutomatically=NO;
        /**
         *  设定定位精度。默认为 kCLLocationAccuracyBest 。
         */
        _locationManager.desiredAccuracy=kCLLocationAccuracyHundredMeters;
        /**
         *  是否允许后台定位。默认为NO。只在iOS 9.0及之后起作用。
         *
         *  设置为YES的时候必须保证 Background Modes 中的 Location updates 处于选中状态，否则会抛出异常。
         */
        _locationManager.allowsBackgroundLocationUpdates=YES;
    }
    return _locationManager;

}
#pragma mark--AMapLocationDelegate

/**
 定位错误

 */
-(void)amapLocationManager:(AMapLocationManager *)manager didFailWithError:(NSError *)error{
    NSLog(@"定位错误%@",error);
}

/**
 定位结果
 */
-(void)amapLocationManager:(AMapLocationManager *)manager didUpdateLocation:(CLLocation *)location{

    NSString *latitude=[NSString stringWithFormat:@"%f",location.coordinate.latitude];
    NSString *longitude=[NSString stringWithFormat:@"%f",location.coordinate.longitude];
    [SCXFileCacheManager saveUserDataWithObject:latitude forKey:kLatitude];
    [SCXFileCacheManager saveUserDataWithObject:longitude forKey:klongitude];
    if (_updateLocationblock) {
        _updateLocationblock(location,latitude,longitude);
    }
}
-(BOOL)isCanLocation{
    if ([CLLocationManager locationServicesEnabled]&&([CLLocationManager authorizationStatus]==kCLAuthorizationStatusAuthorized||[CLLocationManager authorizationStatus]==kCLAuthorizationStatusNotDetermined||[CLLocationManager authorizationStatus]==kCLAuthorizationStatusAuthorizedWhenInUse)) {
        return YES;
    }
    else{
        return NO;
    }

}
-(BOOL)isHasLocation{
    return ([[SCXFileCacheManager getUserDataWithKey:kLatitude] length])&&([[SCXFileCacheManager getUserDataWithKey:klongitude] length]);
}
@end
