//
//  NSNotificationCenter+costom.h
//  仿内涵段子
//
//  Created by 孙承秀 on 16/9/26.
//  Copyright © 2016年 孙先森丶. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSNotificationCenter (costom)
/**
 * 发送一个没有内容的通知
 */
+(void)postNotificationName:(NSString *)name;
/**
 * 发送一个有内容的通知
 */
+(void)postNotificationName:(NSString *)name object:(id)object;
/**
 * 移除一个通知
 */
+(void)removeObserverWithObject:(id)object;
/**
 * 添加一个通知
 */
+(void)addObserver:(id)observer action:(SEL)action withName:(NSString *)name;
@end
