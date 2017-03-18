//
//  SCXHeaderScrollView.h
//  仿内涵段子
//
//  Created by 孙承秀 on 16/10/11.
//  Copyright © 2016年 孙先森丶. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SCXCustomScrollViewItemLabel.h"
@interface SCXHeaderScrollView : UIView

/**
 标题数组
 */
@property(nonatomic,strong)NSArray <NSString *> *titlesArray;

/**
 点击头部index的时候回调方法
 */
@property(nonatomic,copy)void (^clickTitleHandleBlock)(SCXHeaderScrollView *headerScrollView,NSString *title,NSInteger currentIndex);

/**
 偏移量
 */
@property(nonatomic,assign)CGPoint contentOfSet;

/**
 当前索引
 */
@property(nonatomic,assign)NSInteger currentIndex;

/**
 滑动视图
 */
@property(nonatomic,strong)UIScrollView *scrollView;

/**
 过度layer
 */
@property(nonatomic,strong)CALayer *lineLayer;
@end
