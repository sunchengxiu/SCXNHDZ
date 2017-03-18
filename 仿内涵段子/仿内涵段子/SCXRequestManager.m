//
//  SCXRequestManager.m
//  仿内涵段子
//
//  Created by 孙承秀 on 16/9/24.
//  Copyright © 2016年 孙先森丶. All rights reserved.
//

#import "SCXRequestManager.h"


@implementation SCXRequestManager
#pragma mark -- GET请求
/**
 * GET请求
 */
+(void)GET:(NSString *)url parameters:(id)para responseSeializerType:(SCXResponseSeializerType)responseSeializer success:(SUCCESS)success fauile:(Failure)failure{

    AFHTTPSessionManager *manager=[AFHTTPSessionManager manager];
     manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/plain", @"text/json", @"text/javascript", @"text/html", nil];
    if (responseSeializer!=SCXResponseSeializerTypeDefault&&responseSeializer!=SCXResponseSeializerTypeJson) {
        manager.responseSerializer=[self setHttpResponseSerializerWithSCXResponseSerializerTye:responseSeializer];
    }
    
    AFSecurityPolicy *policy=[AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate];
    policy.allowInvalidCertificates=YES;
    manager.securityPolicy=policy;
    [manager GET:url parameters:para success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
}
#pragma  mark -post请求
/**
 * post请求
 */
+(void)POST:(NSString *)url parameters:(id)para responseSeializerType:(SCXResponseSeializerType)responseSeializer success:(SUCCESS)success fauile:(Failure)failure{
    
    AFHTTPSessionManager *manager=[AFHTTPSessionManager manager];
     manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/plain", @"text/json", @"text/javascript", @"text/html", nil];
    if (responseSeializer!=SCXResponseSeializerTypeDefault&&responseSeializer!=SCXResponseSeializerTypeJson) {
        manager.responseSerializer=[self setHttpResponseSerializerWithSCXResponseSerializerTye:responseSeializer];
    }
    
    AFSecurityPolicy *policy=[AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate];
    policy.allowInvalidCertificates=YES;
    manager.securityPolicy=policy;
    [manager POST:url parameters:para success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
}
#pragma mark -- post上传数据
/**
 * post上传数据
 */
+(void)POST:(NSString *)url parameters:(id)para responseSeializerType:(SCXResponseSeializerType)responseSeializer success:(SUCCESS)success fauile:(Failure)failure constructingBodyWithBlock:(ConstructingBodyBlock)block{
    
    AFHTTPSessionManager *manager=[AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/plain", @"text/json", @"text/javascript", @"text/html", nil];
    if (responseSeializer!=SCXResponseSeializerTypeDefault&&responseSeializer!=SCXResponseSeializerTypeJson) {
        manager.responseSerializer=[self setHttpResponseSerializerWithSCXResponseSerializerTye:responseSeializer];
    }
    [manager POST:url parameters:para constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        if (block) {
            block(formData);
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        if (success) {
            success(responseObject);
            
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
}
#pragma mark -- 设置数据解析器类型
/**
 * 设置数据解析器的类型 
 * @param responseSerializerType 数据解析器类型
 */
+(AFHTTPResponseSerializer *)setHttpResponseSerializerWithSCXResponseSerializerTye:(SCXResponseSeializerType)responseSerializerType{

    switch (responseSerializerType) {
        case SCXResponseSeializerTypeDefault:
            return  [AFJSONResponseSerializer serializer];
            break;
            case SCXResponseSeializerTypeXML:
            return [AFXMLParserResponseSerializer serializer];
            break;
            case SCXResponseSeializerTypePlist:
            return [AFPropertyListResponseSerializer serializer];
            break;
            case SCXResponseSeializerTypeJson:
            return [AFJSONResponseSerializer serializer];
            break;
            case SCXResponseSeializerTypeCompound:
            return [AFCompoundResponseSerializer serializer];
            break;
            case SCXResponseSeializerTypeData:
            return [AFHTTPResponseSerializer serializer];
            break;
            case SCXResponseSeializerTypeImage:
            return [AFImageResponseSerializer serializer];
            break;
        default:
            return [AFJSONResponseSerializer serializer];
            break;
    }
}
#pragma mark -- 取消所有请求
/**
 * 取消所有请求
 */
+(void)cancelALlOperations{
    AFHTTPSessionManager *manager=[AFHTTPSessionManager manager];
    [manager.operationQueue cancelAllOperations];

}
@end
