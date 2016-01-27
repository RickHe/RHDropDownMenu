//
//  UIView+ViewController.m
//  XiaoYing
//
//  Created by hmy2015 on 15/11/9.
//  Copyright (c) 2015年 MengFanBiao. All rights reserved.
//

#import "UIView+ViewController.h"

@implementation UIView (ViewController)

// 获取视图所在的视图控制器
- (UIViewController *)viewController
{
    UIResponder *responder = self.nextResponder;
    while (responder) {
        if ([responder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)responder;
        }
        responder = responder.nextResponder;
    }
    return nil;
}

@end
