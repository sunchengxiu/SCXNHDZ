//
//  SCXCustomActionSheetView.h
//  仿内涵段子
//
//  Created by 孙承秀 on 16/10/6.
//  Copyright © 2016年 孙先森丶. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SCXCustomActionSheetView;
typedef void (^SCXCustomActionSheetViewClickHandle)(SCXCustomActionSheetView *actionSheet,NSInteger currentIndex,NSString *title);
@interface SCXCustomActionSheetView : UIView<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSMutableArray *titleArray;
@property(nonatomic,copy)NSString *actionTitle;
@property(nonatomic,copy)NSString *cancelTitle;
@property(nonatomic,strong)UIView *backgroundView;
@property(nonnull,copy)SCXCustomActionSheetViewClickHandle clickBlck;
@property(nonnull,copy)SCXCustomActionSheetViewClickHandle dismissblock;
+(instancetype)customActionSheetWithActionTitle:(NSString *)actionTitle andCancelTitle:(NSString *)cancelTitle andSutitles:(NSString *)title,...NS_REQUIRES_NIL_TERMINATION;
-(void)setActionSheetClickHandleBlock:(SCXCustomActionSheetViewClickHandle)clickBlock;
-(void)show;
@end
