//
//  TableViewCell.m
//  仿内涵段子
//
//  Created by 孙承秀 on 16/10/5.
//  Copyright © 2016年 孙先森丶. All rights reserved.
//

#import "TableViewCell.h"

@implementation TableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
/*
 #pragma mark--懒加载
 
 -(UIImageView *)essenceImageView{
 if (_essenceImageView==nil) {
 _essenceImageView=[[UIImageView alloc]init];
 }
 return _essenceImageView;
 
 }
 -(UIButton *)essenceButton{
 if (_essenceButton==nil) {
 _essenceButton=[[UIButton alloc]init];
 }
 return _essenceButton;
 
 }
 -(UIView *)bottomView{
 if (_bottomView==nil) {
 _bottomView=[[UIView alloc]init];
 _bottomView.backgroundColor = [UIColor colorWithRed:0.93f green:0.93f blue:0.93f alpha:1.00f];
 }
 return _bottomView;
 
 }
 -(UILabel *)hotLabel{
 if (_hotLabel==nil) {
 _hotLabel=[[UILabel alloc]init];
 }
 return _hotLabel;
 
 }
 -(SCXBaseImageView *)iconImageView{
 if (_iconImageView==nil) {
 _iconImageView=[[SCXBaseImageView alloc]init];
 }
 return _iconImageView;
 
 }
 -(UILabel *)nameLabel{
 if (_nameLabel==nil) {
 _nameLabel=[[UILabel alloc]init];
 }
 return _nameLabel;
 
 }
 -(UIButton *)versionButton{
 if (_versionButton==nil) {
 _versionButton=[[UIButton alloc]init];
 }
 return _versionButton;
 
 }
 -(UILabel *)contentLabel{
 if (_contentLabel==nil) {
 _contentLabel=[[UILabel alloc]init];
 }
 return _contentLabel;
 
 }
 -(SCXBaseImageView *)largeImageView{
 if (_largeImageView==nil) {
 _largeImageView=[[SCXBaseImageView alloc]init];
 }
 return _largeImageView;
 
 }
 -(SCXCustomGIFImageView *)GIFImageView{
 if (_GIFImageView==nil) {
 _GIFImageView=[[SCXCustomGIFImageView alloc]init];
 
 }
 return _GIFImageView;
 }
 -(SCXCustomVideoImageView *)videoImageView{
 if (!_videoImageView) {
 _videoImageView=[[SCXCustomVideoImageView alloc]init];
 
 }
 return _videoImageView;
 
 }
 -(UIButton *)likeButton{
 if (!_likeButton) {
 _likeButton=[[UIButton alloc]init];
 }
 return _likeButton;
 }
 -(SCXBaseImageView *)closeImageView{
 if (_closeImageView==nil) {
 _closeImageView=[[SCXBaseImageView alloc]init];
 }
 return _closeImageView;
 
 }
 -(UIButton *)supportButton{
 if (_supportButton==nil) {
 _supportButton=[[UIButton alloc]init];
 }
 return _supportButton;
 
 }
 
 -(UIButton *)dontLikebutton{
 if (_dontLikebutton==nil) {
 _dontLikebutton=[[UIButton alloc]init];
 }
 return _dontLikebutton;
 
 }
 -(UIButton *)shareButton{
 if (_shareButton==nil) {
 _shareButton=[[UIButton alloc]init];
 }
 return _shareButton;
 
 }
 -(UIButton *)commentButton{
 if (_commentButton==nil) {
 _commentButton=[[UIButton alloc]init];
 }
 return _commentButton;
 
 }
 -(UIView *)bottomLineView{
 if (!_bottomLineView) {
 _bottomLineView=[[UIView alloc]init];
 }
 return _bottomLineView;
 
 }
 -(void)configFrameWithModel1:(SCXHomeAllModel *)model{
 [self configFrameWithModel:model];
 }
 #pragma mark--配置cellFrame
 -(void)configFrameWithModel:(SCXHomeAllModel *)model{
 
 if (model==nil) {
 return;
 }
 SCXHomeGroupModel *group=model.group;
 if (group==nil) {
 return;
 }
 /**
 *  精华
 */

