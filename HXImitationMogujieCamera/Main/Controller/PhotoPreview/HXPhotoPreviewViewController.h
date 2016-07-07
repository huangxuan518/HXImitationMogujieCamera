//
//  HXPhotoPreviewViewController.h
//  黄轩博客 blog.libuqing.com
//
//  Created by 黄轩 on 16/1/14.
//  Copyright © 2016年 IT小子. All rights reserved.
//

#import "BaseViewController.h"

@interface HXPhotoPreviewViewController : BaseViewController

@property (nonatomic,copy) NSString *superTitle;

//删除照片
@property (nonatomic,copy) void (^deleteCompletion)(HXPhotoPreviewViewController *vc, NSArray *photos);

/**
 *  初始化
 *
 *  @param photos 需要显示的照片，可以是ALAsset或者UIImage
 *
 *  @return
 */
- (instancetype)initWithPhotos:(NSArray *)photos;

/**
 *  初始化
 *
 *  @param photos 需要显示的照片，可以是ALAsset或者UIImage
 *  @param index  显示第几张 index 防止越界
 *
 *  @return
 */
- (instancetype)initWithPhotos:(NSArray *)photos index:(NSInteger)index;

@end
