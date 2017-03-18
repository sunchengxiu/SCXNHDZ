//
//  SCXCustomSegmentView.m
//  仿内涵段子
//
//  Created by 孙承秀 on 16/10/8.
//  Copyright © 2016年 孙先森丶. All rights reserved.
//

#import "SCXCustomSegmentView.h"

@implementation SCXCustomSegmentView
#pragma mark--初始化
-(instancetype)initSegmentWithTitles:(NSArray *)titlesArray{
    if (self=[super init]) {
        self.titlesArray=titlesArray;
        self.layer.borderWidth=1;
        self.layer.borderColor=kCommonTintColor.CGColor;
        self.layer.cornerRadius=3;
        [self setUpSegmentView];
    }
    return self;
}
-(void)setUpSegmentView{

    if (self.titlesArray.count>0    ) {
        for (NSInteger i=0; i<self.titlesArray.count; i++) {
            NSString *title=self.titlesArray[i];
            UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
            [self addSubview:button];
            button.backgroundColor=kCommonBgColor;
            [button setTitle:title forState:UIControlStateNormal];
            [button setTitleColor:kCommonTintColor forState:UIControlStateNormal];
            [button setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
            button.titleLabel.font=[UIFont systemFontOfSize:16];
            button.tag=i+1;
            button.adjustsImageWhenDisabled=NO;
            button.adjustsImageWhenHighlighted=NO;
            [button addTarget:self action:@selector(segmentButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        }
    }
}
-(void)segmentButtonClick:(UIButton *)button{
    _selectbutton.backgroundColor = kCommonBgColor;
    button.backgroundColor = [UIColor colorWithRed:0.42f green:0.33f blue:0.27f alpha:1.00f];
    _selectbutton.selected=NO;
    button.selected=YES;
    _selectbutton=button;
    //_selectbutton.backgroundColor=kCommonBgColor;
    //23345685989
    if (self.customSegmentViewButtonClickHandleBlock) {
        self.customSegmentViewButtonClickHandleBlock(self,button.currentTitle,button.tag-1);
    }
    
    
}
-(void)clickDefault{
    if (_titlesArray.count==0) {
        return;
    }
    [self segmentButtonClick:(UIButton *)[self viewWithTag:1]];

}
-(void)layoutSubviews{
    [super layoutSubviews];
    CGFloat width=self.frame.size.width/self.titlesArray.count;
    for (NSInteger i=0; i<self.titlesArray.count; i++) {
        UIButton *button=(UIButton *)[self viewWithTag:i+1];
        button.frame=CGRectMake(width*i, 0, width, self.frame.size.height);
    }
}
@end
