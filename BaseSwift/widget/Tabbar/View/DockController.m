//
//  DockController.m
//  测试Dock
//
//  Created by apple on 13-10-27.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

#import "DockController.h"
#import "Dock.h"
#import "BaseSwift-Swift.h"

#define isPad (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define IS_RETINA ([[UIScreen mainScreen] scale] >= 2.0)
#define IS_IPHONE_4_OR_LESS (IS_IPHONE && SCREEN_MAX_LENGTH < 568.0)
#define IS_IPHONE_5 (IS_IPHONE && SCREEN_MAX_LENGTH == 568.0)
#define IS_IPHONE_6 (IS_IPHONE && SCREEN_MAX_LENGTH == 667.0)
#define IS_IPHONE_6P (IS_IPHONE && SCREEN_MAX_LENGTH == 736.0)

#define IS_IPHONE_XR ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(828, 1792), [[UIScreen mainScreen] currentMode].size) && !isPad : NO)

#define IS_IPHONE_XS_Max ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2688), [[UIScreen mainScreen] currentMode].size) && !isPad : NO)

#define IS_iPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) && !isPad : NO)

#define HT_StatusBarHeight      ((IS_iPhoneX||IS_IPHONE_XR||IS_IPHONE_XS_Max) ? 44.f : 20.f)
#define HT_NavigationBarHeight  44.f
#define HT_TabbarHeight         ((IS_iPhoneX||IS_IPHONE_XR||IS_IPHONE_XS_Max)  ? (49.f+34.f) : 49.f)
#define HT_TabbarSafeBottomMargin         ((IS_iPhoneX||IS_IPHONE_XR||IS_IPHONE_XS_Max)  ? 34.f : 0.f)
#define HT_StatusBarAndNavigationBarHeight  ((IS_iPhoneX||IS_IPHONE_XR||IS_IPHONE_XS_Max)  ? 88.f : 64.f)
#define HT_ViewSafeAreInsets(view) ({UIEdgeInsets insets; if(@available(iOS 11.0, *)) {insets = view.safeAreaInsets;} else {insets = UIEdgeInsetsZero;} insets;})

#define SCREEN_MAX_LENGTH (MAX(SCREEN_WIDTH, SCREEN_HEIGHT))
#define SCREEN_MIN_LENGTH (MIN(SCREEN_WIDTH, SCREEN_HEIGHT))

#define kDockHeight HT_TabbarHeight

@interface DockController () <DockDelegate>
@end

@implementation DockController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 1.添加Dock
    [self addDock];
}

#pragma mark 添加Dock
- (void)addDock
{
    Dock *dock = [[Dock alloc] init];
    dock.frame = CGRectMake(0, self.view.frame.size.height - kDockHeight, self.view.frame.size.width, kDockHeight);
    
    dock.delegate = self;
    [self.view addSubview:dock];
    _dock = dock;
    

   
}

#pragma mark dock的代理方法
- (void)dock:(Dock *)dock itemSelectedFrom:(int)from to:(int)to
{
    if (to < 0 || to >= self.childViewControllers.count) return;
    
    // 1.取出即将显示的控制器
    UIViewController *newVc = self.childViewControllers[to];
    
    
    if (to != 0) {
        
        if (_selectedController == newVc ) {
            
            return;
        }
    }

    // 0.移除旧控制器的view
    UIViewController *oldVc = self.childViewControllers[from];
    [oldVc.view removeFromSuperview];
    
    CGFloat width = self.view.frame.size.width;
    CGFloat height = self.view.frame.size.height - kDockHeight;
    newVc.view.frame = CGRectMake(0, 0, width, height);
    // 2.添加新控制器的view到MainController上面
    [self.view addSubview:newVc.view];
    
    _selectedController = newVc;
}
@end
