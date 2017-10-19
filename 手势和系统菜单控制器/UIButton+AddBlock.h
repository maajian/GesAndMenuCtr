//
//  UIButton+AddBlock.h
//  手势和系统菜单控制器
//
//  Created by zhundao on 2017/10/19.
//  Copyright © 2017年 zhundao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (AddBlock)

- (void)AddZDAction:(void(^)(void))block forControlEvents:(UIControlEvents)controlEvents;

@end
