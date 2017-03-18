//
//  SCXShareManager.m
//  仿内涵段子
//
//  Created by 孙承秀 on 16/10/12.
//  Copyright © 2016年 孙先森丶. All rights reserved.
//

#import "SCXShareManager.h"
#import <UMSocialCore/UMSocialCore.h>
#import "UMSocialWechatHandler.h"
#import "UMSocialQQHandler.h"

#import "WXApi.h"
#import "WeiboSDK.h"
#import <TencentOpenAPI/TencentApiInterface.h>
@implementation SCXShareManager
singleM(Manager)
//com.360qiyun.pan
-(void)registerAllPlatforms {
    //打开调试日志
    [[UMSocialManager defaultManager] openLog:YES];
    
    //设置友盟appkey
    [[UMSocialManager defaultManager] setUmSocialAppkey:@"5767b1c667e58e5727001c60"];
    
    // 获取友盟social版本号
    //NSLog(@"UMeng social version: %@", [UMSocialGlobal umSocialSDKVersion]);
    
    //设置微信的appKey和appSecret
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:WXAPPID appSecret:WXAPPSCREEY redirectURL:@"http://pan.360qiyun.com"];
    
    
    //设置分享到QQ互联的appKey和appSecret
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_QQ appKey:QQAPPID  appSecret:QQAPPKEY redirectURL:@"http://pan.360qiyun.com"];
    
    //设置新浪的appKey和appSecret
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_Sina appKey:WEIBOAPPKEY  appSecret:WEIBOSCRKEY redirectURL:@"http://pan.360qiyun.com"];

}


