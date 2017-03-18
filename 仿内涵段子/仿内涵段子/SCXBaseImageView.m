//
//  SCXBaseImageView.m
//  仿内涵段子
//
//  Created by 孙承秀 on 16/10/1.
//  Copyright © 2016年 孙先森丶. All rights reserved.
//

#import "SCXBaseImageView.h"
#import "YYWebImage.h"
#import "YYWebImageManager.h"
@implementation SCXBaseImageView
-(void)setImageWithUrl:(NSString *)url{
    [self setImageWithUrl:url placeHolder:nil];
}
-(void)setImageWithUrl:(NSString *)url placeHolder:(UIImage *)image{
    [self setImageWithUrl:url placeHolder:image finishHandle:nil];
}
-(void)setImageWithUrl:(NSString *)url placeHolder:(UIImage *)image finishHandle:(void (^) (bool finish,UIImage *image))finishHandle{
    [self setImageWithURL:[NSURL URLWithString:url] placeHolder:image finishHandle:finishHandle progressHandle:nil];
}
-(void)setImageWithURL:(NSURL *)url{
    [self setImageWithURL:url placeHolder:nil];
}
-(void)setImageWithURL:(NSURL *)url placeHolder:(UIImage *)image{
    [self setImageWithURL:url placeHolder:image finishHandle:nil];
}
-(void)setImageWithURL:(NSURL *)url placeHolder:(UIImage *)image finishHandle:(void (^) (bool finish,UIImage *image))finishHandle{
    [self setImageWithURL:url placeHolder:image finishHandle:finishHandle progressHandle:nil];
}
-(void)setImageWithURL:(NSURL *)url placeHolder:(UIImage *)image finishHandle:(void (^) (bool finish,UIImage *image))finishHandle progressHandle:(void (^)(CGFloat progress))prefressHandle{
    [self yy_setImageWithURL:url placeholder:image options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        if (prefressHandle) {
            prefressHandle(receivedSize*1.0/expectedSize);
        }
    } transform:nil completion:^(UIImage *image, NSURL *url, YYWebImageFromType from, YYWebImageStage stage, NSError *error) {
        if (finishHandle) {
            finishHandle(error==nil,image);
        }
    }];
}

@end
