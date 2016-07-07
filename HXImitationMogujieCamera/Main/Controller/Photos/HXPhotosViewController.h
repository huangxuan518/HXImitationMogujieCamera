//
//  HXPhotosViewController.h
//  黄轩博客 blog.libuqing.com
//
//  Created by 黄轩 on 16/1/14.
//  Copyright © 2016年 IT小子. All rights reserved.
//

#import "BaseCollectionViewController.h"

@interface HXPhotosViewController : BaseCollectionViewController

@property (nonatomic,assign) NSInteger photoCount;//最大添加照片数
@property (nonatomic,copy) void (^completion)(HXPhotosViewController *vc, NSArray *photos);

@end
