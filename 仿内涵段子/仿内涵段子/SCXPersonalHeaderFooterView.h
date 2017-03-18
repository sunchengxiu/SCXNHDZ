//
//  SCXPersonalHeaderFooterView.h
//  仿内涵段子
//
//  Created by 孙承秀 on 16/10/9.
//  Copyright © 2016年 孙先森丶. All rights reserved.
//

#import "SCXBaseHeaderFooterView.h"
@protocol SCXPersonalHeaderFooterViewDelegate;
@interface SCXPersonalHeaderFooterView : SCXBaseHeaderFooterView
@property(nonatomic,weak)id <SCXPersonalHeaderFooterViewDelegate>delegate;
@property (nonatomic, strong) UIButton *colBtn;
@property (nonatomic, strong) UIButton *publishBtn;
@property (nonatomic, strong) UIButton *commentBtn;
@property (nonatomic, strong) UIButton *selectButton;
@property (nonatomic, strong) CALayer *runningLineLayer;
@property (nonatomic, strong) CALayer *lineLayer;
-(void)clickDefaultType;
@end
@protocol SCXPersonalHeaderFooterViewDelegate <NSObject>

-(void)personalHeaderFoooterView:(SCXPersonalHeaderFooterView *)headerView clickHeaderType:(SCXPersonalHeaderFooterViewType)type;

@end
