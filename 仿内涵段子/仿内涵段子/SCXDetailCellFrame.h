//
//  SCXDetailCellFrame.h
//  仿内涵段子
//
//  Created by 孙承秀 on 16/10/10.
//  Copyright © 2016年 孙先森丶. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SCXHomeAllModel.h"
#import "SCXHomeCommentModel.h"
@interface SCXDetailCellFrame : NSObject
@property (nonatomic, strong) SCXHomeCommentModel *commentModel;
@property (nonatomic, assign)  CGRect iconImgF;
@property (nonatomic, assign) CGRect nameLF;
@property (nonatomic, assign) CGRect contentLF;
@property (nonatomic, assign) CGRect timeLF;
@property (nonatomic, assign) CGRect likeCountBtnF;
@property (nonatomic, assign) CGRect shareBtnF;
@property (nonatomic, assign) double cellHeight;
@end
