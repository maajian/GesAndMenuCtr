//
//  UIButton+AddBlock.m
//  手势和系统菜单控制器
//
//  Created by zhundao on 2017/10/19.
//  Copyright © 2017年 zhundao. All rights reserved.
//

#import "UIButton+AddBlock.h"
#import <objc/runtime.h>
typedef void(^ZDButton_block)(void);

static const void *buttonKey = @"buttonKey";
/*! 通过runtime给 button添加block属性 */
@interface UIButton ()
/*! 新增block属性 */
@property(nonatomic,copy)ZDButton_block  ZDButton_block;

@end

@implementation UIButton (AddBlock)

- (ZDButton_block)ZDButton_block{
    return  objc_getAssociatedObject(self, @selector(ZDButton_block));
}


- (void)setZDButton_block:(ZDButton_block)ZDButton_block{
    objc_setAssociatedObject(self, @selector(ZDButton_block), ZDButton_block, OBJC_ASSOCIATION_COPY);
}


- (void)AddZDAction:(void(^)(void))block forControlEvents:(UIControlEvents)controlEvents{
    self.ZDButton_block = block;
    [self addTarget:self action:@selector(ZDButtonAction) forControlEvents:controlEvents];
}

- (void)ZDButtonAction {
    if (self.ZDButton_block) {
        self.ZDButton_block();
    }
}

@end
