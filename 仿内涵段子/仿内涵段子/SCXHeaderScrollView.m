//
//  SCXHeaderScrollView.m
//  仿内涵段子
//
//  Created by 孙承秀 on 16/10/11.
//  Copyright © 2016年 孙先森丶. All rights reserved.
//

#import "SCXHeaderScrollView.h"

@implementation SCXHeaderScrollView

-(void)setTitlesArray:(NSArray<NSString *> *)titlesArray{
    if (titlesArray.count) {
        for (NSInteger i=0; i<titlesArray.count; i++) {
            NSString *title=titlesArray[i];
            SCXCustomScrollViewItemLabel *titleLabel=[[SCXCustomScrollViewItemLabel alloc]init
            ];
            self.scrollView.userInteractionEnabled=YES;
            [self setUserInteractionEnabled:YES];
            [self.scrollView addSubview:titleLabel];
            titleLabel.text=title;
            titleLabel.textAlignment=NSTextAlignmentCenter;
            titleLabel.tag=i+1;
            titleLabel.userInteractionEnabled=YES;
            UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(titleLabelTap:)];
            [titleLabel addGestureRecognizer:tap];
        }
    }
    if (titlesArray.count) {
        self.scrollView.frame=CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height-1);
        self.scrollView.contentSize=CGSizeMake(60*self.titlesArray.count, self.scrollView.frame.size.height-1);
        CGFloat titleLabelWIdth=60;
        for (NSInteger i=0; i<titlesArray.count; i++) {
            SCXCustomScrollViewItemLabel *label=(SCXCustomScrollViewItemLabel *)[self.scrollView viewWithTag:i+1];
            label.frame=CGRectMake(titleLabelWIdth*i, 0, titleLabelWIdth, self.scrollView.frame.size.height);
        }
    }
    self.lineLayer.frame=CGRectMake(0, self.scrollView.frame.size.height-1, ScreenWidth, 1);
}
-(void)setContentOfSet:(CGPoint)contentOfSet{
    _contentOfSet=contentOfSet;
    NSInteger index=contentOfSet.x/ScreenWidth;
    SCXCustomScrollViewItemLabel *leftLabel=(SCXCustomScrollViewItemLabel *)[self.scrollView viewWithTag:1+index];
    SCXCustomScrollViewItemLabel *rightLabel=(SCXCustomScrollViewItemLabel *)[self.scrollView viewWithTag:2+index];
    CGFloat offset=contentOfSet.x-index*ScreenWidth;
    CGFloat spreed=offset/ScreenWidth;
    if ([leftLabel isKindOfClass:[SCXCustomScrollViewItemLabel class]]) {
        leftLabel.textColor=kCommonHighLightRedColor;
        leftLabel.fillColor=kCommonBlackColor;
        leftLabel.progress=spreed;
    }
    if ([rightLabel isKindOfClass:[SCXCustomScrollViewItemLabel class]]) {
        rightLabel.textColor=kCommonBlackColor;
        rightLabel.fillColor=kCommonHighLightRedColor;
        rightLabel.progress=spreed;
    }
    for (SCXCustomScrollViewItemLabel *label in self.scrollView.subviews) {
        if ([label isKindOfClass:[SCXCustomScrollViewItemLabel class]]) {
            if (label.tag!=index+1&&label.tag!=index+2) {
                label.textColor=kCommonBlackColor;
                label.fillColor=kCommonHighLightRedColor;
                label.progress=0;
            }
        }
    }
    self.currentIndex=index;

}

-(void)titleLabelTap:(UITapGestureRecognizer *)tap{
    SCXCustomScrollViewItemLabel *label=(SCXCustomScrollViewItemLabel *)tap.view;
    if (label) {
        if (self.clickTitleHandleBlock) {
            self.clickTitleHandleBlock(self,label.text,label.tag-1);
        }
        self.currentIndex=label.tag-1;
    }
}
-(UIScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView=[[UIScrollView alloc]init];
        [self addSubview:_scrollView];
        _scrollView.backgroundColor=[UIColor clearColor];
        _scrollView.showsVerticalScrollIndicator=NO;
        _scrollView.showsHorizontalScrollIndicator=NO;
    }
    return _scrollView;
}
-(CALayer *)lineLayer{
    if (_lineLayer==nil) {
        _lineLayer=[CALayer layer];
        [self.scrollView.layer addSublayer:_lineLayer]
        ;
        _lineLayer.backgroundColor=kSeperatorColor.CGColor;
        
    }
    return _lineLayer;
}

@end