/*
 if (group.mediaType==5) {
 [self.contentView addSubview:self.essenceImageView];
 [self.contentView addSubview:self.essenceButton];
 [self.contentView addSubview:self.bottomView];
 [self.essenceImageView mas_makeConstraints:^(MASConstraintMaker *make) {
 make.left.mas_equalTo(self.contentView.mas_left).offset(20);
 make.top.mas_equalTo(self.contentView.mas_top).offset(10);
 make.width.mas_equalTo(ScreenWidth-20*2);
 CGFloat height=(ScreenWidth-20*2)*(group.large_image.height/group.large_image.width);
 make.height.mas_equalTo(height);
 }];
 [self.essenceButton mas_makeConstraints:^(MASConstraintMaker *make) {
 make.left.mas_equalTo(self.contentView);
 make.top.mas_equalTo(_essenceImageView.mas_bottom).offset(10);
 make.height.mas_equalTo(20);
 make.width.mas_equalTo(ScreenWidth);
 }];
 [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
 make.left.mas_equalTo(_essenceButton);
 make.top.mas_equalTo(_essenceButton.mas_bottom).offset(15);
 make.width.mas_equalTo(ScreenWidth);
 make.height.mas_equalTo(10);
 }];
 [_essenceImageView setBackgroundColor:[UIColor redColor]];
 [_essenceButton setBackgroundColor:[UIColor blueColor]];
 [_bottomView setBackgroundColor:[UIColor greenColor]];
 }
 
 if ([group.status_desc containsString:@"热门"]!=NSNotFound    ) {
 [self.contentView addSubview:self.hotLabel];
 [self.hotLabel setText:NSLocalizedString(@"hot", nil)];
 [self.hotLabel setFont:[UIFont systemFontOfSize:10]];
 self.hotLabel.numberOfLines=0;
 [self.hotLabel mas_makeConstraints:^(MASConstraintMaker *make) {
 make.left.mas_equalTo(self.contentView).offset(0);
 make.top.mas_equalTo(self.contentView).offset(20);
 make.width.mas_equalTo(15);
 make.height.mas_equalTo(30);
 }];
 }
 else{
 [self.hotLabel removeFromSuperview];
 self.hotLabel=nil;
 }
 
 [self.contentView addSubview:self.iconImageView];
 [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
 make.left.mas_equalTo(self.contentView).offset(20);
 make.top.mas_equalTo(self.contentView).offset(15);
 make.width.mas_equalTo(40);
 make.height.mas_equalTo(40);
 }];
 self.iconImageView.layer.cornerRadius=20;
 if (self.iconImageView) {
 [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:group.user.avatar_url]];
 }
 
 [self.contentView addSubview:self.nameLabel];
 [self.nameLabel setFont:[UIFont systemFontOfSize:14]];
 [self.nameLabel setTextColor:[UIColor blackColor]];
 [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
 make.left.mas_equalTo(self.iconImageView.mas_right).offset(10);
 make.height.mas_equalTo(15);
 make.top.mas_equalTo(self.iconImageView.mas_top).offset(25/2);
 make.right.mas_equalTo(self.contentView.mas_right).offset(-40);
 }];
 self.nameLabel.text=group.user.name;
 
 /*
 [self.contentView addSubview:self.contentLabel];
 self.contentLabel.numberOfLines=0;
 [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
 make.left.mas_equalTo(self.iconImageView).offset(17);
 make.top.mas_equalTo(self.iconImageView.mas_bottom).offset(10);
 make.width.mas_equalTo(ScreenWidth-32);
 }];
 /**
 *  内容
 */
/*
 self.contentLabel.attributedText=[SCXUtils attributeStringWithString:group.content withKeyWord:nil];
 */
/**
 *  分类
 */
