//
//  SCXDetailViewController.m
//  仿内涵段子
//
//  Created by 孙承秀 on 16/10/12.
//  Copyright © 2016年 孙先森丶. All rights reserved.
//

#import "SCXDetailViewController.h"

@interface SCXDetailViewController ()

@end

@implementation SCXDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpNavigationItem];
    [self loadData];
    // Do any additional setup after loading the view.
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self releaseVideo];
}
-(instancetype)initWithCellFrame:(SCXHomeTableViewCellFrame *)cellFrame{
    if (self=[super init]) {
        self.cellFrame=cellFrame;
    }
    return self;
}
-(instancetype)initWithSearchCellFrame:(SCXDiscoverCellFrame *)cellFrame{
    if (self=[super init]) {
        self.searchCellFrame=cellFrame;
    }
    return self;
}
-(void)setUpNavigationItem{

    self.navigationItem.title=@"详情";
}
-(void)loadData{
    // 加载动态内容
    if (self.cellFrame) {
        //SCXHomeTableViewCellFrame *cellFrame = [[SCXHomeTableViewCellFrame alloc] init];
        SCXHomeTableViewCellFrame *cellFrame=[[SCXHomeTableViewCellFrame alloc] init];
        [cellFrame setModel:self.cellFrame.model isDetail:YES];
        self.cellFrame = cellFrame;
        [self SCX_reloadData];
    } else if (self.searchCellFrame) {
//        // 将seachcellframe里面的group组装为element然后封装为tableviewcellframe
//        SCXHomeTableViewCellFrame *cellFrame = [[SCXHomeTableViewCellFrame alloc] init];
//        NHHomeServiceDataElement *element =[[NHHomeServiceDataElement alloc] init];
//        element.group = self.searchCellFrame.group;
//        [cellFrame setModel:element isDetail:YES];
//        self.cellFrame = cellFrame;
//        [self nh_reloadData];
    }
    // 评论
    SCXDetailRequest *request = [SCXDetailRequest SCX_Request];
    request.SCX_url = kNHHomeDynamicCommentListAPI;
    if (self.cellFrame) {
        request.group_id = self.cellFrame.model.group.ID;
    } else {
        //request.group_id = self.searchCellFrame.group.ID;
    }
    request.sort = @"hot";
    request.offset = 0;
    [request SCX_sendRequestWithComplement:^(id response, BOOL success, NSString *message) {
        if (success) {
            if ([response isKindOfClass:[NSDictionary class]]) {
                NSDictionary *dict = (NSDictionary *)response;
                // 最近评论
                if ([dict.allKeys containsObject:@"recent_comments"]) {
                    self.dataArray = [SCXHomeCommentModel objectArrayWithKeyValuesArray:response[@"recent_comments"]];
                    for (SCXHomeCommentModel *comment in self.dataArray) {
                        SCXDetailCellFrame *cellFrame = [[SCXDetailCellFrame alloc] init];
                        cellFrame.commentModel = comment;
                        [self.commentCellFrameArray addObject:cellFrame];
                    }
                }
                // 热门评论
                if ([dict.allKeys containsObject:@"top_comments"]) {
                    self.topDataArray = [SCXHomeCommentModel objectArrayWithKeyValuesArray:response[@"top_comments"]];
                    for (SCXHomeCommentModel *comment in self.topDataArray) {
                        SCXDetailCellFrame *cellFrame = [[SCXDetailCellFrame alloc] init];
                        cellFrame.commentModel = comment;
                        [self.topCommentCellFrameArray addObject:cellFrame];
                    }
                }
            }
            
            [self SCX_reloadData];
        }
    }];
    

}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGRect rectIntableView=[self.tableView rectForRowAtIndexPath:self.indexPath];
    CGRect rectInSuperView=[self.tableView convertRect:rectIntableView toView:self.tableView.superview];
    
    if ((rectInSuperView.origin.y<-self.imageView.frame.size.height)||(rectInSuperView.origin.y>ScreenHeight-64-49)) {
        if ([[UIApplication sharedApplication].keyWindow.subviews containsObject:_wmplayer ]&&self.isSmallScreen) {
            self.isSmallScreen=YES;
        }
        else{
            [self toSmallPlay];
            // [self releaseVideo];
        }
    }
    else{
        if ([self.imageView.subviews containsObject:_wmplayer]) {
            
        }
        else{
            if(self.isSmallScreen){
                [self toCellPlay];
            }
            
            
        }
    }
    
}
-(NSInteger)SCX_numberOfSectionsInTableView:(UITableView *)tableView{
    if (self.topDataArray.count) {
        return 3;
    }
    return  2;
}
-(SCXBaseTableViewCell *)SCX_tableViewCellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        
        // 1. 创建cell
        SCXHomeTableViewCell *cell = [SCXHomeTableViewCell cellWithTableView:self.tableView];
        
        // 2. 设置数据
        [cell setCellFrame:self.cellFrame isDetail:YES];
        cell.delegate = self;
        
        // 3. 返回cell
        return cell;
    }
    
    // 三个section
    SCXDetailTableViewCell *cell = [SCXDetailTableViewCell cellWithTableView:self.tableView];
    cell.delegate = self;
    if (self.topDataArray.count) {
        if (indexPath.section == 1) {
            cell.cellFrame = self.topCommentCellFrameArray[indexPath.row];
        } else {
            cell.cellFrame = self.commentCellFrameArray[indexPath.row];
        }
    } else {
        if (indexPath.section == 1) {
            cell.cellFrame = self.commentCellFrameArray[indexPath.row];
        }
    }
    return cell;
}
-(CGFloat)SCX_tableViewHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return self.cellFrame.cellHeight;
    }
    if (self.topDataArray.count) {
        if (indexPath.section == 1) {
            SCXDetailCellFrame *cellFrame = self.topCommentCellFrameArray[indexPath.row];
            return cellFrame.cellHeight;
        } else if (indexPath.section == 2) {
            SCXDetailCellFrame *cellFrame = self.commentCellFrameArray[indexPath.row];
            return cellFrame.cellHeight;
        }
    } else {
        if (indexPath.section == 1) {
            SCXDetailCellFrame *cellFrame = self.commentCellFrameArray[indexPath.row];
            return cellFrame.cellHeight;
        }
    }
    return 0;
}
-(NSInteger)SCX_tableViewNumberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }
    if (self.topDataArray.count) {
        if (section == 1) {
            return self.topDataArray.count;
        } else if (section == 2) {
            return self.dataArray.count;
        }
    } else {
        if (section == 1) {
            return self.dataArray.count;
        }
    }
    return 0;
}

