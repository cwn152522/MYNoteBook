//
//  UITabBarItem+Universal.m
//  wtz
//
//  Created by 贾淼 on 15-1-8.
//  Copyright (c) 2015年 milestone. All rights reserved.
//

#import "UITabBarItem+Universal.h"

@implementation UITabBarItem (Universal)

+ (instancetype)itemWithTitle:(NSString *)title image:(UIImage *)image selectedImage:(UIImage *)selectedImage {
    UIImage *normalImage =  [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UITabBarItem *tabBarItem = [[UITabBarItem alloc] initWithTitle:title image:normalImage selectedImage:selectedImage];
    [tabBarItem setImageInsets:UIEdgeInsetsMake(6.0f, 0.0f, -6.0f, 0.0f)];
    return tabBarItem;
}

@end