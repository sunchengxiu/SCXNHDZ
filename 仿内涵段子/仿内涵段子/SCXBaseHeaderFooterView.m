//
//  SCXBaseHeaderFooterView.m
//  仿内涵段子
//
//  Created by 孙承秀 on 16/10/9.
//  Copyright © 2016年 孙先森丶. All rights reserved.
//

#import "SCXBaseHeaderFooterView.h"

@implementation SCXBaseHeaderFooterView
+(instancetype)headerFooterViewWithTableView:(UITableView *)tableView{
    if (tableView==nil) {
        return [[self alloc] init];
    }
    NSString *className=NSStringFromClass([self class]);
    NSString *reuseID=[className stringByAppendingString:@"headerFooterID"];
    [tableView registerClass:[self class] forHeaderFooterViewReuseIdentifier:reuseID];
    return [tableView dequeueReusableHeaderFooterViewWithIdentifier:reuseID];
}
@end
