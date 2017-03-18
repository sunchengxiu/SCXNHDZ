//
//  SCXSingleAloneViewController.m
//  仿内涵段子
//
//  Created by 孙承秀 on 16/10/8.
//  Copyright © 2016年 孙先森丶. All rights reserved.
//

#import "SCXSingleAloneViewController.h"

@interface SCXSingleAloneViewController ()
@property(nonatomic,strong)UILabel *locationLabel;
@property(nonatomic,strong)AMapLocationManager *locationManager;
@property(nonatomic,copy)AMapLocatingCompletionBlock complementBlocak;
@end

@implementation SCXSingleAloneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    [self setUpLabel];
    [self initBlock];
    [self setUpLocationManager];
    [self startLocation];
    // Do any additional setup after loading the view.
}
-(void)initBlock{
    __block typeof(self)weakSelf=self;
    self.complementBlocak=^(CLLocation *location,AMapLocationReGeocode *recode,NSError *err){
        if (err) {
            if (err.code==AMapLocationErrorLocateFailed) {
                return ;
            }
        }
        else{
            /*
             @property (nonatomic, copy) NSString *country; //!< 国家
             @property (nonatomic, copy) NSString *province; //!< 省/直辖市
             @property (nonatomic, copy) NSString *city;     //!< 市
             @property (nonatomic, copy) NSString *district; //!< 区
             @property (nonatomic, copy) NSString *township; //!< 乡镇
             @property (nonatomic, copy) NSString *neighborhood; //!< 社区
             @property (nonatomic, copy) NSString *building; //!< 建筑
             @property (nonatomic, copy) NSString *citycode; //!< 城市编码
             @property (nonatomic, copy) NSString *adcode;   //!< 区域编码
             
             @property (nonatomic, copy) NSString *street;   //!< 街道名称
             @property (nonatomic, copy) NSString *number;   //!< 门牌号
             
             @property (nonatomic, copy) NSString *POIName; //!< 兴趣点名称
             @property (nonatomic, copy) NSString *AOIName; //!< 所属兴趣点名称
             */
           weakSelf.locationLabel.text=[NSString stringWithFormat:@"位置:%@\n精度：%.2f;\n纬度:%.2f;\n街道：%@;\n门牌号：%@\n所属兴趣点:%@;\n兴趣点：%@；\n社区：%@",recode.formattedAddress,location.coordinate.latitude,location.coordinate.longitude,recode.street,recode.number,recode.AOIName,recode.POIName,recode.neighborhood];
        }
    
    };

}
-(void)setUpLocationManager{
    self.locationManager=[[AMapLocationManager alloc]init];
    self.locationManager.pausesLocationUpdatesAutomatically=NO;
    self.locationManager.allowsBackgroundLocationUpdates=YES;
    self.locationManager.desiredAccuracy=kCLLocationAccuracyNearestTenMeters;
    self.locationManager.locationTimeout=6;
    self.locationManager.reGeocodeTimeout=3;
    self.locationManager.delegate=self;
}
-(void)startLocation{
    [self.locationManager requestLocationWithReGeocode:YES completionBlock:self.complementBlocak];

}
-(void)setUpLabel{
    UILabel *label=({
        UILabel *label=[[UILabel alloc]init];
        _locationLabel=label;
        [label setBackgroundColor:[UIColor greenColor]];
        [self.view addSubview:label];
        label.numberOfLines=0;
        [label setTextColor:[UIColor purpleColor]];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.mas_equalTo(self.view);
            make.left.mas_equalTo(self.view.mas_left).offset(50);
            make.right.mas_equalTo(self.view.mas_right).offset(-50);
        }];
        label;
    });

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
