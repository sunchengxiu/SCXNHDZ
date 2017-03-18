//
//  SCXMonitoringRegionViewController.m
//  仿内涵段子
//
//  Created by 孙承秀 on 16/10/8.
//  Copyright © 2016年 孙先森丶. All rights reserved.
//

#import "SCXMonitoringRegionViewController.h"

@interface SCXMonitoringRegionViewController ()
@property(nonatomic,strong)NSMutableArray *regions;
@end

@implementation SCXMonitoringRegionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configmap];
    [self configLocationManger];
    [self getCurrentLocation];
    self.view.backgroundColor=[UIColor purpleColor];
    
}
-(NSMutableArray *)regions{
    if (!_regions) {
        _regions=[[NSMutableArray alloc] initWithCapacity:0];
    }
    return _regions;
}
-(void)configmap{
    if (self.mapView==nil) {
        self.mapView=[[MAMapView alloc]initWithFrame:self.view.frame];
        self.mapView.delegate=self;
        self.mapView.showTraffic=YES;
        self.mapView.showsUserLocation=YES;
        [self.view addSubview:self.mapView];
        
    }
}
-(void)configLocationManger{
    self.locationManager=[[AMapLocationManager alloc]init];
    [self.locationManager setDelegate:self];
    [self.locationManager setPausesLocationUpdatesAutomatically:NO];
    [self.locationManager setAllowsBackgroundLocationUpdates:YES];

}
#pragma mark--获取当前位置
-(void)getCurrentLocation{
    [self.locationManager requestLocationWithReGeocode:NO completionBlock:^(CLLocation *location, AMapLocationReGeocode *regeocode, NSError *error) {
        [self addCircleRegionUseCoordinate:location.coordinate];
    }];
}
#pragma mark--创建地理围栏
-(void)addCircleRegionUseCoordinate:(CLLocationCoordinate2D)coordinate{
    AMapLocationCircleRegion *circleRegion=[[AMapLocationCircleRegion alloc]initWithCenter:coordinate radius:200.0 identifier:@"200ID"];
    AMapLocationCircleRegion *region300=[[AMapLocationCircleRegion alloc]initWithCenter:coordinate radius:300.0 identifier:@"300ID"];
    /**
     *  开始监控指定的region
     *
     *  如果已经存在相同identifier的region，则之前的region将会被移除。
     *  对 AMapLocationCircleRegion 类实例，将会优先监控radius小的region。
     *
     *  @param region 要被监控的范围
     */
    [self.locationManager startMonitoringForRegion:circleRegion];
    [self.locationManager startMonitoringForRegion:region300];
    [self.regions addObject:circleRegion];
    [self.regions addObject:region300];
    MACircle *circle200=[MACircle circleWithCenterCoordinate:coordinate radius:200.0];
    MACircle *circle300=[MACircle circleWithCenterCoordinate:coordinate radius:300.0];
    /*!
     @brief 向地图添加Overlay，需要实现MAMapViewDelegate的-mapView:rendererForOverlay:函数来生成标注对应的Renderer
     @param overlay 要添加的overlay
     */
    [self.mapView addOverlay:circle200];
    [self.mapView addOverlay:circle300];
    //可视范围
    [self.mapView setVisibleMapRect:circle300.boundingMapRect];
    
}
-(void)amapLocationManager:(AMapLocationManager *)manager didFailWithError:(NSError *)error{
    NSLog(@"%ld,%@",error.code,error.localizedDescription);
}
-(void)amapLocationManager:(AMapLocationManager *)manager didStartMonitoringForRegion:(AMapLocationRegion *)region{
    NSLog(@"Region:%@",region);

}
-(void)amapLocationManager:(AMapLocationManager *)manager monitoringDidFailForRegion:(AMapLocationRegion *)region withError:(NSError *)error{
    NSLog(@"monitoringDidFailForRegion:%@", error.localizedDescription);
}
- (void)amapLocationManager:(AMapLocationManager *)manager didEnterRegion:(AMapLocationRegion *)region
{
    NSLog(@"didEnterRegion:%@", region);
}
- (void)amapLocationManager:(AMapLocationManager *)manager didExitRegion:(AMapLocationRegion *)region
{
    NSLog(@"didExitRegion:%@", region);
}

- (void)amapLocationManager:(AMapLocationManager *)manager didDetermineState:(AMapLocationRegionState)state forRegion:(AMapLocationRegion *)region
{
    NSLog(@"didDetermineState:%@; state:%ld", region, (long)state);
}
-(MAOverlayRenderer *)mapView:(MAMapView *)mapView rendererForOverlay:(id<MAOverlay>)overlay{
    if ([overlay isKindOfClass:[MAPolygon class]]) {
        MAPolygonRenderer *polygon=[[MAPolygonRenderer alloc] initWithPolygon:overlay];
        polygon.lineWidth=5.0f;
        polygon.strokeColor=[UIColor blueColor];
        return polygon;
    }
    else if([overlay isKindOfClass:[MACircle class  ]]){
        MACircleRenderer *circle=[[MACircleRenderer alloc]initWithCircle:overlay];
        circle.lineWidth=5;
        circle.strokeColor=[UIColor blueColor];
        return circle;
    }
    return nil;
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.locationManager setDelegate:nil];
    [self.regions enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [self.locationManager stopMonitoringForRegion:(AMapLocationRegion *)obj];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
