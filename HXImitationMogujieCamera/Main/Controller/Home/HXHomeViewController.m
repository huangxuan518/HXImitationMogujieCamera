//
//  HXHomeViewController.m
//  黄轩博客 blog.libuqing.com
//
//  Created by 黄轩 on 16/1/14.
//  Copyright © 2016年 IT小子. All rights reserved.
//

#import "HXHomeViewController.h"
#import "HXPhotoPreviewViewController.h"
#import "HXPhotosViewController.h"
#import "HXHomeAddPhotoCell.h"
#import "BaseNavigationController.h"

@interface HXHomeViewController ()

@property (nonatomic,strong) NSArray *cellDataSource;//cell相关data
@property (nonatomic,strong) NSMutableArray *imagUrlAry;//多图路径串

@end

@implementation HXHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.tableview registerNib:[UINib nibWithNibName:@"HXHomeAddPhotoCell" bundle:nil] forCellReuseIdentifier:@"HXHomeAddPhotoCell"];
}

#pragma mark - cellDataSource

- (NSArray *)cellDataSource {
    if (!_cellDataSource) {
        NSMutableArray *arr = [NSMutableArray arrayWithCapacity:4];
        
        NSMutableArray *subarr = nil;
        NSDictionary *dict = nil;
        
        //section 1
        subarr = [NSMutableArray arrayWithCapacity:1];
        dict =  @{@"class":HXHomeAddPhotoCell.class,
                  @"height":@([HXHomeAddPhotoCell getCellFrame:self.imagUrlAry]),
                  @"data":self.imagUrlAry.count > 0 ? self.imagUrlAry : @"",
                  @"delegate":@YES};
        [subarr addObject:dict];
        [arr addObject:subarr];
        
        _cellDataSource = arr;
    }
    return _cellDataSource;
}

#pragma mark UITableViewDataSource/UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.cellDataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *arr = self.cellDataSource[section];
    return [arr count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSArray *section = self.cellDataSource[indexPath.section];
    NSDictionary *cellDict = section[indexPath.row];
    
    Class classs = cellDict[@"class"];

    BaseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(classs)];
    if (!cell) {
        cell = [[BaseTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass(classs)];
    }

    [cell setSeperatorLineForIOS7:indexPath numberOfRowsInSection:section.count];
    
    NSNumber *delFlag = cellDict[@"delegate"];
    
    id delegate = nil;
    
    if (delFlag && delFlag.boolValue) {
        delegate = self;
    }
    
    [cell setData:cellDict delegate:delegate];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSArray *section = self.cellDataSource[indexPath.section];
    NSDictionary *cellDict = section[indexPath.row];
    float height = [cellDict[@"height"] floatValue];
    return height;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 10)];
    view.backgroundColor = [UIColor clearColor];
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 10;
}

#pragma mark HXAddPhotoCellDelegate

- (void)homeAddPhotoCell:(HXHomeAddPhotoCell *)homeAddPhotoCell didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [self.view endEditing:YES];

    if (indexPath.row == self.imagUrlAry.count) {
        [self gotoPhotosViewController];
    } else {
        [self gotoPhotoPreviewViewController:indexPath.row];
    }
}

#pragma mark - Go To

//照片预览界面
- (void)gotoPhotoPreviewViewController:(NSInteger)index {
    HXPhotoPreviewViewController *vc = [[HXPhotoPreviewViewController alloc] initWithPhotos:self.imagUrlAry index:index];
    vc.superTitle = self.title;
    vc.deleteCompletion = ^(HXPhotoPreviewViewController *vc, NSArray *photos) {
        [self.imagUrlAry removeAllObjects];
        self.imagUrlAry = [NSMutableArray arrayWithArray:photos];
        [self refreshData];
    };
    [self.navigationController pushViewController:vc animated:YES];
}

//去相机相册
- (void)gotoPhotosViewController {
    NSInteger count = 6 - self.imagUrlAry.count;
    
    if (count <= 0) {
        NSLog(@"最多只能添加6张照片");
        return;
    }
    
    HXPhotosViewController *vc = [HXPhotosViewController new];
    vc.photoCount = count;

    vc.completion = ^(HXPhotosViewController *vc,NSArray *photos) {

        [self.imagUrlAry addObjectsFromArray:photos];
        //事件处理
        [self dismissViewControllerAnimated:YES completion:nil];
        
        [self refreshData];
    };
    BaseNavigationController *nav = [[BaseNavigationController alloc] initWithRootViewController:vc];
    nav.navigationBar.barTintColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:1.0];
    nav.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor],
                                              NSFontAttributeName:[UIFont boldSystemFontOfSize:18]};
    [self.navigationController presentViewController:nav animated:YES completion:nil];
}

#pragma mark - refreshData

/**
 *  刷新tableView
 */
- (void)refreshData {
    _cellDataSource = nil;
    [self.tableview reloadData];
}

#pragma mark - 懒加载

- (NSMutableArray *)imagUrlAry {
    if (!_imagUrlAry) {
        _imagUrlAry = [NSMutableArray new];
    }
    return _imagUrlAry;
}

@end
