//
//  MYWrapNavigationController.h
//  MYNavigationController
//
//  Created by chenweinan on 16/11/8.
//  Copyright © 2016年 chenweinan. All rights reserved.
//

#import <UIKit/UIKit.h>//负责处理push和pop逻辑

@interface MYWrapNavigationController : UINavigationController

- (NSArray *)myViewControllers;//获取所有viewController应使用本方法，不能使用viewControllers方法

@end
