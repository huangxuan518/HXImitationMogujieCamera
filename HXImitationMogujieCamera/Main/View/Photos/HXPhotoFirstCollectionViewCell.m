//
//  HXPhotoFirstCollectionViewCell.m
//  黄轩博客 blog.libuqing.com
//
//  Created by 黄轩 on 16/1/14.
//  Copyright © 2016年 IT小子. All rights reserved.
//

#import "HXPhotoFirstCollectionViewCell.h"

@implementation HXPhotoFirstCollectionViewCell

- (void)awakeFromNib {
    // Initialization code
    [super awakeFromNib];
}

- (void)setData:(id)data delegate:(id)delegate {
    if ([data isKindOfClass:[NSDictionary class]]) {
        NSDictionary *dic = data;
        _icoImageView.image = [UIImage imageNamed:dic[@"image"]];
        _titleLabel.text = dic[@"title"];
    }
}

@end
