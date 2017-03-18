//
//  SCXHomeBaseTableviewController.m
//  仿内涵段子
//
//  Created by 孙承秀 on 16/9/27.
//  Copyright © 2016年 孙先森丶. All rights reserved.
//

#import "SCXHomeBaseTableviewController.h"
#import "SCXHomeRequest.h"
#import "SCXHomeModel.h"
#import "SCXHomeAllModel.h"
#import "SCXHomeServerModel.h"
#import "SCXBaseTableViewCell.h"
#import "SCXHomeTableViewCell.h"
#import "MJPhotoView.h"
#import "MJPhotoBrowser.h"
#import "MJPhoto.h"
#import "SCXCustomAlertView.h"
#import "SCXPersonalZoneViewController.h"
@implementation SCXHomeBaseTableviewController
- (instancetype)initWithUrl:(NSString *)url {
    if (self = [super init]) {
        self.url = url;
    }
    return self;
}
- (NSMutableArray *)cellFrameArray {
    if (!_cellFrameArray) {
        _cellFrameArray = [NSMutableArray new];
    }
    return _cellFrameArray;
}
-(void)viewDidLoad{
    [super viewDidLoad];
    self.needCellSepLine=YES;
   // self.view.backgroundColor=[UIColor redColor];
   
    self.refreshType=SCXREefreshTypeRefresh;
    
    if (self.url.length>0) {
        SCXHomeRequest *homeRequest=[SCXHomeRequest SCX_Request];
        homeRequest.SCX_url=self.url;
        self.request=homeRequest;
        [self loadData];
    }
    else{
        return;
    }
}
-(void)viewWillDisappear:(BOOL)animated{

    [super viewWillDisappear:animated];
    [self releaseVideo];
}
-(void)loadData{
    [self.dataArray removeAllObjects];
    if (self.request) {
        [self.request SCX_sendRequestWithComplement:^(id responseObject , BOOL success, NSString *message) {
            if (success&&[message isEqualToString:@"success"]) {
                SCXHomeServerModel *model=[SCXHomeServerModel modelWithDictionary:responseObject ];
                NSLog(@"%@",self.url);
                NSLog(@"%@",model.tip);
                for (NSInteger i=0; i<model.data.count; i++) {
                    SCXHomeAllModel *allModel=model.data[i];
                    self.allModel=allModel;
                    if (allModel.group&&allModel.group.media_type<5) {
                        [self.dataArray addObject:allModel];
                        SCXHomeTableViewCellFrame *cellFrame = [[SCXHomeTableViewCellFrame alloc] init];
                        cellFrame.model = allModel;
                        [self.cellFrameArray addObject:cellFrame];
                    }
                }
                if (self.dataArray.count>0) {
                     [self SCX_reloadData];
                }
               
                
            }
            else{
                [self.dataArray removeAllObjects];
                //[self.view removeFromSuperview];
            }
        }];
    }
}
#pragma mark--tableView代理方法继承自父控制器
-(NSInteger)SCX_numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;

}
-(SCXBaseTableViewCell *)SCX_tableViewCellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SCXHomeTableViewCell *cell=[SCXHomeTableViewCell cellWithTableView:self.tableView];
  SCXHomeTableViewCellFrame *cellFrame = self.cellFrameArray[indexPath.row];
    cell.cellFrame = cellFrame;
   
    cell.isFromHomeController = YES;
    cell.delegate=self;
    return cell;

}
-(UIColor *)randomColor{
    CGFloat hue=arc4random()%256/256.0;
    CGFloat saturation=arc4random()%128/256.0+0.5;
    CGFloat brightness=arc4random()%128/256.0+0.5;
    return [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
}
-(void)SCX_tableViewDidSelectRowAtIndexPath:(NSIndexPath *)indexPath withCell:(SCXBaseTableViewCell *)cell{

}
-(CGFloat)SCX_tableViewHeightForFooterInSection:(NSInteger)section{
    return 0;
}
-(CGFloat)SCX_tableViewHeightForHeaderInSection:(NSInteger)section{
    return 0;
}
-(CGFloat)SCX_tableViewHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    SCXHomeTableViewCellFrame *frame=self.cellFrameArray[indexPath.row];
    return frame.cellHeight;
    
   
}
-(NSInteger)SCX_tableViewNumberOfRowsInSection:(NSInteger)section{
    //NSLog(@"----%ld",self.dataArray.count);
    return self.dataArray.count;
}
-(UIView *)SCX_tableViewViewForFooterInSection:(NSInteger)section{
    return nil;
}
-(UIView *)SCX_tableViewViewForHeaderInSection:(NSInteger)section{
    return nil;

}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGRect rectIntableView=[self.tableView rectForRowAtIndexPath:self.indexPath];
    CGRect rectInSuperView=[self.tableView convertRect:rectIntableView toView:self.tableView.superview];
    
    if ((rectInSuperView.origin.y<-self.videoImageView.frame.size.height)||(rectInSuperView.origin.y>ScreenHeight-64-49)) {
        if ([[UIApplication sharedApplication].keyWindow.subviews containsObject:_player ]&&self.isSmallScreen) {
            self.isSmallScreen=YES;
        }
        else{
            [self toSmallPlay];
           // [self releaseVideo];
        }
    }
    else{
        if ([self.videoImageView.subviews containsObject:_player]) {
            
        }
        else{
            if(self.isSmallScreen){
                [self toCellPlay];
            }
            
           
        }
    }

}
#pragma mark--homeTableViewCell代理方法
-(void)homeTableViewCell:(SCXHomeTableViewCell *)homeCEll withVideoUrl:(NSString *)videoUrl withVideoImageView:(SCXBaseImageView *)videoImageVideo{
    if (self.player) {
        [self releaseVideo];
       
    }
    
    self.player=[[WMPlayer alloc]initWithFrame:videoImageVideo.bounds];
    self.player.delegate=self;
    self.player.closeBtnStyle=CloseBtnStyleClose;
    self.player.URLString=videoUrl;
    self.videoImageView=videoImageVideo;
    self.indexPath=[self.tableView indexPathForCell:homeCEll];
    [videoImageVideo addSubview:self.player];
    [self.player play];
}
-(void)homeTableViewCell:(SCXHomeTableViewCell *)homeCEll withImageView:(SCXBaseImageView *)imageView currentIndex:(NSInteger)index urls:(NSArray *)urls{
    MJPhotoBrowser *browser=[[MJPhotoBrowser alloc]init];
    NSMutableArray *arr=[[NSMutableArray alloc]initWithCapacity:0];
    for (NSURL *imageUrl in urls) {
        MJPhoto *photo=({
            MJPhoto *photo=[[MJPhoto alloc]init];
            photo.url=imageUrl;
            photo.srcImageView=imageView;
            photo;
        });
        [arr addObject:photo];
    }
    browser.photos=arr;
    browser.currentPhotoIndex=index;
    [browser show];
    

}
-(void)homeTableViewCellDidClickCloseButtonHandleWithHomentableViewCell:(SCXHomeTableViewCell *)cell{
    SCXCustomAlertView *alertView=[[SCXCustomAlertView alloc]initWithTitle:@"确认删除后，内涵段子将减少给您推荐类似的内容，您确认要删除吗？" andCancelTitle:@"取消" andOKTitle:@"确定"];
    [alertView showInView:[UIApplication sharedApplication].keyWindow];
    __block typeof(self)weakSelf=self;
    [alertView setUpOkBlock:^BOOL{
        [weakSelf deleteCellAtIndexPath:[self.tableView indexPathForCell:cell]];
        return YES;
    }];
}
-(void)homeTableViewCellDidClickIconImage:(SCXHomeTableViewCell *)cell andUserModel:(SCXUserInfoModel *)userModel{
    SCXPersonalZoneViewController *personal=[[SCXPersonalZoneViewController alloc]initWithUserModel:userModel];
    [self pushViewController:personal];

}
-(void)SCXHomeTableViewCell:(SCXHomeTableViewCell *)cell didClickItemtype:(SCXHomeCellDidClickItemType)type{
    NSIndexPath *indexPath=[self.tableView indexPathForCell:cell];
    SCXHomeTableViewCellFrame *cellFrame=self.cellFrameArray[indexPath.row];
    __block typeof(self)weakSelf=self;
    switch (type) {
        case SCXHomeCellDidClickItemTypeLIke:{
            [self goToRequestWithActionName:@"digg" andActionindexPath:indexPath];
        }
            
            break;
        case SCXHomeCellDidClickItemTypeDontLike:{
            [self goToRequestWithActionName:@"bury" andActionindexPath:indexPath];
        }
            break;
        case SCXHomeCellDidClickItemTypeShare:{
            SCXCustomShareView *shareView=[SCXCustomShareView shareViewWithType:SCXShareViewTypeShowCopyAndCollect hasrepinFlag:cellFrame.model.group.user_repin];
            [shareView showInView:self.view];
            [shareView setUpDidClickShareHandBlock:^(SCXCustomShareView *shareView, NSString *title, NSInteger index, SCXShareManagerType type) {
                 [[SCXShareManager sharedManager] shareWithShareType:type image:nil url:@"www.baidu.com" content:@"不错" cobtroller:weakSelf];
            }];
            [shareView setUpDidClickBottomHandleBlock:^(SCXCustomShareView *shareView, NSString *title, NSInteger index) {
                switch (index) {
                    case 0:{
                        NSLog(@"复制");
                        NSString *url=cellFrame.model.group.share_url;
                        UIPasteboard *pasteBoard=[UIPasteboard generalPasteboard];
                        pasteBoard.string=url;
                        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                            [MBProgressHUD showSuccess:@"以复制" toView:[UIApplication sharedApplication].keyWindow];
                            
                        });
                        
                    }
                        
                        break;
                    case 1:{
                        NSLog(@"收藏");
                        [self goToRequestWithActionName:cellFrame.model.group.user_repin? @"unrepin" : @"repin" andActionindexPath:indexPath];
                    }
                        break;
                    case 2:{
                        NSLog(@"举报");
                    }
                        break;
                        
                    default:
                        break;
                }
            }];
        }
            break;
        case SCXHomeCellDidClickItemTypeComment:{
            SCXDetailViewController *detailViewController=[[SCXDetailViewController alloc]initWithCellFrame:cellFrame];
            [self pushViewController:detailViewController];
        }
            break;
            
        default:
            break;
    }

}
-(void)goToRequestWithActionName:(NSString *)actionName andActionindexPath:(NSIndexPath *)indexPath{
    SCXHomeTableViewCell *cell=[self.tableView cellForRowAtIndexPath:indexPath];
    SCXHomeTableViewCellFrame *cellFrame=self.cellFrameArray[indexPath.row];
    if ([actionName isEqualToString:@"digg"]) {
        if (cellFrame.model.group.user_digg) {
            cellFrame.model.group.user_digg=0;
            cellFrame.model.group.digg_count -= 1;
            [cell cancelDigg];
            return;
        }
        cellFrame.model.group.user_digg = 1;
        cellFrame.model.group.digg_count += 1;
        [cell didDigg];
    }
    if ([actionName isEqualToString:@"bury"]) {
        if (cellFrame.model.group.user_bury) {
            cellFrame.model.group.user_bury=0;
            cellFrame.model.group.bury_count -= 1;
            [cell cancelBury];
            return;
        }
        cellFrame.model.group.user_bury = 1;
        cellFrame.model.group.bury_count += 1;
        [cell didBury];
    }
   if ([actionName isEqualToString:@"repin"]) { // 收藏
        cellFrame.model.group.user_repin = 1;
    }
    if ([actionName isEqualToString:@"unrepin"]) { // 取消收藏
        cellFrame.model.group.user_repin = 0;
    }

}
-(void)deleteCellAtIndexPath:(NSIndexPath *)indexPath{
    
    [self.dataArray removeObjectAtIndex:indexPath.row];
    [self.cellFrameArray removeObjectAtIndex:indexPath.row];
    [self.tableView SCX_deleteSingleRowAtIndexPath:indexPath];
}
#pragma mark--WMPlayer Delegate
-(BOOL)prefersStatusBarHidden{
    if (_player) {
        if (_player.isFullscreen) {
            return YES;
        }
        else{
            return NO;
        }
    }
    else{
        return NO;
    }
    
}
//点击播放暂停按钮代理方法
-(void)wmplayer:(WMPlayer *)wmplayer clickedPlayOrPauseButton:(UIButton *)playOrPauseBtn{
    BOOL isPlay=playOrPauseBtn.selected;
    if (isPlay) {
        NSLog(@"播放了");
        
    }
    else{
        NSLog(@"暂停了");
    }
}
//点击关闭按钮代理方法
-(void)wmplayer:(WMPlayer *)wmplayer clickedCloseButton:(UIButton *)closeBtn{
    [self releaseVideo];
    NSLog(@"关闭了");
}
//点击全屏按钮代理方法
-(void)wmplayer:(WMPlayer *)wmplayer clickedFullScreenButton:(UIButton *)fullScreenBtn{
    if (fullScreenBtn.isSelected) {
        _player.isFullscreen=YES;
        [self setNeedsStatusBarAppearanceUpdate];
        [self toFullScreenHandleWithInterfaceOrientation:UIInterfaceOrientationLandscapeRight];
        NSLog(@"全屏了");
    }
    else{
        [self toCellPlay];
    }
   
}
//单击WMPlayer的代理方法
-(void)wmplayer:(WMPlayer *)wmplayer singleTaped:(UITapGestureRecognizer *)singleTap{
    NSLog(@"单击方法");
}
//双击WMPlayer的代理方法
-(void)wmplayer:(WMPlayer *)wmplayer doubleTaped:(UITapGestureRecognizer *)doubleTap{
    [self toFullScreenHandleWithInterfaceOrientation:UIInterfaceOrientationLandscapeRight];
    [_player play];
    NSLog(@"双击方法");
}

