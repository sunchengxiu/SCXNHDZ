//
//  SCXBaseModel.m
//  仿内涵段子
//
//  Created by 孙承秀 on 16/9/26.
//  Copyright © 2016年 孙先森丶. All rights reserved.
//

#import "SCXBaseModel.h"
#import "SCXFileCacheManager.h"
@implementation SCXBaseModel
MJCodingImplementation;
+ (NSDictionary *)replacedKeyFromPropertyName {
    return @{
             @"ID":@"id",
             @"desc":@"description",
             @"responseData" : @"data"
             };
}
#pragma mark -- 把数组转化为模型数组
+(NSMutableArray *)objectArrayWithKeyValuesArray:(NSArray *)arr1{
    if ([arr1 isKindOfClass:[NSArray class]]) {
        NSMutableArray *arr=[self mj_objectArrayWithKeyValuesArray:arr1];
        return arr;
    }
    return [NSMutableArray new];
}
#pragma mark -- 把字典转化为模型 
+(id)modelWithDictionary:(NSDictionary *)dictionary{
    if ([dictionary isKindOfClass:[NSDictionary class]]) {
       return  [self mj_objectWithKeyValues:dictionary];
    }
    return [[self alloc]init];

}
#pragma mark -- 把数组抓花为一个模型类
+(void)setUpModelArrayContainDic:(NSDictionary *)dic{
    if ([dic allKeys].count==0) {
        return;
    }
    [self mj_setupObjectClassInArray:^NSDictionary *{
        return dic;
    }];
}
#pragma mark -- 模型数组中包含有一个字典数组
+(id)ModelArrayContainDic:(NSArray *)arr dictionary:(NSDictionary *)dic{
    if (dic==nil) {
        dic=[NSMutableDictionary new];
    }
    [self setUpModelArrayContainDic:dic];
    return  [self objectArrayWithKeyValuesArray:arr];
}
#pragma maek -- 字典数组中包含有一个字典数组
+(id)dicArrayContainDic:()dic dic:(NSDictionary *)dic1{
    if (dic==nil) {
        dic=[NSMutableDictionary new];
    }
    [self setUpModelArrayContainDic:dic1];
    return [self modelWithDictionary:dic];
}
+(void)archive{
    
    [SCXFileCacheManager saveUserDataWithObject:self forKey:self.class.description];
}
+(id)unArchiver{
    id obj=[SCXFileCacheManager getChchePathWithFileName:[self.class description]];
    return obj;
}
@end
