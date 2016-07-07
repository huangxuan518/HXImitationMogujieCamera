//
//  HXHomeAddPhotoCell.h
//  黄轩博客 blog.libuqing.com
//
//  Created by 黄轩 on 16/1/14.
//  Copyright © 2016年 IT小子. All rights reserved.
//

#import "BaseTableViewCell.h"

#define HXHomeAddPhotoCellRowPhotoCount 3 //每一行的数量
#define HXHomeAddPhotoCellRowPhotoSpace 5 //照片间隔
#define HXHomeAddPhotoCellCollectionViewX 5 //x坐标
#define HXHomeAddPhotoCellCollectionViewY 5 //y坐标

@class HXHomeAddPhotoCell;

@protocol HXHomeAddPhotoCellDelegate <NSObject>

- (void)homeAddPhotoCell:(HXHomeAddPhotoCell *)homeAddPhotoCell didSelectItemAtIndexPath:(NSIndexPath *)indexPath;

@end

@interface HXHomeAddPhotoCell : BaseTableViewCell

@property (nonatomic,weak) id <HXHomeAddPhotoCellDelegate> delegate;

@end
