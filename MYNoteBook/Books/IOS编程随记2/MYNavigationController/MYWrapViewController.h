//
//  MYWrapViewController.h
//  MYNavigationController
//
//  Created by chenweinan on 16/11/8.
//  Copyright © 2016年 chenweinan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MYWrapViewController : UIViewController

+ (instancetype)wrapViewControler:(UIViewController *)controller;

- (UIViewController *)rootViewController;

@end
