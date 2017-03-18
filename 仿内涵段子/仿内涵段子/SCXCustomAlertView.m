//
//  SCXCustomAlertView.m
//  仿内涵段子
//
//  Created by 孙承秀 on 16/10/7.
//  Copyright © 2016年 孙先森丶. All rights reserved.
//

#import "SCXCustomAlertView.h"
#import "SCXUtils.h"

#import "NSAttributedString+Size.h"
@implementation SCXCustomAlertView
-(UIView *)contentView1{
    if (!_contentView1) {
        _contentView1=[[UIView alloc]init];
        [self addSubview:_contentView1];
        _contentView1.layer.cornerRadius=4;
        [_contentView1 setBackgroundColor:[UIColor whiteColor]];
    }
    return _contentView1;
}
-(instancetype)initWithTitle:(NSString *)title andCancelTitle:(NSString *)cancelTitle andOKTitle:(NSString *)ok{
    if (self=[super init]) {
        _title=title;
        _cancelTitle=cancelTitle;
        _oktitle=ok;
        [self setUpView];
    }
    return self;
}
-(void)setUpView{
    self.backgroundColor=[[UIColor blackColor] colorWithAlphaComponent:0.4];
    _blurView=[[FXBlurView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    _blurView.tintColor=[UIColor clearColor];
    UILabel *label=[[UILabel alloc]init];
    [self.contentView1 addSubview:label];
    _tipLable=label;
    label.text=@"提示";
    label.textAlignment=NSTextAlignmentCenter;
    label.font=[UIFont systemFontOfSize:ScreenWidth>320?16:15];
    label.textColor=kCommonBlackColor;
    UILabel *contentLabel=[[UILabel alloc]init];
    NSMutableAttributedString *string=[[NSMutableAttributedString alloc]initWithString:kvalidStr(_title.length?_title:@"")];
    [string addAttribute:NSForegroundColorAttributeName value:[kCommonBlackColor colorWithAlphaComponent:0.8] range:NSMakeRange(0, _title.length)];
    NSMutableParagraphStyle *style=[[NSMutableParagraphStyle alloc]init];
    style.lineSpacing=8;
    [string addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0, string.length)];
    [string addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:ScreenWidth>320?15:14] range:NSMakeRange(0,string.length )];
    contentLabel.attributedText=string;
    [self.contentView1 addSubview:contentLabel];
    _contentLabel=contentLabel;
    contentLabel.numberOfLines=0;
    contentLabel.textColor=kCommonBlackColor;
    contentLabel.textAlignment=NSTextAlignmentCenter;
    UIButton *cancelButton=({
        UIButton *cancelButton=[[UIButton alloc]init];
        [cancelButton setTitle:self.cancelTitle.length?self.cancelTitle:@"取消" forState:UIControlStateNormal];
        [cancelButton.titleLabel setFont:[UIFont systemFontOfSize:15]];
        [cancelButton addTarget:self action:@selector(cancelClick) forControlEvents:UIControlEventTouchUpInside];
        [cancelButton setBackgroundImage:[SCXUtils imageWithColor:[[UIColor whiteColor] colorWithAlphaComponent:0.3]] forState:UIControlStateNormal];
        [cancelButton setBackgroundImage:[SCXUtils imageWithColor:[[UIColor lightTextColor] colorWithAlphaComponent:0.3]] forState:UIControlStateHighlighted];
        [cancelButton setTitleColor:kCommonBlackColor forState:UIControlStateNormal];
        cancelButton;
    });
    _cancelButton=cancelButton;
    [self.contentView1 addSubview:cancelButton];
    
    UIButton *okButton=({
        UIButton *cancelButton=[[UIButton alloc]init];
        [cancelButton setTitle:self.oktitle.length?self.oktitle:@"确定" forState:UIControlStateNormal];
        [cancelButton.titleLabel setFont:[UIFont systemFontOfSize:15]];
        [cancelButton addTarget:self action:@selector(okClick) forControlEvents:UIControlEventTouchUpInside];
        [cancelButton setBackgroundImage:[SCXUtils imageWithColor:[[UIColor whiteColor] colorWithAlphaComponent:0.3]] forState:UIControlStateNormal];
        [cancelButton setBackgroundImage:[SCXUtils imageWithColor:[[UIColor lightTextColor] colorWithAlphaComponent:0.3]] forState:UIControlStateHighlighted];
        [cancelButton setTitleColor:kRedColor forState:UIControlStateNormal];
        cancelButton;
    });
    _okButton=okButton;
    [self.contentView1 addSubview:okButton];
    UIView *lineView=[[UIView alloc]init];
    lineView.backgroundColor=[UIColor lightGrayColor];
    _lineView=lineView;
    [self.contentView1 addSubview:_lineView];
    UIView *btnLine = [[UIView alloc] init];
    [self.contentView1 addSubview:btnLine];
    _btnLine = btnLine;
    btnLine.backgroundColor = kLightGrayColor;
    
    [self addSubview:_lineView];
}
-(void)layoutSubviews{
    [super layoutSubviews];
    [self.contentView1 setFrame:CGRectMake(0, 0, ScreenWidth*0.7, 150)];
    [self.tipLable setFrame:CGRectMake(0, 20, self.contentView1.frame.size.width, 13)];
    NSAttributedString *str=self.contentLabel.attributedText;
    CGFloat height=[str heightWithConstrainedWidth:self.contentView1.frame.size.width-40];
    self.contentLabel.frame=CGRectMake(10, self.tipLable.frame.size.height+self.tipLable.frame.origin.y+25, self.contentView1.frame.size.width-40, height);
    [self.contentLabel setBackgroundColor:[UIColor whiteColor]];
    [self.contentView1 addSubview:self.lineView];
     self.lineView.frame = CGRectMake(0, self.contentLabel.frame.size.height+self.contentLabel.frame.origin.y + 25, self.contentView1.frame.size.width, 1);
    //[self.lineView setBackgroundColor:kRedColor];
    if (self.cancelTitle.length == 0 && self.oktitle.length != 0) {
        
        self.okButton.frame = CGRectMake(0, self.lineView.frame.size.height+self.lineView.frame.origin.y, self.contentView1.frame.size.height , 50);
        [self.cancelButton removeFromSuperview];
        [self.btnLine removeFromSuperview];
    } else if (self.cancelTitle.length != 0 && self.oktitle.length == 0) {
        
        self.cancelButton.frame = CGRectMake(0, self.lineView.frame.size.height+self.lineView.frame.origin.y, self.contentView1.frame.size.width, 50);
        [self.okButton removeFromSuperview];
        [self.btnLine removeFromSuperview];
        
    } else if (self.cancelTitle.length != 0 && self.oktitle.length != 0) {
        
        NSLog(@"%@---%@",self.cancelTitle,self.oktitle  );
        self.cancelButton.frame = CGRectMake(0, self.lineView.frame.size.height+self.lineView.frame.origin.y, self.contentView1.frame.size.width / 2.0f, 50);
        self.btnLine.frame = CGRectMake(self.cancelButton.frame.origin.x+self.cancelButton.frame.size.width, self.lineView.frame.size.height+self.lineView.frame.origin.y + 10, 1/[UIScreen mainScreen].scale, 30);
        self.okButton.frame = CGRectMake(self.cancelButton.frame.origin.x+self.cancelButton.frame.size.width, self.lineView.frame.size.height+self.lineView.frame.origin.y, self.contentView1.frame.size.width /2.0f, 50);
    }
    [self.contentView1 setFrame:CGRectMake(0, 0, ScreenWidth*0.7, self.lineView.frame.size.height+self.lineView.frame.origin.y+50)];
    self.contentView1.center = self.center;
}
-(void)cancelClick{
    if (!self.cancelBlock) {
        [UIView animateWithDuration:0.35 animations:^{
            self.alpha=0;
        } completion:^(BOOL finished) {
            [self removeFromSuperview];
            [_blurView clearImage];
            [_blurView removeFromSuperview];
        }];
    }
    else{
        [UIView animateWithDuration:0.35 animations:^{
            self.alpha=0;
        } completion:^(BOOL finished) {
            if (finished) {
                [self removeFromSuperview];
                [_blurView clearImage];
                [_blurView removeFromSuperview];
                if (self.cancelBlock) {
                    self.cancelBlock();
                }
            }
        }];
    
    }
}
-(void)okClick{
    if (self.okButton) {
        [UIView animateWithDuration:0.35 animations:^{
            self.alpha=0;
        } completion:^(BOOL finished) {
            if (finished) {
                [self removeFromSuperview];
                [_blurView clearImage];
                [_blurView removeFromSuperview];
                if (self.OkBlock) {
                    self.OkBlock();
                }
            }
        }];
    }
    else{
        [UIView animateWithDuration:0.35 animations:^{
            self.alpha=0;
        } completion:^(BOOL finished) {
            if (finished) {
                [self removeFromSuperview];
                [_blurView clearImage];
                [_blurView removeFromSuperview];
              
            }
        }];

    }

}
-(void)showInView:(UIView *)view{
    BOOL isHas=[SCXCustomAlertView isHasView:view];
    if (isHas) {
        return;
    }
    UIView *contentView1=view?view:[UIApplication sharedApplication].keyWindow;
    _blurView.blurRadius=20;
    self.alpha=0;
    self.frame=contentView1.frame;
    self.tag=100000;
    [contentView1 addSubview:_blurView];
    [contentView1 addSubview:self];
    [UIView animateWithDuration:0.35 animations:^{
        self.alpha=1;
        _blurView.dynamic=NO;
        [FXBlurView setUpdatesDisabled];
    }];
    

}
-(void)setUpOkBlock:(BOOL (^)())okBlock{
    _OkBlock=okBlock;
}
-(void)setUpCancelBlock:(BOOL (^)())cancelBlock{
    _cancelBlock=cancelBlock;
}
+(BOOL)isHasView:(UIView *)view{
    if (view==nil) {
        view=[UIApplication sharedApplication].keyWindow;
    }
    UIView *alert=[view viewWithTag:100000];
    return alert!=nil;
}
@end
