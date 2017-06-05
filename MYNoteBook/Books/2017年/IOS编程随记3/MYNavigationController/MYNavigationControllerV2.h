//
//  MYNavigationController.h
//  MYNavigationControllerDemo
//
//  Created by 陈伟南 on 16/11/6.
//  Copyright © 2016年 陈伟南. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NavigationView.h"

@interface UIViewController (MYNav)<NavigationViewViewDlegate>

@property (strong, nonatomic) NavigationView *navigationBar;

@property (strong, nonatomic) NSString *navigationBar_title;
@property (strong, nonatomic) NSString *navigationBar_leftImage;
@property (strong, nonatomic) NSString *navigationBar_rightImage;
@property (strong, nonatomic) NSString *navigationBar_leftTitle;
@property (strong, nonatomic) NSString *navigationBar_rightTitle;
@property (weak, nonatomic) id <NavigationViewViewDlegate> navigationBar_delegate;
@property (assign, nonatomic) BOOL navigationBar_hidden;

@end





@interface UINavigationController (MYNav)

/**
 * 是否需要全屏返回手势
 * 
 * @note   默认为NO
 * @note   设置前提：使用MYCustomNavigationController导航，否则设置无效，始终为NO
 */
@property (assign, nonatomic) BOOL popPanGestureEnabled;

/**
 * 是否需要边缘返回手势
 *
 * @note   默认为NO
 * @note   设置前提：使用MYCustomNavigationController导航，否则设置无效，始终为NO
 */
@property (assign, nonatomic) BOOL popEdgePanGestureEnabled;

@end





@interface MYNavigationControllerV2 : UINavigationController

@property (assign, nonatomic) BOOL interactPopPanGestureEnabled;//同MYCustomNav分类中的popPanGestureEnabled
@property (assign, nonatomic) BOOL interactPopEdgePanGestureEnabled;//同MYCustomNav分类中的popEdgePanGestureEnabled

@end
