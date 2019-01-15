//
//  Dock.m
//  新浪微博
//
//  Created by apple on 13-10-27.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

#import "Dock.h"
#import "DockItem.h"
#import "BaseSwift-Swift.h"

@interface Dock()
{
    DockItem *_selectedItem;
    BOOL _isAuto;
}
@end

@implementation Dock

#pragma mark 添加一个选项卡
- (void)addItemWithIcon:(NSString *)icon selectedIcon:(NSString *)selected title:(NSString *)title
{
    // 1.创建item
    DockItem *item = [[DockItem alloc] init];
    // 文字
    [item setTitle:title forState:UIControlStateNormal];
    // 图标
    [item setImage:[UIImage imageNamed:icon] forState:UIControlStateNormal];
    [item setImage:[UIImage imageNamed:selected] forState:UIControlStateSelected];
    [item setTitleColor:[UIColor btnMainColor] forState:UIControlStateSelected];
    [item setTitleColor:[UIColor colorWithHexWithHexColor:0x6c6d6e] forState:UIControlStateNormal];
    //字体改正后定为11
    item.titleLabel.font = [UIFont systemFontOfSize:13];
    // 监听item的点击
    [item addTarget:self action:@selector(itemClick:) forControlEvents:UIControlEventTouchDown];


    // 2.添加item
    [self addSubview:item];
    NSUInteger count = self.subviews.count;
    
    // 3.调整所有item的frame
    CGFloat height = HT_TabbarHeight-HT_TabbarSafeBottomMargin; // 高度 每个item高度
    CGFloat width = self.frame.size.width / count; // 宽度
    for (int i = 0; i<count; i++) {
        DockItem *dockItem = self.subviews[i];
        dockItem.tag = i; // 绑定标记
        dockItem.frame = CGRectMake(width * i, 0, width, height);
    }
    
    UIImageView *line = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, width, 0.5)];
    line.backgroundColor = [UIColor colorWithRed:0.710 green:0.694 blue:0.706 alpha:1.000];
    [item addSubview:line];
    // 默认选中item

    
    
    if (count == 1) {
          _isAuto = YES;
        [self itemClick:item];
    }
}

#pragma mark 监听item点击
- (void)itemClick:(DockItem *)item
{
    // 0.通知代理
    if ([_delegate respondsToSelector:@selector(dock:itemSelectedFrom:to:)]) {
        [_delegate dock:self itemSelectedFrom:_selectedItem.tag to:item.tag];
    }
    
    // 1.取消选中当前选中的item
    _selectedItem.selected = NO;

    // 2.选中点击的item
    item.selected = YES;
    [_selectedItem setBackgroundColor:[UIColor clearColor]];
    //[item setBackgroundColor:SET_COLOR(35.f, 145.f, 107.f)];
    // 3.赋值
    _selectedItem = item;
    
    _selectedIndex = _selectedItem.tag;
    
    item.imageView.transform = CGAffineTransformMakeScale(0.5, 0.5);
    
    
    [UIView animateWithDuration:0.3 delay:0 usingSpringWithDamping:0.2 initialSpringVelocity:5.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        
        item.imageView.transform = CGAffineTransformMakeScale(1.0, 1.0);
        
    } completion:^(BOOL finished) {
        
        item.imageView.transform = CGAffineTransformIdentity;
    }];
}
@end
