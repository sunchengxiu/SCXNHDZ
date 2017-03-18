//
//  SCXUtils.m
//  仿内涵段子
//
//  Created by 孙承秀 on 16/9/27.
//  Copyright © 2016年 孙先森丶. All rights reserved.
//

#import "SCXUtils.h"
#import <MJRefreshAutoFooter.h>
#import <MJRefreshAutoNormalFooter.h>
#import <MJRefresh/MJRefresh.h>
@implementation SCXUtils
#pragma mark --  下拉刷新
+(void)addDownRefreshWithScrollView:(UIScrollView *)scrollView andCallBackBlock:(SCXRefreshUpOfDownBlock)block{
    if (scrollView==nil||block==nil) {
        return;
    }
    MJRefreshNormalHeader *header=[MJRefreshNormalHeader headerWithRefreshingBlock:^{
        if (block) {
            block();
        }
        if (scrollView.mj_footer.hidden==NO) {
            [scrollView.mj_footer resetNoMoreData];
        }
    } ];
    [header setTitle:@"亲，请等待哦~" forState:MJRefreshStateRefreshing];
    [header setTitle:@"下拉刷新哦亲" forState:MJRefreshStateIdle];
    [header setTitle:@"释放我刷新哦亲" forState:MJRefreshStatePulling];
    header.stateLabel.font = [UIFont systemFontOfSize:13];
    header.stateLabel.textColor = [UIColor redColor];
    scrollView.mj_header=header;
}
#pragma mark --  上拉刷新
+(void)addUpRefreshWithScrollView:(UIScrollView *)scrollView andCallBackBlock:(SCXRefreshUpOfDownBlock)block{
    if (scrollView==nil||block==nil ) {
        return;
    }
    MJRefreshAutoNormalFooter *footer=[MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        if (block) {
            block();
        }
    }];
    
    [footer setTitle:@"亲，请等待哦~" forState:MJRefreshStateRefreshing];
    [footer setTitle:@"下拉刷新哦亲" forState:MJRefreshStateIdle];
    [footer setTitle:@"没有更多了哦" forState:MJRefreshStateNoMoreData];
    [footer setTitle:@"释放我刷新哦亲" forState:MJRefreshStatePulling];
    footer.stateLabel.textColor =[UIColor colorWithRed:90 green:90 blue:90 alpha:1];
    footer.stateLabel.font =[UIFont systemFontOfSize:13];
    scrollView.mj_footer=footer;
}
#pragma mark -- 开始下拉刷新
+(void)beginDownRefreshWithScrollView:(UIScrollView *)scrollView{
    [scrollView.mj_header beginRefreshing];

}
#pragma mark -- 开始上拉刷新
+(void)beginUpRefreshWithScrollView:(UIScrollView *)scrollView{
    [scrollView.mj_footer beginRefreshing];

}
#pragma mark -- 停止下拉刷新
+(void)endDownrefreshWithScrolView:(UIScrollView *)scrollView{
    [scrollView.mj_header endRefreshing];

}
#pragma mark -- 停上拉刷新
+(void)endUpRefreshWithScrollView:(UIScrollView *)scrllView{
    [scrllView.mj_footer endRefreshing];

}
#pragma mark--判断是否是下拉刷新
+(BOOL)isDownRefreshWithScrollView:(UIScrollView *)scrollView{
    return scrollView.mj_header.isRefreshing;
}
#pragma mark--判断是否正在上啦刷新
+(BOOL)isUpRefreshWithScrollView:(UIScrollView *)scrollView{
    return scrollView.mj_footer.isRefreshing;
}
#pragma mark--隐藏footer
+(void)hiddenRefreshFooterWithScrollView:(UIScrollView *)scrollView{
    [scrollView.mj_footer setHidden:YES];
}
#pragma mark--隐藏header
+(void)hiddenRefreshheaderWithScrollView:(UIScrollView *)scrollView{
    [scrollView.mj_header setHidden:YES];
}
#pragma mark--提示没有更多数据的时候
+(void)noticeNoMoreDataWithScrollView:(UIScrollView *)scrollView{
    [scrollView.mj_footer endRefreshingWithNoMoreData];

}
#pragma mark--重置footer
+(void)resetFooterWithScrollView:(UIScrollView *)scrollView{
    
    [scrollView.mj_footer resetNoMoreData];
}
#pragma mark--公共富文本，设置高亮
+(NSAttributedString *)attributeStringWithString:(NSString *)string withKeyWord:(NSString *)keyWord{
    return [self attributeStringWithString:string withKeyWord:keyWord withFont:[UIFont systemFontOfSize:16] andHighLightColor:[UIColor colorWithRed:1.00f green:0.49f blue:0.65f alpha:1.00f] andTextColor:[UIColor colorWithRed:0.17f green:0.23f blue:0.28f alpha:1.00f]];

}
+(NSAttributedString *)attributeStringWithString:(NSString *)string withKeyWord:(NSString *)keyWord withFont:(UIFont *)font andHighLightColor:(UIColor *)highLightColor andTextColor:(UIColor *)textColor{
    return [self attributeStringWithString:string withKeyWord:keyWord withFont:font andHighLightColor:highLightColor andTextColor:textColor andLineSpace:2.0];
    
}
+(NSAttributedString *)attributeStringWithString:(NSString *)string withKeyWord:(NSString *)keyWord withFont:(UIFont *)font andHighLightColor:(UIColor *)highLightColor andTextColor:(UIColor *)textColor andLineSpace:(CGFloat)liniSpace{
    NSMutableAttributedString *attrebuteString=[[NSMutableAttributedString alloc]initWithString:string];
    if (!keyWord||keyWord.length==0) {
        NSRange range=NSMakeRange(0, attrebuteString.length);
        [attrebuteString addAttribute:NSFontAttributeName value:font range:range];
        [attrebuteString addAttribute:NSForegroundColorAttributeName value:textColor range:range];
        NSMutableParagraphStyle *style=[[NSMutableParagraphStyle alloc]init];
        style.lineSpacing=liniSpace;
        [attrebuteString addAttribute:NSParagraphStyleAttributeName value:style range:range ];
        return attrebuteString;
    }
    else{
        NSRange range1=[string rangeOfString:keyWord options:NSCaseInsensitiveSearch];
        NSRange allRange=NSMakeRange(0, string.length);
        if (range1.location!=NSNotFound) {
            [attrebuteString addAttribute:NSFontAttributeName value:font range:allRange];
            [attrebuteString addAttribute:NSForegroundColorAttributeName value:textColor range:allRange];
            [attrebuteString addAttribute:NSForegroundColorAttributeName value:highLightColor range:range1];
            NSMutableParagraphStyle *style=[[NSMutableParagraphStyle alloc]init];
            style.lineSpacing=liniSpace;
            [attrebuteString addAttribute:NSParagraphStyleAttributeName value:style range:allRange];
            return attrebuteString;
        }
        else{
            [attrebuteString addAttribute:NSForegroundColorAttributeName value:textColor range:allRange];
            [attrebuteString addAttribute:NSFontAttributeName value:font range:allRange];
            NSMutableParagraphStyle *style=[[NSMutableParagraphStyle alloc]init];
            style.lineSpacing=liniSpace;
            [attrebuteString addAttribute:NSParagraphStyleAttributeName value:style range:allRange];
            return attrebuteString;
        }
    }
}
+(NSString *)validString:(NSString *)string{
    if ([self isBlankingString:string]) {
        return @"";
    }
    else{
        return string;
    }
}
+(BOOL)isBlankingString:(NSString *)string{
    if (string==nil||string==NULL) {
        return YES;
    }

    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([string isKindOfClass:[NSDictionary class]]) {
        return YES;
    }
    if ([string isKindOfClass:[NSString class]]==NO) {
        return YES;
    }
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        return YES;
    }
    if ([string isEqualToString:@""]) {
        return YES;
    }
    return NO;
}
+(UIImage *)imageWithColor:(UIColor *)color{

    CGRect rect=CGRectMake(0, 0, 1, 1);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef ref=UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(ref, [color CGColor]);
    CGContextFillRect(ref, rect);
    UIImage *image=UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
    
}
// 时间戳转时间
+ (NSString *)datestrFromDate:(NSDate *)date
               withDateFormat:(NSString *)format {
    
    NSDateFormatter* dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:format];
    return [dateFormat stringFromDate:date];
}
// 几天前 几分钟前..
+ (NSString *)updateTimeForTimeInterval:(NSInteger)timeInterval {
    
    // 获取当前时时间戳 1466386762.345715 十位整数 6位小数
    NSTimeInterval currentTime = [[NSDate date] timeIntervalSince1970];
    // 创建歌曲时间戳(后台返回的时间 一般是13位数字)
    NSTimeInterval createTime = timeInterval;
    // 时间差
    NSTimeInterval time = currentTime - createTime;
    if (time < 60) {
        return @"刚刚";
    }
    NSInteger minutes = time / 60;
    if (minutes < 60) {
        
        return [NSString stringWithFormat:@"%ld分钟前", minutes];
    }
    // 秒转小时
    NSInteger hours = time / 3600;
    if (hours < 24) {
        return [NSString stringWithFormat:@"%ld小时前",hours];
    }
    // 秒转天数
    NSInteger days = time / 3600 / 24;
    if (days < 30) {
        return [NSString stringWithFormat:@"%ld天前",days];
    }
    // 秒转月
    NSInteger months = time / 3600 / 24 / 30;
    if (months < 12) {
        return [NSString stringWithFormat:@"%ld月前",months];
    }
    // 秒转年
    NSInteger years = time / 3600 / 24 / 30 / 12;
    return [NSString stringWithFormat:@"%ld年前",years];
}

@end