///播放状态
//播放失败的代理方法
-(void)wmplayerFailedPlay:(WMPlayer *)wmplayer WMPlayerStatus:(WMPlayerState)state{
    NSLog(@"播放失败了");
}
//准备播放的代理方法
-(void)wmplayerReadyToPlay:(WMPlayer *)wmplayer WMPlayerStatus:(WMPlayerState)state{
    NSLog(@"准备播放");
}
//播放完毕的代理方法
-(void)wmplayerFinishedPlay:(WMPlayer *)wmplayer{
    NSLog(@"播放完成");
}
#pragma mark--播放器上按钮处理方法
-(void)toFullScreenHandleWithInterfaceOrientation:(UIInterfaceOrientation)orientation{
    [_player removeFromSuperview];
    _player.transform=CGAffineTransformIdentity;
    if (orientation==UIInterfaceOrientationLandscapeLeft) {
        _player.transform=CGAffineTransformMakeRotation(-M_PI_2);
    }
    else if (orientation==UIInterfaceOrientationLandscapeRight){
        _player.transform=CGAffineTransformMakeRotation(M_PI_2);
    
    }
    _player.frame=CGRectMake(0, 0, ScreenWidth, ScreenHeight);
    //_player.playerLayer.frame=CGRectMake(0, 0, ScreenHeight, ScreenWidth);
    [_player.bottomView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(40);
        make.top.mas_equalTo(ScreenWidth-40);
        make.width.mas_equalTo(ScreenHeight);
    }];
    [_player.topView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(40);
        make.width.mas_equalTo(ScreenHeight);
        make.left.equalTo(_player).offset(0);
    }];
    [_player.closeBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_player).with.offset((-ScreenHeight/2));
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(30);
        make.top.equalTo(_player).with.offset(5);
        
    }];
    [_player.titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_player.topView).with.offset(45);
        make.right.equalTo(_player.topView).with.offset(-45);
        make.center.equalTo(_player.topView);
        make.top.equalTo(_player.topView).with.offset(0);
    }];
    [_player.loadFailedLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(ScreenHeight);
        make.center.mas_equalTo(CGPointMake(ScreenWidth/2-36, -(ScreenWidth/2)));
        make.height.equalTo(@30);
    }];
    [_player.loadingView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(CGPointMake(ScreenWidth/2-37, -(ScreenWidth/2-37)));
    }];
    [_player.loadFailedLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(ScreenHeight);
        make.center.mas_equalTo(CGPointMake(ScreenWidth/2-36, -(ScreenWidth/2)+36));
        make.height.equalTo(@30);
    }];
    [[UIApplication sharedApplication].keyWindow addSubview:_player];
    _player.fullScreenBtn.selected=YES;
    [_player bringSubviewToFront:_player.bottomView];
   
}
-(void)toCellPlay{
    
    [_player removeFromSuperview];
    [UIView animateWithDuration:0.25 animations:^{
        [_player pause];
        _player.transform=CGAffineTransformIdentity;
        _player.frame=self.videoImageView.bounds;
        [self.videoImageView addSubview:_player];
        [self.videoImageView bringSubviewToFront:_player];
        [_player.bottomView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_player).with.offset(0);
            make.right.equalTo(_player).with.offset(0);
            make.height.mas_equalTo(40);
            make.bottom.equalTo(_player).with.offset(0);
        }];
        [_player.topView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_player).with.offset(0);
            make.right.equalTo(_player).with.offset(0);
            make.height.mas_equalTo(40);
            make.top.equalTo(_player).with.offset(0);
        }];
        [_player.titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_player.topView).with.offset(45);
            make.right.equalTo(_player.topView).with.offset(-45);
            make.center.equalTo(_player.topView);
            make.top.equalTo(_player.topView).with.offset(0);
        }];
        [_player.closeBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_player).with.offset(5);
            make.height.mas_equalTo(30);
            make.width.mas_equalTo(30);
            make.top.equalTo(_player).with.offset(5);
        }];
        [_player.loadFailedLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(_player);
            make.width.equalTo(_player);
            make.height.equalTo(@30);
        }];
        _player.isFullscreen = NO;
        [self setNeedsStatusBarAppearanceUpdate];
        self.isSmallScreen = NO;
        _player.fullScreenBtn.selected = NO;
        [_player play];
    }];

}
#pragma mark--小屏播放
-(void)toSmallPlay{
   
    [_player removeFromSuperview];
    [UIView animateWithDuration:0.25 animations:^{
        _player.transform=CGAffineTransformIdentity;
        _player.frame=CGRectMake(ScreenWidth-ScreenWidth/2, 64, ScreenWidth/2, (ScreenWidth/2)*0.75);
       
        [_player.bottomView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_player).with.offset(0);
            make.right.equalTo(_player).with.offset(0);
            make.height.mas_equalTo(40);
            make.bottom.equalTo(_player).with.offset(0);
        }];
        [_player.topView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_player).with.offset(0);
            make.right.equalTo(_player).with.offset(0);
            make.height.mas_equalTo(40);
            make.top.equalTo(_player).with.offset(0);
        }];
        [_player.titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_player.topView).with.offset(45);
            make.right.equalTo(_player.topView).with.offset(-45);
            make.center.equalTo(_player.topView);
            make.top.equalTo(_player.topView).with.offset(0);
        }];
        [_player.closeBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_player).with.offset(5);
            make.height.mas_equalTo(30);
            make.width.mas_equalTo(30);
            make.top.equalTo(_player).with.offset(5);
            
        }];
        [_player.loadFailedLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(_player);
            make.width.equalTo(_player);
            make.height.equalTo(@30);
        }];
        [[UIApplication sharedApplication].keyWindow addSubview:_player];
        [[UIApplication sharedApplication].keyWindow bringSubviewToFront:_player];

    } completion:^(BOOL finished) {
        self.isSmallScreen=YES;
        _player.isFullscreen=NSNotFound;
    }];

}
#pragma mark--释放视频
-(void)releaseVideo{

    [_player pause];
    [_player removeFromSuperview];
    [_player.playerLayer removeFromSuperlayer];
    [_player.player replaceCurrentItemWithPlayerItem:nil];
    _player.player=nil;
    _player.currentItem=nil;
    [_player.autoDismissTimer invalidate];
    _player.autoDismissTimer=nil;
    _player.playOrPauseBtn=nil;
    _player.playerLayer=nil;
    _player=nil;
}

@end
