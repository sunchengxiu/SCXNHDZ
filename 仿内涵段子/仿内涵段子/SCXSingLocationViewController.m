//
//  SCXSingLocationViewController.m
//  仿内涵段子
//
//  Created by 孙承秀 on 16/10/8.
//  Copyright © 2016年 孙先森丶. All rights reserved.
//

#import "SCXSingLocationViewController.h"

@interface SCXSingLocationViewController ()

@end

@implementation SCXSingLocationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor purpleColor];
    [self initMapView];
    [self initComplementBlock];
    [self configLocationManager];
    [self startReGeocodeAction];
    // Do any additional setup after loading the view.
}
-(void)configLocationManager{
    self.locationManager=[[AMapLocationManager alloc]init];
    self.locationManager.delegate=self;
    self.locationManager.pausesLocationUpdatesAutomatically=NO;
    self.locationManager.allowsBackgroundLocationUpdates=YES;
    self.locationManager.desiredAccuracy=kCLLocationAccuracyHundredMeters;
    self.locationManager.locationTimeout=6.0;
    self.locationManager.reGeocodeTimeout=3;
    
}
-(void)cleanLocation{
    [self.locationManager stopUpdatingLocation];
    [self.locationManager setDelegate:nil];
    [self.mapView removeAnnotations:self.mapView.annotations];
    

}
-(void)startReGeocodeAction{

    //[self.mapView removeAnnotations:self.mapView.annotations];
    [self.locationManager requestLocationWithReGeocode:YES completionBlock:self.complementBlock];
}
-(void)initComplementBlock{
    //__block typeof (self)weakSelf=self;
    __weak SCXSingLocationViewController *weakSelf = self;
    self.complementBlock=^(CLLocation *location,AMapLocationReGeocode *regeocode,NSError *error){
        if (error) {
            if (error.code==AMapLocationErrorLocateFailed) {
                return ;
            }
        }
            if (location) {
                MAPointAnnotation *annotation=[[MAPointAnnotation alloc]init];
                [annotation setCoordinate:location.coordinate]
                ;
                if (regeocode) {
                    [annotation setTitle:[NSString stringWithFormat:@"%@",regeocode.formattedAddress]];
                    [annotation setSubtitle:[NSString stringWithFormat:@"%@-%@-%.2fm",regeocode.street,regeocode.number,location.horizontalAccuracy]];
                }
                else{
                    [annotation setTitle:[NSString stringWithFormat:@"精度：%.2f；维度：%.2f",location.coordinate.latitude,location.coordinate.longitude]];
                    [annotation setSubtitle:[NSString stringWithFormat:@"%.2f",location.horizontalAccuracy]];
                }
                SCXSingLocationViewController *strongSelf = weakSelf;
                 [strongSelf addAnnotation1:annotation];
            }
           
        
        
        
    
    };

}
-(void)addAnnotation1:(id<MAAnnotation>)annotation{
    NSLog(@"%@",annotation);
    [self.mapView addAnnotation:annotation];
    [self.mapView selectAnnotation:annotation animated:YES];
    [self.mapView setZoomLevel:15.1 animated:YES];
    [self.mapView setCenterCoordinate:annotation.coordinate animated:YES];

}
- (void)initMapView
{
    if (self.mapView == nil)
    {
        self.mapView = [[MAMapView alloc] initWithFrame:self.view.bounds];
        [self.mapView setDelegate:self];
        
        [self.view addSubview:self.mapView];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    // Dispose of any resources that can be recreated.
}
- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id<MAAnnotation>)annotation
{
    if ([annotation isKindOfClass:[MAPointAnnotation class]])
    {
        static NSString *pointReuseIndetifier = @"pointReuseIndetifier";
        
        MAPinAnnotationView *annotationView = (MAPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:pointReuseIndetifier];
        if (annotationView == nil)
        {
            annotationView = [[MAPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:pointReuseIndetifier];
        }
        
        annotationView.canShowCallout   = YES;
        annotationView.animatesDrop     = YES;
        annotationView.draggable        = YES;
        annotationView.pinColor         = MAPinAnnotationColorPurple;
        
        return annotationView;
    }
    
    return nil;
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self cleanLocation];
    [self.mapView setDelegate:nil];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
