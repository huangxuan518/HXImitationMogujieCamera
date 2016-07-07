//
//  BaseTabBarController.m
//  黄轩博客 blog.libuqing.com
//
//  Created by 黄轩 on 16/1/14.
//  Copyright © 2016年 IT小子. All rights reserved.
//

#import "BaseTabBarController.h"
#import "BaseNavigationController.h"
#import "HXHomeViewController.h"

@interface BaseTabBarController ()

@end

@implementation BaseTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setViewControllers];
}

- (void)setViewControllers {
    //UITabBarController 数据源
    NSArray *dataAry = @[@{@"class":BaseViewController.class,
                           @"title":@"购物",
                           @"image":@"nav_shopping_nor",
                           @"selectedImage":@"nav_shopping_select",
                           @"badgeValue":@"0"},
                           
                         @{@"class":BaseViewController.class,
                           @"title":@"良品",
                           @"image":@"nav_liangpin_nor",
                           @"selectedImage":@"nav_liangpin_select",
                           @"badgeValue":@"0"},
                           
                         @{@"class":HXHomeViewController.class,
                           @"title":@"",
                           @"image":@"nav_camare",
                           @"selectedImage":@"nav_camare",
                           @"badgeValue":@"0"},
                           
                         @{@"class":BaseViewController.class,
                           @"title":@"聊天",
                           @"image":@"nav_message_nor",
                           @"selectedImage":@"nav_message_select",
                           @"badgeValue":@"0"},
                           
                         @{@"class":BaseViewController.class,
                           @"title":@"我的",
                           @"image":@"nav_me_nor",
                           @"selectedImage":@"nav_me_select",
                           @"badgeValue":@"0"}];
    
    for (NSDictionary *dataDic in dataAry) {
        NSInteger index = [dataAry indexOfObject:dataDic];
        
        //每个tabar的数据
        Class classs = dataDic[@"class"];
        NSString *title = dataDic[@"title"];
        NSString *imageName = dataDic[@"image"];
        NSString *selectedImage = dataDic[@"selectedImage"];
        NSString *badgeValue = dataDic[@"badgeValue"];

        UIViewController *vc = [classs new];
        vc.tabBarItem.tag = index;
        vc.tabBarItem.image = [[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        vc.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];

        if (title.length == 0) {
            //没有文字 图标居中
            float origin = (self.tabBar.frame.size.height - vc.tabBarItem.image.size.height)/2 ;
            vc.tabBarItem.imageInsets = UIEdgeInsetsMake(origin, 0, -origin,0);
        }
        
        //title设置
        [vc.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0]} forState:UIControlStateNormal];
        [vc.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithRed:255/255.0 green:87/255.0 blue:119/255.0 alpha:1.0]} forState:UIControlStateSelected];
        vc.tabBarItem.title = title;
        
        //小红点
        vc.tabBarItem.badgeValue = badgeValue.intValue > 0 ? badgeValue : nil;
        //导航
        BaseNavigationController *nav = [[BaseNavigationController alloc] initWithRootViewController:vc];
        nav.navigationBar.topItem.title = title;
        [nav.rootVcAry addObject:classs];
        [self addChildViewController:nav];
    }
}

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item {

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
