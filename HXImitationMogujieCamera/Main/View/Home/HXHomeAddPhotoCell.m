//
//  HXHomeAddPhotoCell.m
//  黄轩博客 blog.libuqing.com
//
//  Created by 黄轩 on 16/1/14.
//  Copyright © 2016年 IT小子. All rights reserved.
//

#import "HXHomeAddPhotoCell.h"
#import "HXAddPhotoCollectionViewCell.h"

#define  Identifier @"HXAddPhotoCollectionViewCell"

@interface HXHomeAddPhotoCell () <UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property (nonatomic,strong) UICollectionView *collectionView;
@property (nonatomic,strong) NSArray *ary;

@end

@implementation HXHomeAddPhotoCell

- (void)awakeFromNib {
    // Initialization code
    [super awakeFromNib];
    //先实例化一个层
    UICollectionViewFlowLayout *layout= [UICollectionViewFlowLayout new];
    layout.minimumInteritemSpacing = 0;
    layout.minimumLineSpacing = 0;
    //创建一屏的视图大小
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(HXHomeAddPhotoCellCollectionViewX, HXHomeAddPhotoCellCollectionViewY, [[UIScreen mainScreen] bounds].size.width - HXHomeAddPhotoCellCollectionViewX*2, [HXHomeAddPhotoCell getCellFrame:nil] - HXHomeAddPhotoCellCollectionViewY - 50) collectionViewLayout:layout];
    [_collectionView registerNib:[UINib nibWithNibName:Identifier bundle:nil] forCellWithReuseIdentifier:Identifier];
    _collectionView.backgroundColor = [UIColor clearColor];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    [self addSubview:_collectionView];
}

- (void)setData:(id)data delegate:(id)delegate {
    _delegate = delegate;
    if ([data isKindOfClass:[NSDictionary class]]) {
        if ([data[@"data"] isKindOfClass:[NSMutableArray class]]) {
            _ary = data[@"data"];
        }
        [_collectionView reloadData];
    }
}

//定义展示的UICollectionViewCell的个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    NSInteger count = _ary.count + 1;
    if (6 - _ary.count <= 0) {
        count = _ary.count;
    }
    return count;
}

//每个UICollectionView展示的内容
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * CellIdentifier = Identifier;
    BaseCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    
    NSDictionary *dic;
    if (indexPath.row == _ary.count && _ary.count != 6) {
        dic = @{@"type":@"add",
                @"image":@"add_photo"};
    } else {
        id image = _ary[indexPath.row];
        dic = @{@"type":@"photo",
                @"image":image};
    }
    [cell setData:dic delegate:nil];

    return cell;
}

//定义每个UICollectionView 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    float width = (_collectionView.frame.size.width - (HXHomeAddPhotoCellRowPhotoSpace*(HXHomeAddPhotoCellRowPhotoCount + 1))) / HXHomeAddPhotoCellRowPhotoCount;
    return CGSizeMake(width, width);
}

// 设置每个cell上下左右相距
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(HXHomeAddPhotoCellRowPhotoSpace, HXHomeAddPhotoCellRowPhotoSpace, 0, HXHomeAddPhotoCellRowPhotoSpace);
}

//// 设置最小行间距，也就是前一行与后一行的中间最小间隔
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return HXHomeAddPhotoCellRowPhotoSpace;
}

// 设置最小列间距，也就是左行与右一行的中间最小间隔
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return HXHomeAddPhotoCellRowPhotoSpace;
}

//UICollectionView被选中时调用的方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (_delegate && [_delegate respondsToSelector:@selector(homeAddPhotoCell:didSelectItemAtIndexPath:)]) {
        [_delegate homeAddPhotoCell:self didSelectItemAtIndexPath:indexPath];
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _collectionView.frame = CGRectMake(_collectionView.frame.origin.x, _collectionView.frame.origin.y, _collectionView.frame.size.width, self.frame.size.height - 5);
}

+ (float)getCellFrame:(id)msg {
    int photoCount;
    if ([msg isKindOfClass:[NSArray class]]) {
        NSArray *ary = msg;
        photoCount = (int)ary.count;
    }
    
    if (6 - photoCount <= 0) {
        photoCount = photoCount - 1;
    }
    //(UICollectionView的宽度等于全屏的宽度减左右间隙 - CollectionViewCell间的间隙和) 除以 每行的数量
    float width = (([[UIScreen mainScreen] bounds].size.width - HXHomeAddPhotoCellCollectionViewX*2) - (HXHomeAddPhotoCellRowPhotoSpace*(HXHomeAddPhotoCellRowPhotoCount + 1))) / HXHomeAddPhotoCellRowPhotoCount;
    float height = width;
    
    //照片上边距 + 照片行数 * （照片高度 + 间隙） + 下边文字固定高度
    return HXHomeAddPhotoCellCollectionViewY*2 + (photoCount / HXHomeAddPhotoCellRowPhotoCount + 1)*(height + HXHomeAddPhotoCellRowPhotoSpace) + 5;
}

@end
