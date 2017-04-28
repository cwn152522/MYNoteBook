//
//  MYNavigationController.h
//  MYNavigationController
//
//  Created by chenweinan on 16/11/8.
//  Copyright © 2016年 chenweinan. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MYNavigationControllerCustomBar <NSObject>

- (Class)myNavigationControllerCustomBar;

@end

@interface MYNavigationController : UINavigationController

/**
 * 原理：
 * 1.让每个ViewController都有独立的wrapNavigationController，这个wrapNavigationController由addChildController添加到wrapViewConroller, 而所有的wrapViewController共用最外层navigationController。
 * 2.把最外层的navigationBar隐藏掉，所以push或pop都能看到独立的navigationController（其实是wrapNavigationController）
 * 3.(1)controller.navigationController = wrapNavigationController;
      (2)wrapViewController.navigationController = 最外层navigationController;
      (3)作为wrapViewController的subViewController，此关系也成立wrapNavigationController.navigationController = 最外层navigationController;
 * 4.由于navigationController不能放在navigationController的viewControllers栈中，所以只能外面再套一个wrapNavigationController
 *
 *
 * 注意事项:
 * 1.storyboard使用本navigationController，在initWithCoder：中包裹前rootViewController是存在的，需先self.viewControllers = @[]，先置空后重新包裹rootViewController，重新初始化视图，否者包裹前rootViewController先初始化，导致包裹后显示出现异常，如首页的title不显示、title显示错位等
 * 2.代码使用本navigationController不会出现1.的情况，因为initWithRootViewController中，包裹前self.viewController = @[];先包裹后初始化，所以不会出问题
 * 3.popToViewController:必须从本类myViewControllers接口获取相应pop视图控制器，不能从viewController.navigationController.viewControllers中获取，因为viewController.navigationController是wrapNavigationController，其viewControllers只有当前viewController
   4.不能在storyboard取消navigationBar的显示状态，storyboard初始化时如果不显示，那么pop手势是不会加载的，而在本类实现viewDidLoad里将navigationBar设置隐藏就不会影响pop手势。
 */

@end