/*
 [self.contentView addSubview:self.versionButton];
 [self.versionButton setTitleColor:[UIColor colorWithRed:0.42f green:0.33f blue:0.27f alpha:1.00f] forState:UIControlStateNormal];
 self.versionButton.titleLabel.font = [UIFont systemFontOfSize:14];
 [self.versionButton addTarget:self action:@selector(versionBtnClick:) forControlEvents:UIControlEventTouchUpInside];
 self.versionButton.layer.borderColor = [UIColor colorWithRed:0.42f green:0.33f blue:0.27f alpha:1.00f].CGColor;
 self.versionButton.layer.borderWidth = 1;
 self.versionButton.layer.cornerRadius = 10.0;
 [self.versionButton setTitle:group.category_name forState:UIControlStateNormal];
 [self.versionButton mas_makeConstraints:^(MASConstraintMaker *make) {
 make.left.mas_equalTo(self.contentView).offset(15);
 make.top.mas_equalTo(self.contentLabel.mas_bottom).offset(10);
 make.height.mas_equalTo(20);
 
 }];
 [self.contentView setNeedsUpdateConstraints];
 [self.contentView updateConstraintsIfNeeded];
 [UIView animateWithDuration:0.2 animations:^{
 [self.contentView layoutIfNeeded];
 } completion:^(BOOL finished) {
 
 }];
 [self.contentView addSubview:self.supportButton];
 [self.supportButton mas_updateConstraints:^(MASConstraintMaker *make) {
 make.left.mas_equalTo(self.contentView).offset(20);
 make.width.mas_equalTo((ScreenWidth-20)/5.0);
 make.height.mas_equalTo(35);
 make.top.mas_equalTo(self.versionButton.mas_bottom).offset(10);
 }];
 _lastPoint=self.versionButton.frame.size.height+self.versionButton.frame.origin.y+10;
 NSLog(@"~~~~~~~%ld",group.mediaType);
 switch (group.mediaType) {
 case SCXGroupMediaTypeImage:{
 [self.contentView addSubview:self.largeImageView];
 [self.largeImageView setBackgroundColor:[UIColor orangeColor]];
 [self.largeImageView mas_makeConstraints:^(MASConstraintMaker *make) {
 make.left.mas_equalTo(self.contentView).offset(20);
 make.top.mas_equalTo(self.versionButton.mas_bottom).offset(10);
 make.width.mas_equalTo(ScreenWidth-20*2);
 CGFloat height=(ScreenWidth-20*2)*(group.large_image.height/group.large_image.width);
 make.height.mas_equalTo(height);
 }];
 
 
 SCXElementGroupLargeImageUrl *url=group.large_image.url_list[0];
 NSString *URL=url.url;
 [self.largeImageView setImageWithUrl:URL];
 }
 break;
 case SCXGroupMediaTypeGIF:{
 [self.contentView addSubview:self.GIFImageView];
 [self.GIFImageView setBackgroundColor:[UIColor grayColor]];
 [self.GIFImageView mas_makeConstraints:^(MASConstraintMaker *make) {
 make.left.mas_equalTo(self.contentView).offset(20);
 make.top.mas_equalTo(self.versionButton.mas_bottom).offset(10);
 make.width.mas_equalTo(ScreenWidth-20*2);
 CGFloat height=(ScreenWidth-20*2)*(group.large_image.height/group.large_image.width);
 make.height.mas_equalTo(height);
 
 }];
 
 
 SCXElementGroupLargeImageUrl *GifModel=group.large_image.url_list[0];
 __block typeof(self)weakSelf=self;
 [self.GIFImageView setImageWithURL:[NSURL URLWithString:GifModel.url] placeHolder:nil finishHandle:^(bool finish, UIImage *image) {
 
 } progressHandle:^(CGFloat progress) {
 [weakSelf.GIFImageView setProgress:progress];
 }];
 }
 break;
 case SCXGroupMediaTypeEssence:{
 
 }
 break;
 case SCXGroupMediaTypeLittleImages:{
 if (group.large_image_list.count) {
 for (int i=0; i<group.large_image_list.count; i++) {
 SCXBaseImageView *littleImageView=nil;
 SCXElementGroupLargeImage *littleModel=group.thumb_image_list[i];
 if (littleModel.is_gif) {
 littleImageView=[[SCXCustomGIFImageView alloc] init];
 }
 else{
 littleImageView=[[SCXBaseImageView alloc]init];
 }
 [self.contentView addSubview:littleImageView];
 littleImageView.tag=i;
 littleImageView.clipsToBounds=YES;
 littleImageView.contentMode=UIViewContentModeScaleAspectFill;
 littleImageView.userInteractionEnabled=YES;
 [littleImageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageTapGestureClick:)]];
 [littleImageView setImageWithUrl:littleModel.url];
 int col=i%3;
 int row=i/3;
 CGFloat margin=15.0;
 CGFloat width=(ScreenWidth-15*4)/3.0;
 CGFloat height=width;
 CGFloat imageX=margin*(col+1)+col*width;
 CGFloat imageY=margin*(row+1)+row*(width);
 [littleImageView mas_makeConstraints:^(MASConstraintMaker *make) {
 make.left.mas_equalTo(self.contentView).offset(imageX);
 make.top.mas_equalTo(self.versionButton.mas_bottom).offset(imageY);
 make.width.mas_equalTo(width);
 make.height.mas_equalTo(height);
 }];
 
 
 
 }
 }
 }break;
 case SCXGroupMediaTypeVideo:{
 [self.contentView addSubview:self.videoImageView];
 [self.videoImageView setBackgroundColor:[UIColor redColor]];
 [self.videoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
 make.left.mas_equalTo(self.contentView).offset(20);
 make.top.mas_equalTo(self.versionButton.mas_bottom).offset(10);
 make.width.mas_equalTo(ScreenWidth-20*2);
 CGFloat height=(ScreenWidth-20*2)*(group.video_720P.height/group.video_720P.width);
 make.height.mas_equalTo(height);
 }];
 
 
 SCXElementGroupLargeImageUrl *videoModel=group.video_720P.url_list[0];
 [self.videoImageView setImageWithUrl:videoModel.url];
 }break;
 
 default:
 break;
 }
 
 /**
 *  是否是详情页，详情页有关注按钮
 */
