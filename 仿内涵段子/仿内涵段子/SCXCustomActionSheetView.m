//
//  SCXCustomActionSheetView.m
//  仿内涵段子
//
//  Created by 孙承秀 on 16/10/6.
//  Copyright © 2016年 孙先森丶. All rights reserved.
//

#import "SCXCustomActionSheetView.h"
#import "SCXUtils.h"
@implementation SCXCustomActionSheetView
#pragma mark--懒加载
- (UITableView *)tableView {
    if(!_tableView) {
        UITableView *tab = [[UITableView alloc] init];
        tab.delegate = self;
        tab.dataSource = self;
        tab.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        tab.tableFooterView = nil;
        [self addSubview:tab];
        tab.scrollEnabled = NO;
        _tableView = tab;
    }
    return _tableView;
}
- (UIView *)backgroundView {
    if(!_backgroundView) {
        UIView *view = [[UIView alloc] initWithFrame:self.bounds];
        view.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.2f];
        
        [self addSubview:view];
        _backgroundView = view;
    }
    return _backgroundView;
}
-(NSMutableArray *)titleArray{
    if (!_titleArray) {
        _titleArray=[[NSMutableArray alloc]initWithCapacity:0];
    }
    return _titleArray;
}
+(instancetype)customActionSheetWithActionTitle:(NSString *)actionTitle andCancelTitle:(NSString *)cancelTitle andSutitles:(NSString *)title,...NS_REQUIRES_NIL_TERMINATION{

    SCXCustomActionSheetView *actionSheet=[[SCXCustomActionSheetView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    actionSheet.cancelTitle=cancelTitle;
    actionSheet.actionTitle=actionTitle;
    NSString *subtitle;
    va_list list;
    if(title){
        [actionSheet.titleArray addObject:title];
        va_start(list, title);
        while((subtitle=va_arg(list, id))){
            NSString *tit=[subtitle copy];
            [actionSheet.titleArray addObject:tit];
        }
        va_end(list);
    }
    return actionSheet;
}
-(instancetype)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        [self backgroundView];
    }
    return self;
}
-(void)setActionSheetClickHandleBlock:(SCXCustomActionSheetViewClickHandle)clickBlock{
    _clickBlck=clickBlock;
}
-(void)setactionSheetDismissHandleBlock:(SCXCustomActionSheetViewClickHandle)dismisshandle{
    _dismissblock=dismisshandle;

}
#pragma maek--tableViewDelegateAndDataSource
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section==0) {
        UIView *view=[[UIView alloc]init];
        view.frame=CGRectMake(0, 0, ScreenWidth, 60);
        view.backgroundColor=[UIColor whiteColor];
        NSMutableAttributedString *attributeString=[[NSMutableAttributedString alloc]initWithString:kvalidStr(self.actionTitle)];
        [attributeString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:ScreenWidth>320?14:13] range:NSMakeRange(0, self.actionTitle.length)];
        [attributeString addAttribute:NSForegroundColorAttributeName value:[[UIColor blackColor] colorWithAlphaComponent:0.5] range:NSMakeRange(0, self.actionTitle.length)];
        [attributeString addAttribute:NSKernAttributeName value:@(20) range:NSMakeRange(0, self.actionTitle.length)];
        NSMutableParagraphStyle *style=[[NSMutableParagraphStyle alloc]init];
        style.lineBreakMode=NSLineBreakByCharWrapping;
        style.lineSpacing=3;
        style.alignment=NSTextAlignmentCenter;
        [attributeString addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0, self.actionTitle.length)];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(30, 3, ScreenWidth - 30 * 2, 52)];
        label.attributedText=attributeString;
        label.numberOfLines=0;
        [view addSubview:label];
        CALayer *layer=[CALayer layer];
        layer.frame=CGRectMake(0, 60-(1/[UIScreen mainScreen].scale), ScreenWidth, (1/[UIScreen mainScreen].scale));
        [view.layer addSublayer:layer];
        layer.backgroundColor=kSeperatorColor.CGColor;
        return view;
    }
    else{
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 5)];
        view.backgroundColor = kSeperatorColor;
        return view;
    }
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section==0) {
        if ([kvalidStr(self.actionTitle) length]!=0) {
            return 60;
        }
        else{
            return 0.01;
        }
    }
    else{
        return 5;
    }

}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section==0) {
        return self.titleArray.count;
    }
    else{
    return 1;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cellID"];
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cellID"];
    cell.backgroundColor=[UIColor whiteColor];
     cell.textLabel.font = [UIFont systemFontOfSize:ScreenWidth > 320 ? 16 : 15];
    if (indexPath.section==0) {
        NSString *title=self.titleArray[indexPath.row];
        if ([title containsString:@"删除"]||[title containsString:@"delete"]) {
            cell.textLabel.textColor = kRedColor;
        }
        else{
           cell.textLabel.textColor = kCommonBlackColor;
        }
        cell.textLabel.text=self.titleArray[indexPath.row];
    }
    else{
        cell.textLabel.text=self.cancelTitle;
    }
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return ScreenWidth > 320 ? 55 : 50.f;;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self dismissCell:[tableView cellForRowAtIndexPath:indexPath]];
}
-(void)dismissCell:(UITableViewCell *)cell{
    NSIndexPath *indexPath=[self.tableView indexPathForCell:cell];
    if (indexPath.section==1) {
        if (_dismissblock) {
            [UIView animateWithDuration:0.2 animations:^{
                self.backgroundView.alpha=0;
                self.backgroundView.transform=CGAffineTransformIdentity;
            } completion:^(BOOL finished) {
                if (finished) {
                    _dismissblock(self,indexPath.row,cell.textLabel.text);
                    [self removeFromSuperview];
                }
            }];
        }
        else{
            [self dismiss];
        }
    }
    else{
    
        [UIView animateKeyframesWithDuration:0.2 delay:0 options:UIViewKeyframeAnimationOptionCalculationModeLinear animations:^{
            self.backgroundView.alpha = 0.0;
            self.tableView.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            if (finished) {
                if (_clickBlck) {
                    _clickBlck(self,indexPath.row   ,cell.textLabel.text    );
                    
                }
                [self removeFromSuperview];
            }
        }];
    }

}
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    if([tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    if([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
    if([tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [tableView setLayoutMargins:UIEdgeInsetsZero];
    }
    
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch *touch=[touches anyObject];
    if (![touch.view isEqual:self.tableView]) {
        
        [self dismissCell:[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:1]]];
    }
}
-(void)show{
    if ([[UIApplication sharedApplication].keyWindow viewWithTag:10000]) {
        return;
    }
    self.backgroundView.alpha=0;
    self.tableView.frame=CGRectMake(0, ScreenHeight, ScreenWidth, [self heightFortableView]);
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    [[UIApplication sharedApplication].keyWindow bringSubviewToFront:self];
    self.tag=10000;
    NSLog(@"%f",[self heightFortableView]);
    [UIView animateKeyframesWithDuration:0.2 delay:0 options:UIViewKeyframeAnimationOptionCalculationModeLinear animations:^{
        self.backgroundView.alpha=1;
        self.tableView.transform=CGAffineTransformMakeTranslation(0, -[self heightFortableView]);
    } completion:^(BOOL finished) {
        
    }];
}
- (void)dismiss {
    [UIView animateWithDuration:0.22f animations:^{
        self.backgroundView.alpha = 0.0;
        self.tableView.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        if(finished) {
            [self removeFromSuperview];
        }
    }];
}
-(CGFloat)heightFortableView{
    CGFloat rowheight=ScreenWidth>320?55:50;
   // NSLog(@"%@",self.actionTitle);
    NSLog(@"%@",self.titleArray);
    CGFloat height1=[kvalidStr(self.actionTitle) length]!=0?60:0;
    return height1+rowheight*(self.titleArray.count+1);
    //return 200;
}
@end
