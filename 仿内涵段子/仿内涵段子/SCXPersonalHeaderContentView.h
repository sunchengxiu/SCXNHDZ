//
//  SCXPersonalHeaderContentView.h
//  仿内涵段子
//
//  Created by 孙承秀 on 16/10/9.
//  Copyright © 2016年 孙先森丶. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SCXPersonalContentViewDelegate;

@interface SCXPersonalHeaderContentView : UIView
@property(nonatomic,weak)id <SCXPersonalContentViewDelegate> delegate;
@property(nonatomic,assign)NSInteger follow_count;
@property(nonatomic,assign)NSInteger fans_count;
@property(nonatomic,assign)NSInteger share_count;
@property(nonatomic,strong)CALayer *topLayer;
@property(nonatomic,strong)CALayer *bottomLayer;


@end
@protocol SCXPersonalContentViewDelegate <NSObject>

-(void)personalContentView:(SCXPersonalHeaderContentView *)contentView andButtonType:(SCXPersonalHeaderViewType)type;

@end
