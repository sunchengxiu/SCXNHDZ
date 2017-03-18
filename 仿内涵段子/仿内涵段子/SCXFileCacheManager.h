//
//  SCXFileCacheManager.h
//  仿内涵段子
//
//  Created by 孙承秀 on 16/9/26.
//  Copyright © 2016年 孙先森丶. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SCXFileCacheManager : NSObject
/**沙河路径*/
+(NSString *)cachePath;
/**获取存档路径*/
+(NSString *)getChchePathWithFileName:(NSString *)fileName;
/**归档*/
+(BOOL)archiverObjectInArchive:(id)object withFileName:(NSString *)fileName;
/**解档*/
+(id)unarchiverFromFileName:(NSString *)fileName;
/**处理目的路径*/
+(void)handleCacheWithFileName:(NSString *)fileName;
/**处理目的路径下文件*/
+(void)removeObjectByFileName:(NSString *)fileName;
/**设置用户偏好设置*/
+(void)saveUserDataWithObject:(id)obj forKey:(NSString *)key;
/**获取用户偏好设置*/
+(id)getUserDataWithKey:(NSString *)key;
/**移除用户偏好设置*/
+(void)removeUserDataWithKey:(NSString *)key;

@end