/*
 if (_isDetail) {
 self.likeButton.hidden=NO;
 [self.contentView addSubview:self.likeButton];
 [self.likeButton mas_makeConstraints:^(MASConstraintMaker *make) {
 make.left.mas_equalTo(self.contentView).offset(ScreenWidth-40-15);
 make.top.mas_equalTo(self.contentView).offset(15);
 make.width.mas_equalTo(50);
 make.height.mas_equalTo(28);
 }];
 }
 else{
 
 self.likeButton.hidden=YES;
 }
 /**
 *  关闭按钮
 */
/*
 if (self.isFromHomeController) {
 [self.contentView addSubview:self.closeImageView];
 self.closeImageView.hidden=NO;
 [self.closeImageView mas_makeConstraints:^(MASConstraintMaker *make) {
 make.left.mas_equalTo(ScreenWidth-30);
 make.top.mas_equalTo(self.contentView).offset(0);
 make.width.mas_equalTo(30);
 make.height.mas_equalTo(30);
 }];
 }
 else{
 self.closeImageView.hidden=YES;
 }
 
 /**
 *  评论
 */
/*
 UIView *view=nil;
 
 if (model.comments.count) {
 
 self.lastCommentView=nil;
 model.comments.count
 /*
 SCXCommentView *commentView=[[SCXCommentView alloc]init];
 [commentView setBackgroundColor:[UIColor blueColor]];
 commentView.commentModel=commentModel;
 self.lastCommentView=commentView;
 [commentView layoutIfNeeded];
 CGFloat height=commentView.contentL.frame.size.height+commentView.contentL.frame.origin.y;
 commentView.tag=100+i;
 [commentView layoutIfNeeded];
 UIView *view1=[[UIView alloc]init];
 self.lastView=[[UIView alloc]init];
 self.lastView=view1;
 [self.contentView addSubview:self.lastView];
 
 [view1 addSubview:commentView];
 [self.lastView setBackgroundColor:[UIColor purpleColor]];
 [self.lastView mas_makeConstraints:^(MASConstraintMaker *make) {
 make.left.mas_equalTo(self.contentView).offset(15);
 make.right.mas_equalTo(self.contentView.mas_right).offset(-15);
 if (view==nil) {
 make.top.mas_equalTo(self).offset(_lastPoint);
 }
 else{
 make.top.mas_equalTo(self ).offset(_lastPoint);
 
 }
 make.height.mas_equalTo(height);
 make.bottom.mas_equalTo(commentView.contentL.mas_bottom);
 make.width.mas_equalTo(ScreenWidth-30);
 }];
 
 [commentView mas_makeConstraints:^(MASConstraintMaker *make) {
 make.left.mas_equalTo(view1).offset(15);
 
 if (view==nil) {
 make.top.mas_equalTo(view1.mas_top).offset(10);
 }
 else{
 make.top.mas_equalTo(view.mas_bottom   ).offset(10);
 
 }
 // make.height.mas_equalTo(200);
 make.right.mas_equalTo(view1.mas_right).offset(-15);
 make.width.mas_equalTo(ScreenWidth-30);
 }];
 [self.lastView layoutIfNeeded];
 [self layoutIfNeeded];
 NSLog(@"~~~~%f",view1.frame.origin.y);
 NSLog(@"----%f",height);
 _lastPoint=self.lastView.frame.origin.y+10+height;
 view=commentView;
 
 */
