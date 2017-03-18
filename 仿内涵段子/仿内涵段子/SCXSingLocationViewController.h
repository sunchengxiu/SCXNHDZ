//
//  SCXSingLocationViewController.h
//  仿内涵段子
//
//  Created by 孙承秀 on 16/10/8.
//  Copyright © 2016年 孙先森丶. All rights reserved.
//

#import "SCXBaseController.h"
#import <MAMapKit/MAMapKit.h>

@interface SCXSingLocationViewController : SCXBaseController<AMapLocationManagerDelegate,MAMapViewDelegate>
@property(nonatomic,strong)AMapLocationManager  *locationManager;
@property(nonatomic,strong)MAMapView *mapView;
@property(nonatomic,copy)AMapLocatingCompletionBlock complementBlock;
@end
