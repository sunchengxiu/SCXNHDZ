//
//  SCXUtils.h
//  仿内涵段子
//
//  Created by 孙承秀 on 16/9/27.
//  Copyright © 2016年 孙先森丶. All rights reserved.
//

#import <Foundation/Foundation.h>
#import<MJRefresh.h>

typedef void (^SCXRefreshUpOfDownBlock)();
@interface SCXUtils : NSObject
/**
 *  下拉刷新方法
 *
 *  @param scrollView 展示在哪个VIew上面
 *  @param block      刷新后回调Block
 */
+(void)addDownRefreshWithScrollView:(UIScrollView *)scrollView andCallBackBlock:(SCXRefreshUpOfDownBlock)block;
/**
 *  上拉刷新方法
 *
 *  @param scrollView 展示在哪个View上面
 *  @param block      上拉刷新回调block
 */
+(void)addUpRefreshWithScrollView:(UIScrollView *)scrollView andCallBackBlock:(SCXRefreshUpOfDownBlock)block;
/**
 *  开始下拉刷新
 *
 *  @param scrollView 哪个View下拉刷新
 */
+(void)beginDownRefreshWithScrollView:(UIScrollView *)scrollView;
/**
 *  开始上拉刷新
 *
 *  @param scrollView 哪个View上啦刷新
 */
+(void)beginUpRefreshWithScrollView:(UIScrollView *)scrollView;
/**
 * 停止下拉刷新
 *
 *  @param scrollView scrollView
 */
+(void)endDownrefreshWithScrolView:(UIScrollView *)scrollView;
/**
 *   停止上拉刷新
 *
 *  @param scrllView scrollView
 */
+(void)endUpRefreshWithScrollView:(UIScrollView *)scrllView;
/**
 *  判断是否正在上啦刷新
 *
 *  @param scrollView
 *
 *  @return 是否正在上拉刷新
 */
+(BOOL)isUpRefreshWithScrollView:(UIScrollView *)scrollView;
/**
 *  判断是否正在下拉刷新
 *
 *  @param scrollView
 *
 *  @return 是否正在下拉刷新
 */
+(BOOL)isDownRefreshWithScrollView:(UIScrollView *)scrollView;
/**
 *  隐藏footer
 *
 *  @param scrollView 
 */
+(void)hiddenRefreshFooterWithScrollView:(UIScrollView *)scrollView;
/**
 *  隐藏header
 *
 *  @param scrollView 
 */
+(void)hiddenRefreshheaderWithScrollView:(UIScrollView *)scrollView;
/**
 *  提示没有更多数据
 *
 *  @param scrollView 
 */
+(void)noticeNoMoreDataWithScrollView:(UIScrollView *)scrollView;
/**
 *  重置footer
 *
 *  @param scrollView 
 */
+(void)resetFooterWithScrollView:(UIScrollView *)scrollView;
/**
 *  公共富文本设置关键字
 *
 *  @param string  字符串
 *  @param keyWord 关键字
 *
 *  @return 重做完的字符串 
 */
+(NSAttributedString *)attributeStringWithString:(NSString *)string withKeyWord:(NSString *)keyWord;
/**
 *  设置关键字的颜色
 *
 *  @param string         字符串
 *  @param keyWord        关键字
 *  @param font           字体
 *  @param highLightColor 高亮颜色
 *  @param textColor      正常颜色
 *
 *  @return 处理完的字符串
 */
+(NSAttributedString *)attributeStringWithString:(NSString *)string withKeyWord:(NSString *)keyWord withFont:(UIFont *)font andHighLightColor:(UIColor *)highLightColor andTextColor:(UIColor *)textColor;
/**
 *  处理字符串
 *
 *  @param string         字符串
 *  @param keyWord        关键字
 *  @param font           字体
 *  @param highLightColor 高亮颜色
 *  @param textColor      正常颜色
 *  @param liniSpace      行高
 *
 *  @return 处理完的字符串
 */
+(NSAttributedString *)attributeStringWithString:(NSString *)string withKeyWord:(NSString *)keyWord withFont:(UIFont *)font andHighLightColor:(UIColor *)highLightColor andTextColor:(UIColor *)textColor andLineSpace:(CGFloat)liniSpace;

/**
 判断是否为有效字符串

 @param string 字符串

 @return 判断后的结果
 */
+(NSString *)validString:(NSString *)string;

/**
 将颜色转化为图片

 @param color 颜色

 @return 图片
 */
+(UIImage *)imageWithColor:(UIColor *)color;

/**
 分析当前时间距离上次的时间间隔

 @param timeInterval 要距离的时间

 @return 结果
 */
+ (NSString *)updateTimeForTimeInterval:(NSInteger)timeInterval ;

/**
 时间戳转时间

 @param date   时间戳
 @param format 格式

 @return 处理好的时间
 */
+ (NSString *)datestrFromDate:(NSDate *)date
               withDateFormat:(NSString *)format;
@end