-(CGFloat)SCX_tableViewHeightForHeaderInSection:(NSInteger)section{
    if (section==0) {
        return 0.01;
    }
    return 40;
}
-(UIView *)SCX_tableViewViewForHeaderInSection:(NSInteger)section{
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 40)];
    if (self.topDataArray.count) {
        if (section == 1) {
            label.text = @"热门评论";
        } else if (section == 2) {
            label.text = @"新鲜评论";
        }
    } else {
        if (section == 1) {
            label.text = @"新鲜评论";
        }
    }
    [label setTextColor:kCommonHighLightRedColor];
    [label setBackgroundColor:[UIColor whiteColor]];
    return label;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(NSMutableArray *)topDataArray{

    if (!_topDataArray) {
        _topDataArray=[[NSMutableArray alloc]initWithCapacity:0];
    }
    return _topDataArray;
}
-(NSMutableArray *)commentCellFrameArray{
    if (!_commentCellFrameArray) {
        _commentCellFrameArray=[[NSMutableArray alloc]initWithCapacity:0];
    }
    return _commentCellFrameArray;

}
-(NSMutableArray *)topCommentCellFrameArray{

    if (!_topCommentCellFrameArray) {
        _topCommentCellFrameArray=[[NSMutableArray alloc]initWithCapacity:0];
    }
    return _topCommentCellFrameArray;
}
-(void)detailTableViewCell:(SCXDetailTableViewCell *)cell didClickLikeButton:(SCXHomeCommentModel *)commentModel{
    
}
-(void)detailTableViewCell:(SCXDetailTableViewCell *)cell didClickShareButton:(SCXHomeCommentModel *)commentModel{

}
-(void)detailTableViewCell:(SCXDetailTableViewCell *)cell didClickReplayButton:(SCXHomeCommentModel *)commentModel{

}
-(void)detailTableViewCell:(SCXDetailTableViewCell *)cell didClickUserNameButton:(SCXHomeCommentModel *)commentModel{
    SCXPersonalZoneViewController *person=[[SCXPersonalZoneViewController alloc]initWIthUserID:commentModel.user_id];
    [self pushViewController:person];
}
#pragma mark--点击个人头像
-(void)homeTableViewCellDidClickIconImage:(SCXHomeTableViewCell *)cell andUserModel:(SCXUserInfoModel *)userModel{
    SCXPersonalZoneViewController *person=[[SCXPersonalZoneViewController alloc]initWithUserModel:userModel];
    [self pushViewController:person];

}
#pragma mark--点击查看小图
-(void)homeTableViewCell:(SCXHomeTableViewCell *)homeCEll withImageView:(SCXBaseImageView *)imageView currentIndex:(NSInteger)index urls:(NSArray *)urls{
    MJPhotoBrowser *browser=[[MJPhotoBrowser alloc]init];
    NSMutableArray *arr=[NSMutableArray array];
    for (NSURL *url in urls) {
        MJPhoto *photo=[[MJPhoto alloc]init];
        photo.url=url;
        photo.srcImageView=imageView;
        [arr addObject:photo];
    }
    browser.photos=arr;
    browser.currentPhotoIndex=index;
    [browser show];
}
#pragma mark--点击播放视频
-(void)homeTableViewCell:(SCXHomeTableViewCell *)homeCEll withVideoUrl:(NSString *)videoUrl withVideoImageView:(SCXBaseImageView *)videoImageVideo{
    self.indexPath=[self.tableView indexPathForCell:homeCEll];
    self.imageView=videoImageVideo;
    self.wmplayer=[[WMPlayer alloc] initWithFrame:videoImageVideo.bounds];
    self.wmplayer.delegate=self;
    self.wmplayer.closeBtnStyle=CloseBtnStylePop;
    self.wmplayer.URLString=videoUrl;
    [videoImageVideo addSubview:self.wmplayer];
    [self.wmplayer play];
}
#pragma mark--点击赞，踩，评论或分享
-(void)SCXHomeTableViewCell:(SCXHomeTableViewCell *)cell didClickItemtype:(SCXHomeCellDidClickItemType)type{
    NSIndexPath *indexPath=[self.tableView indexPathForCell:cell];
    SCXHomeTableViewCellFrame *cellFrame=self.cellFrame;
    WeakSelf(weakSelf);
    switch (type) {
        case SCXHomeCellDidClickItemTypeLIke: {
            [self goToRequestWithActionName:@"digg" andActionindexPath:indexPath];
        } break;
            
        case SCXHomeCellDidClickItemTypeDontLike: {
            
            [self goToRequestWithActionName:@"bury" andActionindexPath:indexPath];
        } break;
            
        case SCXHomeCellDidClickItemTypeComment:
            
            break;
            
        case SCXHomeCellDidClickItemTypeShare: {
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
            
        default:
            break;
    }

}
-(void)goToRequestWithActionName:(NSString *)actionName andActionindexPath:(NSIndexPath *)indexPath{
    SCXHomeTableViewCell *cell=[self.tableView cellForRowAtIndexPath:indexPath];
    SCXHomeTableViewCellFrame *cellFrame=self.cellFrame;
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
        _wmplayer.isFullscreen=YES;
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
    [_wmplayer play];
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
    [_wmplayer removeFromSuperview];
    _wmplayer.transform=CGAffineTransformIdentity;
    if (orientation==UIInterfaceOrientationLandscapeLeft) {
        _wmplayer.transform=CGAffineTransformMakeRotation(-M_PI_2);
    }
    else if (orientation==UIInterfaceOrientationLandscapeRight){
        _wmplayer.transform=CGAffineTransformMakeRotation(M_PI_2);
        
    }
    _wmplayer.frame=CGRectMake(0, 0, ScreenWidth, ScreenHeight);
    //_wmplayer.playerLayer.frame=CGRectMake(0, 0, ScreenHeight, ScreenWidth);
    [_wmplayer.bottomView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(40);
        make.top.mas_equalTo(ScreenWidth-40);
        make.width.mas_equalTo(ScreenHeight);
    }];
    [_wmplayer.topView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(40);
        make.width.mas_equalTo(ScreenHeight);
        make.left.equalTo(_wmplayer).offset(0);
    }];
    [_wmplayer.closeBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_wmplayer).with.offset((-ScreenHeight/2));
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(30);
        make.top.equalTo(_wmplayer).with.offset(5);
        
    }];
    [_wmplayer.titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_wmplayer.topView).with.offset(45);
        make.right.equalTo(_wmplayer.topView).with.offset(-45);
        make.center.equalTo(_wmplayer.topView);
        make.top.equalTo(_wmplayer.topView).with.offset(0);
    }];
    [_wmplayer.loadFailedLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(ScreenHeight);
        make.center.mas_equalTo(CGPointMake(ScreenWidth/2-36, -(ScreenWidth/2)));
        make.height.equalTo(@30);
    }];
    [_wmplayer.loadingView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(CGPointMake(ScreenWidth/2-37, -(ScreenWidth/2-37)));
    }];
    [_wmplayer.loadFailedLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(ScreenHeight);
        make.center.mas_equalTo(CGPointMake(ScreenWidth/2-36, -(ScreenWidth/2)+36));
        make.height.equalTo(@30);
    }];
    [[UIApplication sharedApplication].keyWindow addSubview:_wmplayer];
    _wmplayer.fullScreenBtn.selected=YES;
    [_wmplayer bringSubviewToFront:_wmplayer.bottomView];
    
}
-(void)toCellPlay{
    
    [_wmplayer removeFromSuperview];
    [UIView animateWithDuration:0.25 animations:^{
        [_wmplayer pause];
        _wmplayer.transform=CGAffineTransformIdentity;
        _wmplayer.frame=self.imageView.bounds;
        [self.imageView addSubview:_wmplayer];
        [self.imageView bringSubviewToFront:_wmplayer];
        [_wmplayer.bottomView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_wmplayer).with.offset(0);
            make.right.equalTo(_wmplayer).with.offset(0);
            make.height.mas_equalTo(40);
            make.bottom.equalTo(_wmplayer).with.offset(0);
        }];
        [_wmplayer.topView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_wmplayer).with.offset(0);
            make.right.equalTo(_wmplayer).with.offset(0);
            make.height.mas_equalTo(40);
            make.top.equalTo(_wmplayer).with.offset(0);
        }];
        [_wmplayer.titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_wmplayer.topView).with.offset(45);
            make.right.equalTo(_wmplayer.topView).with.offset(-45);
            make.center.equalTo(_wmplayer.topView);
            make.top.equalTo(_wmplayer.topView).with.offset(0);
        }];
        [_wmplayer.closeBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_wmplayer).with.offset(5);
            make.height.mas_equalTo(30);
            make.width.mas_equalTo(30);
            make.top.equalTo(_wmplayer).with.offset(5);
        }];
        [_wmplayer.loadFailedLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(_wmplayer);
            make.width.equalTo(_wmplayer);
            make.height.equalTo(@30);
        }];
        _wmplayer.isFullscreen = NO;
        [self setNeedsStatusBarAppearanceUpdate];
        self.isSmallScreen = NO;
        _wmplayer.fullScreenBtn.selected = NO;
        [_wmplayer play];
    }];
    
}
#pragma mark--小屏播放
-(void)toSmallPlay{
    
    [_wmplayer removeFromSuperview];
    [UIView animateWithDuration:0.25 animations:^{
        _wmplayer.transform=CGAffineTransformIdentity;
        _wmplayer.frame=CGRectMake(ScreenWidth-ScreenWidth/2, 64, ScreenWidth/2, (ScreenWidth/2)*0.75);
        
        [_wmplayer.bottomView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_wmplayer).with.offset(0);
            make.right.equalTo(_wmplayer).with.offset(0);
            make.height.mas_equalTo(40);
            make.bottom.equalTo(_wmplayer).with.offset(0);
        }];
        [_wmplayer.topView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_wmplayer).with.offset(0);
            make.right.equalTo(_wmplayer).with.offset(0);
            make.height.mas_equalTo(40);
            make.top.equalTo(_wmplayer).with.offset(0);
        }];
        [_wmplayer.titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_wmplayer.topView).with.offset(45);
            make.right.equalTo(_wmplayer.topView).with.offset(-45);
            make.center.equalTo(_wmplayer.topView);
            make.top.equalTo(_wmplayer.topView).with.offset(0);
        }];
        [_wmplayer.closeBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_wmplayer).with.offset(5);
            make.height.mas_equalTo(30);
            make.width.mas_equalTo(30);
            make.top.equalTo(_wmplayer).with.offset(5);
            
        }];
        [_wmplayer.loadFailedLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(_wmplayer);
            make.width.equalTo(_wmplayer);
            make.height.equalTo(@30);
        }];
        [[UIApplication sharedApplication].keyWindow addSubview:_wmplayer];
        [[UIApplication sharedApplication].keyWindow bringSubviewToFront:_wmplayer];
        
    } completion:^(BOOL finished) {
        self.isSmallScreen=YES;
        _wmplayer.isFullscreen=NSNotFound;
    }];
    
}
#pragma mark--释放视频
-(void)releaseVideo{
    
    [_wmplayer pause];
    [_wmplayer removeFromSuperview];
    [_wmplayer.playerLayer removeFromSuperlayer];
    [_wmplayer.player replaceCurrentItemWithPlayerItem:nil];
    _wmplayer.player=nil;
    _wmplayer.currentItem=nil;
    [_wmplayer.autoDismissTimer invalidate];
    _wmplayer.autoDismissTimer=nil;
    _wmplayer.playOrPauseBtn=nil;
    _wmplayer.playerLayer=nil;
    _wmplayer=nil;
}


@end
