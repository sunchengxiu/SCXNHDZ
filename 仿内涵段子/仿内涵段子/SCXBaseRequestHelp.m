//
//  SCXBaseRequestHelp.m
//  仿内涵段子
//
//  Created by 孙承秀 on 16/9/24.
//  Copyright © 2016年 孙先森丶. All rights reserved.
//

#import "SCXBaseRequestHelp.h"
#import "NSNotificationCenter+costom.h"

@implementation SCXBaseRequestHelp
+(instancetype)SCX_Request{
    return [[self alloc] init];
}
-(void)setSCX_url:(NSString *)SCX_url{
    if (SCX_url.length==0||[SCX_url isKindOfClass:[NSNull class]]) {
        return;
    }
    _SCX_url=SCX_url;

}
+(instancetype)SCX_requestWithUrl:(NSString *)url{
    return [self SCX_requestWithUrl:url andIsPost:NO];
}
+(instancetype)SCX_requestWithUrl:(NSString *)url andIsPost:(BOOL)post{
    return [self SCX_requestWithUrl:url andIsPost:post withDelegate:nil];

}
+(instancetype)SCX_requestWithUrl:(NSString *)url andIsPost:(BOOL)post withDelegate:(id <SCXBaseRequestResponseDelegate> )delegate{
    SCXBaseRequestHelp *request=[SCXBaseRequestHelp SCX_Request];
    request.SCX_url=url;
    request.SCX_isPost=post;
    request.SCX_RequestDelegate=delegate;
    return request;

}
#pragma mark -- 发送请求
-(void)SCX_sendRequest{
    [self SCX_sendRequestWithComplement:nil];
}
#pragma mark -- 发送请求
-(void)SCX_sendRequestWithComplement:(SCXRequestFinishCompletion)complement{
    NSString *url=self.SCX_url;
  //  NSDictionary *params = nil;
    if (url.length==0) {
        return;
    }
    NSDictionary *params=[self params];;
    
    if (self.SCX_isPost) {
        //普通post请求
        if (self.SCX_imageArray.count==0) {
            [SCXRequestManager POST:url parameters:params responseSeializerType:SCXResponseSeializerTypeJson success:^(id responseObject) {
                //处理请求后的数据
                [self handleResponseData:responseObject complement:complement];
            } fauile:^(NSError *error) {
                NSLog(@"请求失败了，暂不处理");
            }];
        }
    }
    else{
        [SCXRequestManager GET:url parameters:params responseSeializerType:SCXResponseSeializerTypeJson success:^(id responseObject) {
            //处理请求后的数据
            [self handleResponseData:responseObject complement:complement];
        } fauile:^(NSError *error) {
            NSLog(@"请求失败了，暂不处理");
        }];
    }
    //post 上传请求
    if (self.SCX_imageArray.count>0) {
        [SCXRequestManager POST:url parameters:params responseSeializerType:SCXResponseSeializerTypeJson success:^(id responseObject) {
            
        } fauile:^(NSError *err) {
            NSLog(@"上传失败了");
        } constructingBodyWithBlock:^(id<AFMultipartFormData> formdata) {
            //处理上传数据
            [self handleConstructingBody:formdata];
        }];
    }
}
#pragma mark -- 处理上传图片
-(void)handleConstructingBody:(id <AFMultipartFormData>)formData{
    dispatch_apply(self.SCX_imageArray.count, dispatch_get_global_queue(0, 0), ^(size_t i) {
        NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
        formatter.dateFormat = @"yyyy:MM:dd hh:mm:ss:SSS";
        NSString *fileName = [NSString stringWithFormat:@"%@%@",[formatter stringFromDate:[NSDate date]],@(i)];
        [formData appendPartWithFileData:UIImagePNGRepresentation(self.SCX_imageArray[i]) name:@"file" fileName:fileName mimeType:@"image/png"];
        
    });

}
#pragma mark -- 处理请求后的数据
-(void)handleResponseData:(id)responseObject complement:(SCXRequestFinishCompletion)complement{
    //如果是retry那么久重试
    if ([responseObject[@"message"] isEqualToString:@"retry"]) {
        [self SCX_sendRequestWithComplement:complement];
        return;
    }
    // 数据请求成功回调
    BOOL success = [responseObject[@"message"] isEqualToString:@"success"];
    //如果block存在就用block回传，如果不存在再用代理方法回调，保证数据都能成功回调
    if (complement) {
        complement(responseObject[@"data"],success,responseObject[@"message"]);
    }
    else{
        if ([self.SCX_RequestDelegate respondsToSelector:@selector(requestFinishWithIsSuccess:AndResponse:andMessage:)]) {
            [self.SCX_RequestDelegate requestFinishWithIsSuccess:success AndResponse:responseObject[@"data"] andMessage:responseObject[@"message"]];
        }
    }
    //发送成功通知
    [NSNotificationCenter postNotificationName:KSCXRequestSendSuccessNotifagition];

}
- (NSDictionary *)params {
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    //http://lf.snssdk.com/neihan/user/nearby/v1/?ac=WIFI&aid=7&app_name=joke_essay&channel=App%20Store&count=50&device_id=10752255605&device_platform=iphone&device_type=iPhone%206%20Plus&gender=-1&idfa=832E262C-31D7-488A-8856-69600FAABE36&iid=5316804410&latitude=40.07233784961181&live_sdk_version=120&longitude=116.3415643071043&max_time=1475917222.53&openudid=cbb1d9e8770b26c39fac806b79bf263a50da6666&os_api=18&os_version=9.3.4&screen_width=1242&tag=joke&version_code=5.5.0&vid=4A4CBB9E-ADC3-426B-B562-9FC8173FDA52
    params[@"tag"] = @"joke";
    params[@"iid"] = @"5316804410";
    params[@"os_version"] = @"9.3.4";
    params[@"os_api"] = @"18";
    
    params[@"app_name"] = @"joke_essay";
    params[@"channel"] = @"App Store";
    params[@"device_platform"] = @"iphone";
    params[@"idfa"] = @"832E262C-31D7-488A-8856-69600FAABE36";
    params[@"live_sdk_version"] = @"120";
    
    params[@"vid"] = @"4A4CBB9E-ADC3-426B-B562-9FC8173FDA52";
    params[@"openudid"] = @"cbb1d9e8770b26c39fac806b79bf263a50da6666";
    params[@"device_type"] = @"iPhone 6 Plus";
    params[@"version_code"] = @"5.5.0";
    params[@"ac"] = @"WIFI";
    params[@"screen_width"] = @"1242";
    params[@"device_id"] = @"10752255605";
    params[@"aid"] = @"7";
    params[@"count"] = @"50";
    params[@"max_time"] = [NSString stringWithFormat:@"%.2f", [[NSDate date] timeIntervalSince1970]];
    
    [params addEntriesFromDictionary:self.mj_keyValues];
    
    if ([params.allKeys containsObject:@"nh_delegate"]) {
        [params removeObjectForKey:@"nh_delegate"];
    }
    if ([params.allKeys containsObject:@"nh_isPost"]) {
        [params removeObjectForKey:@"nh_isPost"];
    }
    if ([params.allKeys containsObject:@"nh_url"]) {
        [params removeObjectForKey:@"nh_url"];
    }
    if (self.SCX_imageArray.count == 0) {
        if ([params.allKeys containsObject:@"nh_imageArray"]) {
            [params removeObjectForKey:@"nh_imageArray"];
        }
    }
    return params;
}
@end
