//
//  SCXRequestManager.h
//  仿内涵段子
//
//  Created by 孙承秀 on 16/9/24.
//  Copyright © 2016年 孙先森丶. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>
typedef NS_ENUM(NSUInteger,SCXResponseSeializerType) {
    /**
     *  默认类型 JSON  如果使用这个响应解析器类型,那么请求返回的数据将会是JSON格式
     */
    SCXResponseSeializerTypeDefault,
    /**
     *  JSON类型 如果使用这个响应解析器类型,那么请求返回的数据将会是JSON格式
     */
    SCXResponseSeializerTypeJson,
    /*
     *  XML类型 如果使用这个响应解析器类型,那么请求返回的数据将会是XML格式
     */
    SCXResponseSeializerTypeXML,
    /**
     *  Plist类型 如果使用这个响应解析器类型,那么请求返回的数据将会是Plist格式
     */
    SCXResponseSeializerTypePlist,
    /*
     *  Compound类型 如果使用这个响应解析器类型,那么请求返回的数据将会是Compound格式
     */
    SCXResponseSeializerTypeCompound,
    /**
     *  Image类型 如果使用这个响应解析器类型,那么请求返回的数据将会是Image格式
     */
    SCXResponseSeializerTypeImage,
    /**
     *  Data类型 如果使用这个响应解析器类型,那么请求返回的数据将会是二进制格式
     */
    SCXResponseSeializerTypeData
    
};
/**
 * 成功Block
 */
typedef void(^SUCCESS)(id);
/**
 * 失败Block
 */
typedef void(^Failure)(NSError *);
/**
 * 上传Block
 */
typedef void(^ConstructingBodyBlock)(id <AFMultipartFormData>);
@interface SCXRequestManager : NSObject
/**
 * 证书验证
 */
@property(nonatomic,assign)BOOL allowInvalidCertificates;
/**
 * 取消所有请求
 */
+(void)cancelALlOperations;
/**
 * 设置数据解析器的类型
 * @param responseSerializerType 数据解析器类型
 */
+(AFHTTPResponseSerializer *)setHttpResponseSerializerWithSCXResponseSerializerTye:(SCXResponseSeializerType)responseSerializerType;
/**
 * post上传数据
 */
+(void)POST:(NSString *)url parameters:(id)para responseSeializerType:(SCXResponseSeializerType)responseSeializer success:(SUCCESS)success fauile:(Failure)failure constructingBodyWithBlock:(ConstructingBodyBlock)block;
/**
 * post请求
 */
+(void)POST:(NSString *)url parameters:(id)para responseSeializerType:(SCXResponseSeializerType)responseSeializer success:(SUCCESS)success fauile:(Failure)failure;
/**
 * GET请求
 */
+(void)GET:(NSString *)url parameters:(id)para responseSeializerType:(SCXResponseSeializerType)responseSeializer success:(SUCCESS)success fauile:(Failure)failure;
@end
