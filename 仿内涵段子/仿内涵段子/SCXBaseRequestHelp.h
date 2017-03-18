//
//  SCXBaseRequestHelp.h
//  仿内涵段子
//
//  Created by 孙承秀 on 16/9/24.
//  Copyright © 2016年 孙先森丶. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SCXRequestManager.h"
#import <MJExtension.h>
@protocol SCXBaseRequestResponseDelegate;
/**
 * 发送请求回调Block
 */
typedef void(^SCXRequestFinishCompletion)(id ,BOOL ,NSString *);
@interface SCXBaseRequestHelp : NSObject
/**URL*/
@property(nonatomic,strong)NSString *SCX_url;
/**请求完成后代理*/
@property(nonatomic,weak)id <SCXBaseRequestResponseDelegate >SCX_RequestDelegate;
/**是否为post请求*/
@property(nonatomic,assign)BOOL SCX_isPost;
/**图片数组*/
@property(nonatomic)NSMutableArray <UIImage *> *SCX_imageArray;
/**构造请求*/
+(instancetype)SCX_requestWithUrl:(NSString *)url;
+(instancetype)SCX_Request;
+(instancetype)SCX_requestWithUrl:(NSString *)url andIsPost:(BOOL)post;
+(instancetype)SCX_requestWithUrl:(NSString *)url andIsPost:(BOOL)post withDelegate:(id <SCXBaseRequestResponseDelegate> )delegate;
/**发送请求*/
-(void)SCX_sendRequest;
-(void)SCX_sendRequestWithComplement:(SCXRequestFinishCompletion)complement;
/**处理请求后的数据，block优先级高于代理优先级*/
-(void)handleResponseData:(id)responseObject complement:(SCXRequestFinishCompletion)complement;
@end

@protocol SCXBaseRequestResponseDelegate <NSObject>
/**
 * 请求完成后代理方法
 */
-(void)requestFinishWithIsSuccess:(BOOL)success AndResponse:(id)response andMessage:(NSString *)message;
@end
