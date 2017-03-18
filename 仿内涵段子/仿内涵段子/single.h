//
//  single.h
//  仿内涵段子
//
//  Created by 孙承秀 on 16/9/26.
//  Copyright © 2016年 孙先森丶. All rights reserved.
//


/**
 * 单例宏
 */

#define singleH(name) +(instancetype)shared##name;
#define singleM(name)\
static id singViewController=nil;\
+(instancetype)allocWithZone:(struct _NSZone *)zone{\
\
static dispatch_once_t onceToken;\
dispatch_once(&onceToken, ^{\
singViewController=[super allocWithZone:zone];\
});\
return singViewController;\
}\
+(instancetype)shared##name{\
return [[self alloc] init];\
\
}

/*
#define singleH(name) +(instancetype)shared##name;
#define singleM(name)\
static id singViewController=nil;\
+(instancetype)shared##name{\
static dispatch_once_t onceToken;\
dispatch_once(&onceToken, ^{\
    singViewController=[[self allocWithZone:NULL]init];\
});\
return singViewController;\
}
 */
