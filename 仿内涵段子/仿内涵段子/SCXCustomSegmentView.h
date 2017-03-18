//
//  SCXCustomSegmentView.h
//  仿内涵段子
//
//  Created by 孙承秀 on 16/10/8.
//  Copyright © 2016年 孙先森丶. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SCXCustomSegmentView : UIView

/**
 title数组
 */
@property(nonatomic,strong)NSArray  *titlesArray;

/**
 当前选择的button
 */
@property(nonatomic,strong)UIButton *selectbutton;

/**
 自定义segment

 @param titlesArray segment标题

 @return
 */
-(instancetype)initSegmentWithTitles:(NSArray *)titlesArray;

/**
 自定义segment点击button回调block
 */
@property(nonatomic,copy)void (^customSegmentViewButtonClickHandleBlock)(SCXCustomSegmentView *segmentView,NSString *title,NSInteger currentIndex);

/**
 默认点击
 */
-(void)clickDefault;
@end
