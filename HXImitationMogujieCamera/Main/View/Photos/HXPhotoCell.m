//
//  HXPhotoCell.m
//  黄轩博客 blog.libuqing.com
//
//  Created by 黄轩 on 16/1/14.
//  Copyright © 2016年 IT小子. All rights reserved.
//

#import "HXPhotoCell.h"

@implementation HXPhotoCell

- (void)awakeFromNib {
    // Initialization code
    [super awakeFromNib];
}

- (void)setData:(id)data delegate:(id)delegate {
    if ([data isKindOfClass:[NSDictionary class]]) {
        NSDictionary *dic = data;
        NSString *groupName = dic[@"name"];
        NSInteger groupPhotoCount = [dic[@"count"] intValue];
        UIImage *image = dic[@"thumbnail"];
        _icoImageView.image = image;
        _titleLabel.text = groupName;
        _countLabel.text = [NSString stringWithFormat:@"%ld",(long)groupPhotoCount];
    }
}

@end
