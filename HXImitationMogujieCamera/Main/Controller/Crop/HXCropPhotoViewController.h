//
//  HXCropPhotoViewController.h
//  黄轩博客 blog.libuqing.com
//
//  Created by 黄轩 on 16/1/14.
//  Copyright © 2016年 IT小子. All rights reserved.
//

#import "BaseViewController.h"

@class  HXCropPhotoViewController;

@protocol HXCropPhotoViewControllerDelegate <NSObject>

- (void)imageCropper:(HXCropPhotoViewController *)cropper didFinishCroppingWithImage:(UIImage *)image;

@end

@interface HXCropPhotoViewController : BaseViewController

@property (nonatomic, assign) id <HXCropPhotoViewControllerDelegate> delegate;

- (instancetype)initWithImage:(UIImage*)newImage cropSize:(CGSize)cropSize title:(NSString *)title isLast:(BOOL)isLast;

@end


