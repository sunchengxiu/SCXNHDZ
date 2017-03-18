//
//  SCXCheckController.m
//  仿内涵段子
//
//  Created by 孙承秀 on 16/9/20.
//  Copyright © 2016年 孙先森丶. All rights reserved.
//

#import "SCXCheckController.h"

@implementation SCXCheckController
-(void)viewDidLoad{
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    self.navigationItem.title=@"审核";
    [self addPanGestureRecognizer];
    [self setUpRightItem];
    [self loadData];
}
-(void)addPanGestureRecognizer{
    UIPanGestureRecognizer *pan=[[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panHandle:)];
    pan.delegate=self;
    [self.view addGestureRecognizer:pan];
}
//当前手势滑动的距离
int currentFloat=0;
-(void)panHandle:(UIPanGestureRecognizer *)pan{
    //滑到最后一张了
    if (self.preOffset.x+ScreenWidth==self.collectionView.contentSize.width) {
        return;
    }
    if (pan.state==UIGestureRecognizerStateBegan||pan.state==UIGestureRecognizerStateChanged) {
        CGPoint currentPoint=[pan translationInView:self.view];
        if (currentPoint.x<0) {
            currentFloat+=(-currentPoint.x);
            if (currentFloat>100) {
                if (self.collectionView.contentOffset.x-self.preOffset.x==ScreenWidth) {
                    return;
                }
                CGPoint offset=self.preOffset;
                offset.x+=ScreenWidth;
                [self.collectionView setContentOffset:offset];
            }
        }
        [pan setTranslation:CGPointZero inView:self.view];
    }
    else if(pan.state==UIGestureRecognizerStateEnded    ){
        currentFloat=0;
        self.preOffset=self.collectionView.contentOffset;
    }

}
-(void)setUpRightItem{
    // 投稿
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"submission"] style:UIBarButtonItemStylePlain target:self action:@selector(rightItemClick)];
}
-(void)rightItemClick{

}
// 请求数据
- (void)loadData {
    SCXCheckRequest *request = [SCXCheckRequest SCX_Request];
    request.SCX_url = kNHCheckDynamicListAPI;
    [request SCX_sendRequestWithComplement:^(id response, BOOL success, NSString *message) {
        if (success) {
            // 当滑动到一定距离之后，需要重新请求数据，清掉一部分内存，重置所有条件
            [self.dataArray removeAllObjects];
            [self.cellFrameArray removeAllObjects];
            for (int i = 0; i < self.dataArray.count; i++) {
                [self.collectionView deleteItemsAtIndexPaths:@[[NSIndexPath indexPathForRow:i inSection:0]]];
            }
            self.collectionView.contentOffset = CGPointZero;
            self.preOffset = CGPointZero;
            
            // 模型数组
            NSArray *newArray = [SCXHomeAllModel objectArrayWithKeyValuesArray:response];
            [self.dataArray addObjectsFromArray:newArray];
            // frame数组
            for (SCXHomeAllModel *element in newArray) {
                SCXCheckCellFrame *cellFrame = [[SCXCheckCellFrame alloc] init];
                cellFrame.model = element;
                [self.cellFrameArray addObject:cellFrame];
            }
            [self.collectionView reloadData];
        }
    }];
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat offset=scrollView.contentOffset.x;
    NSInteger index=offset/ScreenWidth;
    if (index==self.dataArray.count-1) {
        [self loadData];
    }
}
#pragma mark--懒加载
-(UICollectionView *)collectionView{
    if (_collectionView==nil) {
       // RFLayout *layout=[[RFLayout alloc]init];
        UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc]init];
        
        layout.scrollDirection=UICollectionViewScrollDirectionHorizontal;
        _collectionView=[[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width-0, self.view.frame.size.height-0) collectionViewLayout:layout];
        _collectionView.delegate=self;
        _collectionView.dataSource=self;
        _collectionView.pagingEnabled=YES;
        _collectionView.showsVerticalScrollIndicator=NO;
        _collectionView.showsHorizontalScrollIndicator=NO;
        _collectionView.bounces=NO;
        _collectionView.scrollEnabled=NO;
        [_collectionView registerClass:[SCXCheckTableViewCell class] forCellWithReuseIdentifier:@"cellID"];
        [self.view addSubview:_collectionView];
    }
    return _collectionView;

}
//-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
//
//
//}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
   
    SCXCheckTableViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"cellID" forIndexPath:indexPath];
    cell.cellFrame=self.cellFrameArray[indexPath.row];
    cell.delegate=self;
    return cell;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataArray.count;
}


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{


}
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;

}
-(void)checkTableViewCell:(SCXCheckTableViewCell *)cell didClickReport:(BOOL)didClickReport{

}
-(void)checkTableViewCell:(SCXCheckTableViewCell *)cell didClickImageView:(UIImageView *)imageView currentIndex:(NSInteger)currentIndex urls:(NSArray<NSURL *> *)urls{
    MJPhotoBrowser *brower=[[MJPhotoBrowser alloc]init
    ];
    NSMutableArray *arr=[NSMutableArray array];
    for (NSURL *url in urls) {
        MJPhoto *photo=({
            MJPhoto *pt=[[MJPhoto alloc]init];
            pt.url=url;
            pt.srcImageView=imageView;
            pt;
        });
        [arr addObject:photo];
    }
    brower.photos=arr;
    brower.currentPhotoIndex=currentIndex;
    [brower show];
    
}
-(void)checkTableViewCell:(SCXCheckTableViewCell *)cell didFinishLoadingHandleWithLikeFlag:(BOOL)likeFlag{
    [self slide];
}
-(void)slide{
    if (self.collectionView.contentOffset.x-self.preOffset.x==ScreenWidth) {
        return;
    }
    CGPoint offset=self.preOffset;
    offset.x+=ScreenWidth;
    self.preOffset=offset;
    [self.collectionView setContentOffset:offset];
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    SCXCheckCellFrame *cellFrame=self.cellFrameArray[indexPath.row];
    return CGSizeMake(ScreenWidth, cellFrame.cellHeight);
   // return CGSizeMake(250   , 350);

}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 0;

}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 0;

}
//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
//
//}
//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
//
//}

-(NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray=[[NSMutableArray alloc]initWithCapacity:0];
    }
    return _dataArray;
}
-(NSMutableArray *)cellFrameArray{
    if (!_cellFrameArray) {
        _cellFrameArray=[[NSMutableArray alloc]initWithCapacity:0];
    }
    return _cellFrameArray;
}
@end
