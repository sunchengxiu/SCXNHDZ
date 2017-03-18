//
//  SCXCustomAlertView.h
//  仿内涵段子
//
//  Created by 孙承秀 on 16/10/7.
//  Copyright © 2016年 孙先森丶. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FXBlurView.h"
@interface SCXCustomAlertView : UIView
@property(nonatomic,copy)NSString *title;
@property(nonatomic,copy)NSString *cancelTitle;
@property(nonatomic,copy)NSString *oktitle;
@property(nonatomic,strong)FXBlurView *blurView;
-(instancetype)initWithTitle:(NSString *)title  andCancelTitle:(NSString *)cancelTitle andOKTitle:(NSString *)ok;
@property(nonatomic,strong)UIView *contentView1;
@property(nonatomic,strong)UILabel *contentLabel;
@property(nonatomic,strong)UIButton *cancelButton;
@property(nonatomic,strong)UIButton *okButton;
@property(nonatomic,strong)UIView *lineView;
@property(nonatomic,strong)UILabel *tipLable;
@property (nonatomic, weak) UIView *btnLine;
@property(nonatomic,copy)BOOL (^OkBlock)();
@property(nonatomic,copy)BOOL (^cancelBlock)();
-(void)showInView:(UIView *)view;
-(void)setUpOkBlock:(BOOL (^)())okBlock;
-(void)setUpCancelBlock:(BOOL (^)())cancelBlock;
@end
