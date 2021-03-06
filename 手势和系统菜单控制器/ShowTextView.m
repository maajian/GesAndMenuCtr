//
//  ShowTextView.m
//  手势和系统菜单控制器
//
//  Created by zhundao on 2017/10/19.
//  Copyright © 2017年 zhundao. All rights reserved.
//

#import "ShowTextView.h"

#define kScreenWidth ([UIScreen mainScreen].bounds.size.width)
#define kScreenHeight ([UIScreen mainScreen].bounds.size.height)
@interface ShowTextView()<UIGestureRecognizerDelegate>
@end
@implementation ShowTextView
-(instancetype)init{
    if (self = [super init]) {
        self.frame = CGRectMake((kScreenWidth -100)/2, kScreenHeight/2-100, 100, 30);
        self.backgroundColor = [UIColor clearColor];
        self.textAlignment = NSTextAlignmentCenter;
        self.font = [UIFont systemFontOfSize:17];
//        self.scrollEnabled = NO;
//        self.editable = NO;
        [self setSelectable:NO];
        UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPress:)];
        longPress.delegate =self;
        [self addGestureRecognizer:longPress];
    }
    return self;
}

- (void)longPress:(UILongPressGestureRecognizer *)gestureRecognizer{
    if (gestureRecognizer.state == UIGestureRecognizerStateBegan) {
        [gestureRecognizer.view becomeFirstResponder];
        UIMenuController *menu = [UIMenuController sharedMenuController];
        UIMenuItem *item1 = [[UIMenuItem alloc]initWithTitle:@"居左" action:@selector(left:)];
        UIMenuItem *item2 = [[UIMenuItem alloc]initWithTitle:@"居中" action:@selector(center:)];
        UIMenuItem *item3 = [[UIMenuItem alloc]initWithTitle:@"居右" action:@selector(right:)];
        UIMenuItem *item4= [[UIMenuItem alloc]initWithTitle:@"删除" action:@selector(myDelete:)];
        menu.menuItems =@[item1,item2,item3,item4];
        [menu setTargetRect:gestureRecognizer.view.bounds inView:gestureRecognizer.view];
        [menu setMenuVisible:YES animated:YES];
    }
}

- (BOOL)canBecomeFirstResponder
{
    return YES;
}
- (BOOL)canPerformAction:(SEL)action withSender:(id)sender
{
    if (action == @selector(myDelete:)
        || action == @selector(center:)
        ||action == @selector(left:)
        ||action == @selector(right:)) {
        return YES;
    }
    return NO;
}
- (void)myDelete:(UIMenuController *)menu{
    [self removeFromSuperview];
}
- (void)center:(UIMenuController *)menu{
    self.center = CGPointMake(kScreenWidth/2 , self.center.y);
}
- (void)left:(UIMenuController *)menu{
    self.frame = CGRectMake(0, CGRectGetMinY(self.frame), CGRectGetWidth(self.frame), CGRectGetHeight(self.frame));
}
- (void)right:(UIMenuController *)menu{
    self.frame = CGRectMake(kScreenWidth-CGRectGetWidth(self.frame), CGRectGetMinY(self.frame), CGRectGetWidth(self.frame), CGRectGetHeight(self.frame));
}


@end
