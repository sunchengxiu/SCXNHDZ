//
//  NSNotificationCenter+costom.m
//  仿内涵段子
//
//  Created by 孙承秀 on 16/9/26.
//  Copyright © 2016年 孙先森丶. All rights reserved.
//

#import "NSNotificationCenter+costom.h"

@implementation NSNotificationCenter (costom)
#pragma mark--发送一个通知
+(void)postNotificationName:(NSString *)name{
    [[NSNotificationCenter defaultCenter] postNotificationName:name object:nil  ];

}
+(void)postNotificationName:(NSString *)name object:(id)object{

    if (object) {
        [[NSNotificationCenter defaultCenter] postNotificationName:name object:object userInfo:nil];
    }
    else{
        [self postNotificationName:name];
    }
}
#pragma mark -- 移除一个通知
+(void)removeObserverWithObject:(id)object{

    [[NSNotificationCenter defaultCenter] removeObserver:object];
}
#pragma mark -- 添加一个通知
+(void)addObserver:(id)observer action:(SEL)action withName:(NSString *)name{
    [[NSNotificationCenter defaultCenter] addObserver:observer selector:action name:name object:nil];
}

@end
