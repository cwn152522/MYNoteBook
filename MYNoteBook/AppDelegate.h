//
//  AppDelegate.h
//  MYNoteBook
//
//  Created by chenweinan on 16/11/3.
//  Copyright © 2016年 chenweinan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (nonatomic,assign)NSInteger allowRotate;

- (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;

@end

