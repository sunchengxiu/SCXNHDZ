//
//  SCXCustomPlaceHolderView.h
//  仿内涵段子
//
//  Created by 孙承秀 on 16/10/15.
//  Copyright © 2016年 孙先森丶. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol SCXCustomPlaceHolderViewDelegate;

@interface SCXCustomPlaceHolderView : UITextView
@property(nonatomic,weak)id <SCXCustomPlaceHolderViewDelegate> delegate1;
@property (nonatomic,copy) NSString *placehoder;
@property (nonatomic,strong)UIColor *placehoderColor;
@property (nonatomic, assign) CGFloat placeholderTopMargin;
@property (nonatomic, assign) CGFloat placeholderLeftMargin;
@property (nonatomic, strong) UIFont *placeholderFont;
@property(nonatomic,strong)UILabel *placeHolderLabel;
@end
@protocol SCXCustomPlaceHolderViewDelegate <NSObject>

-(void)SCX_placeHolderViewDidClickChangeType:(SCXCustomPlaceHolderView *)placeHolderView;

@end
