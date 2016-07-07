//
//  HXAddPhotoCollectionViewCell.m
//  黄轩博客 blog.libuqing.com
//
//  Created by 黄轩 on 16/1/14.
//  Copyright © 2016年 IT小子. All rights reserved.
//

#import "HXAddPhotoCollectionViewCell.h"

@implementation HXAddPhotoCollectionViewCell

- (void)awakeFromNib {
    // Initialization code
    [super awakeFromNib];
}

- (void)setData:(id)data delegate:(id)delegate {
    if ([data isKindOfClass:[NSDictionary class]]) {
        NSDictionary *dic = data;
        NSString *type = dic[@"type"];
        id image = dic[@"image"];
        
        if ([image isKindOfClass:[NSString class]]) {
            NSString *url = (NSString *)image;
            if ([type isEqualToString:@"add"]) {
                _photoImageButton.layer.borderWidth = 0.5;
                _photoImageButton.layer.borderColor = [UIColor colorWithRed:216/255.0 green:216/255.0 blue:216/255.0 alpha:1.0].CGColor;
                [_photoImageButton setImage:[UIImage imageNamed:url] forState:UIControlStateNormal];
                [_photoImageButton setBackgroundImage:nil forState:UIControlStateNormal];
            } else {
                if([url rangeOfString:@"!small9"].location != NSNotFound) {
                    url = [url stringByReplacingOccurrencesOfString:@"!small9" withString:@""];
                }
                
                _photoImageButton.layer.borderWidth = 0;
                _photoImageButton.layer.borderColor = [UIColor clearColor].CGColor;
                [_photoImageButton sd_setBackgroundImageWithURL:[NSURL URLWithString:url] forState:UIControlStateNormal];
                [_photoImageButton setImage:nil forState:UIControlStateNormal];
            }

        } else if ([image isKindOfClass:[UIImage class]]) {
            [_photoImageButton setImage:image forState:UIControlStateNormal];
        }
        
        
        _photoImageButton.contentMode = UIViewContentModeScaleAspectFill;
    }
}

@end