/*
 model.comments.count
 int random=arc4random()%3+1;
 for (int i=0; i<model.comments.count; i++) {
 
 SCXHomeCommentModel *commentModel=model.comments[i];
 SCXCommentView *commentView=[[SCXCommentView alloc]init];
 commentView.commentModel=commentModel;
 [commentView layoutIfNeeded];
 CGFloat height=commentView.contentL.frame.size.height+commentView.contentL.frame.origin.y;
 commentView.tag=100+i;
 
 UIView *vv=[[UIView alloc]init];
 [vv setBackgroundColor:[UIColor purpleColor]];
 [vv addSubview:commentView];
 [self.contentView addSubview:commentView];
 
 if (self.lastCommentView) {
 [commentView mas_makeConstraints:^(MASConstraintMaker *make) {
 make.top.mas_equalTo(self.lastCommentView.mas_bottom).offset(10);
 
 make.left.mas_equalTo(self).offset(15);
 make.right.mas_equalTo(self).offset(-15);
 make.height.mas_equalTo(height+40);
 }];
 }
 else{
 [commentView mas_makeConstraints:^(MASConstraintMaker *make) {
 make.top.mas_equalTo(self.versionButton.mas_bottom).offset(10);
 
 make.left.mas_equalTo(self).offset(15);
 make.right.mas_equalTo(self).offset(-15);
 make.height.mas_equalTo(height+40);
 }];
 }
 
 
 self.lastCommentView=commentView;
 view=vv;
 [self layoutIfNeeded];
 }
 
 }
 /**
 *  赞
 */
/*
 NSLog(@"~~~~%f",view1.frame.origin.y);
 NSLog(@"----%f",_lastPoint);
 [self layoutIfNeeded];
 
 
 [self.supportButton setTitle:[NSString stringWithFormat:@"%ld",group.digg_count] forState:UIControlStateNormal];
 [self.supportButton setImage:[UIImage imageNamed:group.user_digg ? @"digupicon_textpage_press" : @"digupicon_textpage"] forState:UIControlStateNormal];
 [self.supportButton setTitleColor:group.user_digg ? [UIColor colorWithRed:1.00f green:0.49f blue:0.65f alpha:1.00f] : [UIColor colorWithRed:0.63f green:0.63f blue:0.63f alpha:1.00f] forState:UIControlStateNormal];
 
 if (self.lastCommentView) {
 [self.supportButton mas_makeConstraints:^(MASConstraintMaker *make) {
 make.left.mas_equalTo(self.contentView).offset(20);
 make.width.mas_equalTo((ScreenWidth-20)/5.0);
 make.height.mas_equalTo(35);
 make.top.mas_equalTo(self.lastCommentView.mas_bottom).offset(10);
 make.top.mas_lessThanOrEqualTo(view.mas_bottom);
 }];
 }
 else{
 [self.supportButton mas_makeConstraints:^(MASConstraintMaker *make) {
 make.left.mas_equalTo(self.contentView).offset(20);
 make.width.mas_equalTo((ScreenWidth-20)/5.0);
 make.height.mas_equalTo(35);
 make.top.mas_equalTo(self.versionButton.mas_bottom).offset(10);
 }];
 
 }
 /**
 *  踩
 */
/*
 [self.contentView addSubview:self.dontLikebutton];
 [self.dontLikebutton mas_makeConstraints:^(MASConstraintMaker *make) {
 make.left.mas_equalTo(self.supportButton.mas_right).offset(5);
 make.top.mas_equalTo(self.supportButton.mas_top).offset(0);
 make.width.mas_equalTo(self.supportButton);
 make.height.mas_equalTo(self.supportButton);
 }];
 [self.dontLikebutton setImage:[UIImage imageNamed:group.user_bury ? @"digdownicon_textpage_press" : @"digdownicon_textpage"] forState:UIControlStateNormal];
 [self.dontLikebutton setTitleColor:group.user_bury ? [UIColor colorWithRed:1.00f green:0.49f blue:0.65f alpha:1.00f] : [UIColor colorWithRed:0.63f green:0.63f blue:0.63f alpha:1.00f]  forState:UIControlStateNormal];
 /**
 *  评论
 */
