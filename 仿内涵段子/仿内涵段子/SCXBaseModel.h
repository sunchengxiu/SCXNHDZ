//
//  SCXBaseModel.h
//  仿内涵段子
//
//  Created by 孙承秀 on 16/9/26.
//  Copyright © 2016年 孙先森丶. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MJExtension.h>
@interface SCXBaseModel : NSObject
/**字典数组转化为模型数组*/
+(NSMutableArray *)objectArrayWithKeyValuesArray:(NSArray *)arr1;
/**字典转化为模型*/
+(id)modelWithDictionary:(NSDictionary *)dictionary;
@end