-(void)shareWithShareType:(SCXShareManagerType)type image:(UIImage *)image url:(NSString *)url content:(NSString *)content cobtroller:(UIViewController *)controller{
    
    //[UMSocialData openLog:YES];
    //设置支持没有客户端情况下使用SSO授权
    
    switch (type) {
        case SCXShareManagerTypeWechatSession: {
           
            //[self getAuthInfoFromWechatWithController:controller];
//            if (![WXApi isWXAppInstalled]) {
//                //                [MBProgressHUD showMessage:@"微信没有安装,请先安装微信" toView:controller.view];
//                return ;
//            }
            
            //需要认证
             //[self getAuthInfoFromWechatWithController:controller];
            UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
            UMShareWebpageObject *web=[UMShareWebpageObject shareObjectWithTitle:@"仿内涵段子" descr:@"孙承秀仿内涵段子" thumImage:[UIImage imageNamed:@"digupicon_review_press_1"]];
            web.webpageUrl=@"http://pan.360qiyun.com";
            messageObject.shareObject=web;
            [[UMSocialManager defaultManager] shareToPlatform:UMSocialPlatformType_WechatSession messageObject:messageObject currentViewController:controller completion:^(id data, NSError *error) {
                NSString *message = nil;
                if (!error) {
                    message = [NSString stringWithFormat:@"分享成功"];
                } else {
                    message = [NSString stringWithFormat:@"失败原因Code: %d\n",(int)error.code];
                    
                }
//                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"share"
//                                                                message:message
//                                                               delegate:nil
//                                                      cancelButtonTitle:NSLocalizedString(@"确定", nil)
//                                                      otherButtonTitles:nil];
//                [alert show];
            }];
        }
             break;
        case SCXShareManagerTypeWechat: {
            UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
            UMShareWebpageObject *web=[UMShareWebpageObject shareObjectWithTitle:@"仿内涵段子" descr:@"孙承秀仿内涵段子" thumImage:[UIImage imageNamed:@"digupicon_review_press_1"]];
            web.webpageUrl=@"http://pan.360qiyun.com";
            messageObject.shareObject=web;
            [[UMSocialManager defaultManager] shareToPlatform:UMSocialPlatformType_WechatTimeLine messageObject:messageObject currentViewController:controller completion:^(id data, NSError *error) {
                NSString *message = nil;
                if (!error) {
                    message = [NSString stringWithFormat:@"分享成功"];
                } else {
                    message = [NSString stringWithFormat:@"失败原因Code: %d\n",(int)error.code];
                    
                }
               
            }];

            
        }break;
        case SCXShareManagerTypeWeibo: {
            if (![WeiboSDK isWeiboAppInstalled]) {
                //                [MBProgressHUD showMessage:@"微博没有安装,请先安装微博" toView:controller.view];
                return ;
            }
            UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
            UMShareWebpageObject *web=[UMShareWebpageObject shareObjectWithTitle:@"仿内涵段子" descr:@"孙承秀仿内涵段子" thumImage:[UIImage imageNamed:@"digupicon_review_press_1"]];
            web.webpageUrl=@"http://pan.360qiyun.com";
            messageObject.shareObject=web;
            [[UMSocialManager defaultManager] shareToPlatform:UMSocialPlatformType_Sina messageObject:messageObject currentViewController:controller completion:^(id data, NSError *error) {
                NSString *message = nil;
                if (!error) {
                    message = [NSString stringWithFormat:@"分享成功"];
                } else {
                    message = [NSString stringWithFormat:@"失败原因Code: %d\n",(int)error.code];
                    
                }
                
            }];

        }break;
        case SCXShareManagerTypeQQ: {
            if (![TencentApiInterface isTencentAppInstall:kIphoneQQ]) {
                //                [MBProgressHUD showMessage:@"QQ没有安装,请先安装QQ" toView:controller.view];
                                return ;
            }
            UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
            
            //创建图片内容对象
            UMShareImageObject *shareObject = [[UMShareImageObject alloc] init];
            //如果有缩略图，则设置缩略图
            shareObject.thumbImage = [UIImage imageNamed:@"digupicon_review_press_1"];
            [shareObject setShareImage:@"http://dev.umeng.com/images/tab2_1.png"];
            messageObject.shareObject=shareObject;
            [[UMSocialManager defaultManager] shareToPlatform:UMSocialPlatformType_QQ messageObject:messageObject currentViewController:controller completion:^(id data, NSError *error) {
                NSString *message = nil;
                if (!error) {
                    message = [NSString stringWithFormat:@"分享成功"];
                } else {
                    message = [NSString stringWithFormat:@"失败原因Code: %d\n",(int)error.code];
                    
                }
               
            }];

        }break;
        case SCXShareManagerTypeQZone: {
            if (![TencentApiInterface isTencentAppInstall:kIphoneQQ]) {
                //                [MBProgressHUD showMessage:@"QQ没有安装,请先安装QQ" toView:controller.view];
                return ;
            }
            UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
            
            //创建图片内容对象
            UMShareImageObject *shareObject = [[UMShareImageObject alloc] init];
            //如果有缩略图，则设置缩略图
            shareObject.thumbImage = [UIImage imageNamed:@"digupicon_review_press_1"];
            [shareObject setShareImage:@"http://dev.umeng.com/images/tab2_1.png"];
            
            //分享消息对象设置分享内容对象
            messageObject.shareObject = shareObject;
            [[UMSocialManager defaultManager] shareToPlatform:UMSocialPlatformType_Qzone messageObject:messageObject currentViewController:controller completion:^(id data, NSError *error) {
                NSString *message = nil;
                if (!error) {
                    message = [NSString stringWithFormat:@"分享成功"];
                } else {
                    message = [NSString stringWithFormat:@"失败原因Code: %d\n",(int)error.code];
                    
                }
               
            }];

        }break;
        default:
            break;
    }
    image = nil;
}
- (void)getAuthInfoFromWechatWithController:(UIViewController *)controller
{
    [[UMSocialManager defaultManager] authWithPlatform:UMSocialPlatformType_WechatSession currentViewController:controller completion:^(id result, NSError *error) {
        if (error) {
            NSLog(@"%ld",error.code);
        } else {
            UMSocialAuthResponse *resp = result;
            
            // 授权信息
            NSLog(@"Wechat uid: %@", resp.uid);
            NSLog(@"Wechat openid: %@", resp.openid);
            NSLog(@"Wechat accessToken: %@", resp.accessToken);
            NSLog(@"Wechat refreshToken: %@", resp.refreshToken);
            NSLog(@"Wechat expiration: %@", resp.expiration);
            
            
            // 第三方平台SDK源数据
            NSLog(@"Wechat originalResponse: %@", resp.originalResponse);
        }
    }];
}
//-(void)getAuthInfoFromWechatWithController:(UIViewController *)controller
//{
//    [[UMSocialManager defaultManager]  authWithPlatform:UMSocialPlatformType_WechatSession currentViewController:controller completion:^(id result, NSError *error) {
//        
//        UMSocialAuthResponse *authresponse = result;
//        NSString *message = [NSString stringWithFormat:@"result: %d\n uid: %@\n accessToken: %@\n",(int)error.code,authresponse.uid,authresponse.accessToken];
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Login"
//                                                        message:message
//                                                       delegate:nil
//                                              cancelButtonTitle:NSLocalizedString(@"确定", nil)
//                                              otherButtonTitles:nil];
//        [alert show];
//    }];
//}

-(void)shareSucceed{

}
@end