/*
 [self.contentView addSubview:self.commentButton];
 [self.commentButton mas_makeConstraints:^(MASConstraintMaker *make) {
 make.left.mas_equalTo(self.dontLikebutton.mas_right).offset(5);
 make.top.mas_equalTo(self.dontLikebutton);
 make.width.mas_equalTo(self.dontLikebutton);
 make.height.mas_equalTo(self.dontLikebutton);
 }];
 [self.commentButton setTitle:[NSString stringWithFormat:@"%ld",group.comment_count] forState:UIControlStateNormal];
 /**
 *  分享
 */
/*
 [self.contentView addSubview:self.shareButton];
 [self.shareButton mas_makeConstraints:^(MASConstraintMaker *make) {
 make.top.mas_equalTo(self.commentButton);
 make.right.mas_equalTo(self.contentView.mas_right).offset(-10);
 make.height.mas_equalTo(self.commentButton);
 make.left.mas_greaterThanOrEqualTo(self.commentButton.mas_right);
 }];
 
 [self.shareButton setTitle: [NSString stringWithFormat:@"%ld",group.share_count] forState:UIControlStateNormal];
 
 /**
 *  底部分割线视图
 */
/*
 [self.contentView addSubview:self.bottomLineView];
 [self.bottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
 make.left.mas_equalTo(self.contentView);
 make.top.mas_equalTo(self.supportButton.mas_bottom).offset(10);
 
 
 make.width.mas_equalTo(ScreenWidth);
 make.height.mas_equalTo(10);
 
 }];
 
 
 [self.contentView setNeedsUpdateConstraints];
 [self.contentView updateConstraintsIfNeeded];
 
 [self.contentView layoutIfNeeded];
 CGRect frame= self.frame;
 if (self.lastCommentView) {
 frame.size.height=self.lastCommentView.frame.size.height+self.lastCommentView.frame.origin.y+30;
 }
 else{
 frame.size.height=self.versionButton.frame.size.height+self.versionButton.frame.origin.y+30;
 }
 
 self.frame=frame;
 NSLog(@"~~~%f",self.frame.size.height);
 
 }
 
 #pragma mark--配置数据
 -(void)setData:(SCXHomeAllModel *)model{
 if (model==nil) {
 return;
 }
 SCXHomeGroupModel *group=model.group;
 if (group==nil) {
 return;
 }
 /**
 *  设置头像
 */
/*
 if (self.iconImageView) {
 [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:group.user.avatar_url]];
 }
 /**
 *  内容
 */
/*
 self.contentLabel.attributedText=[SCXUtils attributeStringWithString:group.content withKeyWord:nil];
 /**
 *  名字
 */
/*
 self.nameLabel.text=group.user.name;
 }
 #pragma mark--按钮点击事件
 /**
 *  分类按钮点击事件
 *
 *  @param button 分类按钮
 */
/*
 -(void)versionBtnClick:(UIButton *)button{
 
 
 }
 -(void)imageTapGestureClick:(UITapGestureRecognizer *)tap{
 
 
 }
 
 /**
 获取行高
 */
/*
 +(CGFloat)heightForRowWithTableView:(UITableView *)tableView andModel:(SCXHomeAllModel *)model{
 
 NSAttributedString * attributedText=[SCXUtils attributeStringWithString:model.group.content withKeyWord:nil];
 CGFloat attributeTextHeight=[attributedText heightWithConstrainedWidth:ScreenWidth-32 ];
 for (NSInteger i=0;i<model.comments.count ; i++) {
 SCXHomeCommentModel *commentmodel=model.comments[i];
 
 
 SCXHomeCommentModel *commentModel=model.comments[i];
 SCXCommentView *commentView=[[SCXCommentView alloc]init];
 commentView.commentModel=commentModel;
 [commentView layoutIfNeeded];
 CGFloat height=commentView.contentL.frame.size.height+commentView.contentL.frame.origin.y;
 attributeTextHeight=height+10+attributeTextHeight;
 NSLog(@"%f",attributeTextHeight);
 }
 150+attributeTextHeight+100
 return 500;
 }
 -(void)layoutSubviews{
 
 [super layoutSubviews];
 }
 */

@end
