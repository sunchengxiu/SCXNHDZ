//
//  SCXNearViewController.m
//  仿内涵段子
//
//  Created by 孙承秀 on 16/10/8.
//  Copyright © 2016年 孙先森丶. All rights reserved.
//

#import "SCXNearViewController.h"
#import "SCXNearRequest.h"
#import "SCXNearModel.h"
#import "SCXNearCell.h"
@interface SCXNearViewController ()

@end

@implementation SCXNearViewController

- (void)viewDidLoad {
    self.navigationItem.title=@"附近段友";
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    NSArray *arr=@[@"SCXSingLocationViewController",@"SCXSingleAloneViewController",@"SCXMonitoringRegionViewController"];
    self.dataArray=[[NSMutableArray alloc]initWithArray:arr];
    // Do any additional setup after loading the view.
}
#pragma mark--加载附近数据
-(void)loadNearData{
    if ([[SCXLocationManager sharedlocationManager] isHasLocation]) {
        NSString *latitude=[[NSUserDefaults standardUserDefaults] objectForKey:kLatitude];
        NSString *longtitude=[[NSUserDefaults standardUserDefaults] objectForKey:klongitude];
        [self loadDataWithlatitude:latitude andLongtitude:longtitude];
        
        
    }
    else{
        [[SCXLocationManager sharedlocationManager] startSerialLocation];
        [SCXLocationManager sharedlocationManager].updateLocationblock=^(CLLocation *location,NSString *latitude,NSString *longtitude){
            [self loadDataWithlatitude:latitude andLongtitude:longtitude];
        
        };;
        // 默认加载这个经纬度附近的人
        [self loadDataWithlatitude:@"40.07233784961181"  andLongtitude:@"116.3415643071043"];
    }
}
-(void)loadDataWithlatitude:(NSString *)latitude andLongtitude:(NSString *)longtitude{
    SCXNearRequest *request=[SCXNearRequest SCX_Request];
    request.SCX_url=kNearRequestUrl;
    request.genter=self.genter;
    request.latitude=latitude;
    request.longitude=longtitude;
    [request SCX_sendRequestWithComplement:^(id responseObject, BOOL success, NSString *str) {
        if (success) {
            [self.dataArray removeAllObjects];
            self.dataArray=[SCXNearModel objectArrayWithKeyValuesArray:responseObject[@"user_list"]];
            [self SCX_reloadData];
        }
    }];
   
    
}
-(NSInteger)SCX_numberOfSectionsInTableView:(UITableView *)tableView{

    return 1;
}
-(SCXBaseTableViewCell *)SCX_tableViewCellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellID=@"cellID";
    UITableViewCell *cell=[self.tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.textLabel.text=self.dataArray[indexPath.row];
    
    return cell;
}
-(NSInteger)SCX_tableViewNumberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}
-(CGFloat)SCX_tableViewHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 75;
}
-(void)SCX_tableViewDidSelectRowAtIndexPath:(NSIndexPath *)indexPath withCell:(SCXBaseTableViewCell *)cell{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    UIViewController *viewController=[NSClassFromString(self.dataArray[indexPath.row]) new];
    [self pushViewController:viewController];

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
