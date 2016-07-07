//
//  HXPhotoCell.h
//  黄轩博客 blog.libuqing.com
//
//  Created by 黄轩 on 16/1/14.
//  Copyright © 2016年 IT小子. All rights reserved.
//

#import "BaseTableViewCell.h"

@interface HXPhotoCell : BaseTableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *icoImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *countLabel;

@end
