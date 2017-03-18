//
//  SCXBaseImageView.h
//  仿内涵段子
//
//  Created by 孙承秀 on 16/10/1.
//  Copyright © 2016年 孙先森丶. All rights reserved.
//

#import <YYWebImage/YYWebImage.h>

@interface SCXBaseImageView : YYAnimatedImageView
/**
 *  设置图片仅通过URL(NSString)
 *
 *  @param url url
 */
-(void)setImageWithUrl:(NSString *)url;
/**
 *  设置图片通过url（NSString）
 *
 *  @param url   url
 *  @param image 缓冲图片
 */
-(void)setImageWithUrl:(NSString *)url placeHolder:(UIImage *)image;
/**
 *  设置图片通过url
 *
 *  @param url          url（NSString）
 *  @param image        缓冲图片
 *  @param finishHandle 回调处理
 */
-(void)setImageWithUrl:(NSString *)url placeHolder:(UIImage *)image finishHandle:(void (^) (bool finish,UIImage *image))finishHandle;
/**
 *  设置图片通过网络URL
 *
 *  @param url   网络URL
 *  @param image 缓冲图片
 */
-(void)setImageWithURL:(NSURL *)url placeHolder:(UIImage *)image;
/**
 *  设置图片通过网络URL
 *
 *  @param url URL
 */
-(void)setImageWithURL:(NSURL *)url;
/**
 *  设置图片通过网络URL
 *
 *  @param url          URL
 *  @param image        缓冲图片
 *  @param finishHandle 回调处理
 */
-(void)setImageWithURL:(NSURL *)url placeHolder:(UIImage *)image finishHandle:(void (^) (bool finish,UIImage *image))finishHandle;
/**
 *  设置图片通过网络URL
 *
 *  @param url            URL
 *  @param image          缓冲图片
 *  @param finishHandle   回调处理
 *  @param prefressHandle 进度处理
 */
-(void)setImageWithURL:(NSURL *)url placeHolder:(UIImage *)image finishHandle:(void (^) (bool finish,UIImage *image))finishHandle progressHandle:(void (^)(CGFloat progress))prefressHandle;
@end
