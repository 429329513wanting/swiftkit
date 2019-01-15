//
//  RBMainViewController.m
//  RentBusiness
//
//  Created by ghwang on 2017/11/10.
//  Copyright © 2017年 ghwang. All rights reserved.
//

#import "MainViewController.h"
#import "BaseSwift-Swift.h"
#import <EasyNavigation/EasyNavigation.h>
#import "UIView+SDAutoLayout.h"

@interface MainViewController ()<UINavigationControllerDelegate, DockDelegate>

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self addAllChildControllers];
    [self addDockItems];
    
    UIView *line = [UIView new];
    line.backgroundColor = UIColor.cccColor;
    [_dock addSubview:line];
    line.sd_layout.topSpaceToView(_dock,0)
    .heightIs(0.5)
    .widthRatioToView(_dock,1);
}

- (UIStatusBarStyle)preferredStatusBarStyle{
    
    return UIStatusBarStyleLightContent;
}
#pragma mark 初始化所有的子控制器
- (void)addAllChildControllers{
    
    

    HomeViewController * homeVC = [[HomeViewController alloc]init];
    EasyNavigationController * nav0 = [[EasyNavigationController alloc] initWithRootViewController:homeVC];
    nav0.delegate = self;
    [self addChildViewController:nav0];
    
    MeViewController * companyvc = [[MeViewController alloc]init];
    EasyNavigationController * nav1 = [[EasyNavigationController alloc] initWithRootViewController:companyvc];
    nav1.delegate = self;
    [self addChildViewController:nav1];
    

}

#pragma mark 实现导航控制器代理方法
// 导航控制器即将显示新的控制器
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    // if (![viewController isKindOfClass:[HomeController class]])
    // 如果显示的不是根控制器，就需要拉长导航控制器view的高度
    
    // 1.获得当期导航控制器的根控制器
    UIViewController *root = navigationController.viewControllers[0];
    if (root != viewController) { // 不是根控制器
        // {0, 20}, {320, 460}
        // 2.拉长导航控制器的view
        CGRect frame = navigationController.view.bounds;
        
        /////////////
        frame.size.height = self.view.bounds.size.height;
        
        navigationController.view.frame = frame;
        
        // 3.添加Dock到根控制器的view上面
        [_dock removeFromSuperview];
        CGRect dockFrame = _dock.frame;
        dockFrame.origin.y = root.view.bounds.size.height - _dock.frame.size.height;
        if ([root.view isKindOfClass:[UIScrollView class]]) { // 根控制器的view是能滚动
            UIScrollView *scroll = (UIScrollView *)root.view;
            dockFrame.origin.y += scroll.contentOffset.y;
            _dock.frame = dockFrame;
        }
        [root.view addSubview:_dock];
        
    }else{
        
        //        [root.view addSubview:_dock];
    }
}


- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    UIViewController *root = navigationController.viewControllers[0];
    if (viewController == root) {
        // 1.让导航控制器view的高度还原
        CGRect frame = navigationController.view.bounds;
        //        frame.size.height = self.view.window.bounds.size.height - _dock.frame.size.height;
        
        frame.size.height = self.view.bounds.size.height - _dock.frame.size.height;
        navigationController.view.frame = frame;
        
        // 2.添加Dock到mainView上面
        [_dock removeFromSuperview];
        CGRect dockFrame = _dock.frame;
        // 调整dock的y值
        dockFrame.origin.y = self.view.frame.size.height - _dock.frame.size.height;
        _dock.frame = dockFrame;
        [self.view addSubview:_dock];
        _dock.backgroundColor = [UIColor whiteColor];
        
        
    }
}

- (void)back
{
    [self.childViewControllers[_dock.selectedIndex] popViewControllerAnimated:YES];
}

#pragma mark 添加Dock
- (void)addDockItems
{
    // 1.设置Dock的背景图片
    _dock.backgroundColor = [UIColor whiteColor];
    
    // 2.往Dock里面填充内容
    [_dock addItemWithIcon:@"tabbar_index_normal" selectedIcon:@"tabbar_index_selected" title:@"首页"];
    [_dock addItemWithIcon:@"tabbar_myunit_normal" selectedIcon:@"tabbar_myunit_selected" title:@"个人中心"];
    
}

@end
