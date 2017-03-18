//
//  SCXPersonalZoneViewController.m
//  仿内涵段子
//
//  Created by 孙承秀 on 16/10/9.
//  Copyright © 2016年 孙先森丶. All rights reserved.
//

#import "SCXPersonalZoneViewController.h"

@interface SCXPersonalZoneViewController ()

@end

@implementation SCXPersonalZoneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    self.navigationItem.title=@"个人中心";
    [self lodaData];
    // Do any additional setup after loading the view.
}
#pragma mark--初始化
-(instancetype)initWithUserModel:(SCXUserInfoModel *)userModel{
    if (self=[super init]) {
        self.userModel=userModel;
    }
    return self;
}
-(instancetype)initWIthUserID:(NSInteger)userID{
    if (self=[super init]) {
        self.userID=userID;
    }
    return self;
}
#pragma mark--加载数据
-(void)lodaData{
    self.contentView.userModel=self.userModel;
    SCXPersonalRequest *request=[SCXPersonalRequest SCX_Request];
    request.SCX_url=kPersonalUrl;
    request.user_id=self.userID?self.userID:self.userModel.user_id;
    [request SCX_sendRequestWithComplement:^(id responseObject, BOOL success, NSString *str) {
        if (success) {
            self.userModel=[SCXUserInfoModel modelWithDictionary:responseObject ];
            self.contentView.userModel=self.userModel;
        }
    }];
}
#pragma mark--懒加载
-(SCXPersonalView *)contentView{
    if (!_contentView) {
        _contentView=[[SCXPersonalView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 280)];
        self.tableView.tableHeaderView=_contentView;
        _contentView.delegate=self;
    }
    return _contentView;
}
-(NSMutableArray *)cellFrameArray{
    if (_cellFrameArray==nil) {
        _cellFrameArray=[[NSMutableArray alloc]initWithCapacity:0];
    }
    return _cellFrameArray;
}
-(void)setHeaderFooterType:(SCXPersonalHeaderFooterViewType)headerFooterType{
    _headerFooterType=headerFooterType;
    [self.dataArray removeAllObjects];
    [self.cellFrameArray removeAllObjects];
    [self.tableView reloadData];
    [self.tableView setContentOffset:CGPointZero animated:YES];
    NSString *url=nil;
    //投稿
    if (headerFooterType==SCXPersonalHeaderFooterViewTypePublish) {
        url=kNHUserPublishDraftListAPI;
    }
    //收藏
    else if (headerFooterType==SCXPersonalHeaderFooterViewTypeCol){
        url=kNHUserColDynamicListAPI;
    }
    //评论
    else if (headerFooterType==SCXPersonalHeaderFooterViewTypeComment){
        url = kNHUserDynamicCommentListAPI;
    }
    if (url) {
        SCXPersonalRequest *request=[SCXPersonalRequest SCX_Request];
        request.SCX_url=url;
        request.user_id=self.userModel.user_id?self.userModel.user_id:self.userID;
        [request SCX_sendRequestWithComplement:^(id responseObject, BOOL success, NSString *str) {
            if (success) {
                if (headerFooterType==SCXPersonalHeaderFooterViewTypeCol||headerFooterType==SCXPersonalHeaderFooterViewTypePublish) {
                    SCXHomeServerModel *serVerModel=[SCXHomeServerModel modelWithDictionary:responseObject];
                    for (SCXHomeAllModel *model in serVerModel.data) {
                        if (model.group) {
                            [self.dataArray addObject:model];
                            SCXHomeTableViewCellFrame *cellFrame=[[SCXHomeTableViewCellFrame alloc]init];
                            cellFrame.model=model;
                            [self.cellFrameArray addObject:cellFrame];
                        }
                    }
                    [self SCX_reloadData];
                }
                else if (headerFooterType==SCXPersonalHeaderFooterViewTypeComment){
                    for (NSDictionary *dic in responseObject[@"data"]) {
                        SCXHomeCommentModel *commentModel=[SCXHomeCommentModel modelWithDictionary:dic[@"comment"]];
                        if (commentModel) {
                            [self.dataArray addObject:commentModel];
                            SCXDetailCellFrame *cellFrame=[[SCXDetailCellFrame alloc]init];
                            cellFrame.commentModel=commentModel;
                            [self.cellFrameArray addObject:cellFrame];
                        }
                    }
                    [self SCX_reloadData];
                
                }
            }
        }];
    }

}
#pragma mark--tableView代理方法
-(NSInteger)SCX_numberOfSectionsInTableView:(UITableView *)tableView{
    
        return 1;
    
}
-(NSInteger)SCX_tableViewNumberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}
-(SCXBaseTableViewCell *)SCX_tableViewCellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.headerFooterType==SCXPersonalHeaderFooterViewTypeCol||self.headerFooterType==SCXPersonalHeaderFooterViewTypePublish) {
        SCXHomeTableViewCell *cell=[SCXHomeTableViewCell cellWithTableView:self.tableView];
        SCXHomeTableViewCellFrame *cellFrame=self.cellFrameArray[indexPath.row];
        cell.cellFrame=cellFrame;
        cell.delegate=self;
        return cell;
    }
    else{
        SCXDetailTableViewCell *cell=[SCXDetailTableViewCell cellWithTableView:self.tableView];
        SCXDetailCellFrame *cellFrame=self.cellFrameArray[indexPath.row];
        cell.cellFrame=cellFrame;
        
        return cell;
    }
}
-(UIView *)SCX_tableViewViewForHeaderInSection:(NSInteger)section{
    return self.headerFooterView;
}
-(CGFloat)SCX_tableViewHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.headerFooterType==SCXPersonalHeaderFooterViewTypePublish||self.headerFooterType==SCXPersonalHeaderFooterViewTypeCol) {
        SCXHomeTableViewCellFrame *cellFrame=self.cellFrameArray    [indexPath.row];
        return cellFrame.cellHeight;
    }
    else{
        SCXDetailCellFrame *cellFrame=self.cellFrameArray[indexPath.row];
        return cellFrame.cellHeight;
        
    }
    //return 0;
}
-(CGFloat)SCX_tableViewHeightForHeaderInSection:(NSInteger)section{
    return 40;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(SCXPersonalHeaderFooterView *)headerFooterView{
    if (!_headerFooterView) {
        _headerFooterView=[SCXPersonalHeaderFooterView headerFooterViewWithTableView:self.tableView];
        _headerFooterView.delegate=self;
        [_headerFooterView clickDefaultType];
    }
    return _headerFooterView;
}
#pragma mark--contentView代理方法
-(void)personalContentView:(SCXPersonalHeaderContentView *)contentView andButtonType:(SCXPersonalHeaderViewType)type{
    self.headerViewType=type;
}
#pragma mark--sectionHeader代理方法
-(void)personalHeaderFoooterView:(SCXPersonalHeaderFooterView *)headerView clickHeaderType:(SCXPersonalHeaderFooterViewType)type{
    self.headerFooterType=type;

}
@end
