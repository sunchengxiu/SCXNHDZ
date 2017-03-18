//
//  SCXFileCacheManager.m
//  仿内涵段子
//
//  Created by 孙承秀 on 16/9/26.
//  Copyright © 2016年 孙先森丶. All rights reserved.
//

#import "SCXFileCacheManager.h"

@implementation SCXFileCacheManager
#pragma mark -- 解归档路径
+(NSString *)cachePath{
    NSString *cachePath=[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
    return cachePath;
}
+(NSString *)getChchePathWithFileName:(NSString *)fileName{
    fileName=[[self cachePath] stringByAppendingString:fileName];
    [self handleCacheWithFileName:fileName];
    return fileName;
}
#pragma mark -- 归档
+(BOOL)archiverObjectInArchive:(id)object withFileName:(NSString *)fileName{
    NSString *cacheName=[self getChchePathWithFileName:fileName];
    cacheName=[cacheName stringByAppendingString:@".archiver"];
    BOOL success=[NSKeyedArchiver archiveRootObject:object toFile:fileName];
    return success;
}
#pragma mark -- 解档
+(id)unarchiverFromFileName:(NSString *)fileName{
    NSString *cacheName=[self getChchePathWithFileName:fileName];
    cacheName=[cacheName stringByAppendingString:@".archiver"];
    id obj=[NSKeyedUnarchiver unarchiveObjectWithFile:cacheName];
    return obj;

}
#pragma mark -- 处理目的路径
+(void)handleCacheWithFileName:(NSString *)fileName{
    if (![[NSFileManager defaultManager] fileExistsAtPath:fileName]) {
        [[NSFileManager defaultManager] createDirectoryAtPath:fileName withIntermediateDirectories:YES attributes:nil error:nil];
    }
}
#pragma mark--移除目的路径下文件
+(void)removeObjectByFileName:(NSString *)fileName{

    NSString *fileName1=[[self cachePath] stringByAppendingString:fileName];
    fileName1=[fileName1 stringByAppendingString:@".archiver"];
    [[NSFileManager defaultManager] removeItemAtPath:fileName1 error:nil];
}
#pragma mark -- 设置用户偏好设置
+(void)saveUserDataWithObject:(id)obj forKey:(NSString *)key{

    [[NSUserDefaults standardUserDefaults] setObject:obj forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
#pragma mark -- 获取用户偏好设置
+(id)getUserDataWithKey:(NSString *)key{
    id obj=[[NSUserDefaults standardUserDefaults] objectForKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
    return obj;
}
#pragma mark -- 移除用户偏好设置
+(void)removeUserDataWithKey:(NSString *)key{

    [[NSUserDefaults standardUserDefaults] removeObjectForKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
@end
