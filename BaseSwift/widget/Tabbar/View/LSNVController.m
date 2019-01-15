//
//  LSNVController.m
//  LaoShan
//
//  Created by dongMac on 13-12-25.
//  Copyright (c) 2013年 dongMac. All rights reserved.
//

#import "LSNVController.h"
#import "BaseSwift-Swift.h"

@interface LSNVController ()

@end

@implementation LSNVController

- (void)viewDidLoad
{
    [super viewDidLoad];
 
}

#pragma mark 第一次使用这个类的使用调一次
+ (void)initialize
{
    
    // 1.appearance方法返回一个导航栏的外观对象
    // 修改了这个外观对象，相当于修改了整个项目中的外观
    UINavigationBar *bar = [UINavigationBar appearance];

//    [bar setBackgroundImage:[UIImage imageNamed:@"top_banner"] forBarPosition:UIBarPositionTopAttached barMetrics:UIBarMetricsDefault];
    [bar setBarTintColor:UIColor.navBarColor];
    bar.translucent = NO;
    
    NSDictionary *dict = @{
                           NSForegroundColorAttributeName : [UIColor whiteColor],
                           };
    
    NSDictionary *dict1 = @{
                           NSForegroundColorAttributeName : [UIColor whiteColor],
                           };
    // 3.设置导航栏文字的主题
    [bar setTitleTextAttributes:dict];
    
    // 4.修改所有UIBarButtonItem的外观
    UIBarButtonItem *barItem = [UIBarButtonItem appearance];
    
    
    [barItem setTitleTextAttributes:dict1 forState:UIControlStateNormal];
}

- (void)navigationBar:(UINavigationBar *)navigationBar didPopItem:(UINavigationItem *)item
{
    
    
    //[HttpManager cancelAllRequestHttpTool];
   
    
}

@end
