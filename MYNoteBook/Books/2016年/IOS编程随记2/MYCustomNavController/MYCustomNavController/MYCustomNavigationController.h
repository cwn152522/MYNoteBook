//
//  MYNavigationController.h
//  MYNavigationControllerDemo
//
//  Created by chenweinan on 16/11/6.
//  Copyright © 2016年 chenweinan. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 * 概述：
 *          使用本navigationController，能在push和pop(支持手势)时在视觉上展示单独navigationBar(系统是固定、共用的)
 *
 *
 *原理：
 *          在push和pop时，通过给控制器视图添加假navigationBar并结合前后控制器视图和真navigationBar位置的移动来实现相应效果
 *
 *
 * 实现：
 *          1.实现UIViewControllerAnimatedTransitioning来定义modal或push的自定义转场动画
 *          2.实现UIViewControllerTransitioningDelegate在modal动画属性为YES时触发相应方法调用UIViewControllerAnimatedTransitioning定义的自定义转场动画
 *          3.实现UINavigationControllerDelegate在push或pop动画属性为YES时触发相应方法调用UIViewControllerAnimatedTransitioning定义的自定义转场动画；
 *          4.在3.中给navigationController.view添加左边缘滑动手势，禁掉系统手势，在手势响应里进行popViewControllerAnimated操作并调用实现了UIViewControllerInteractiveTransitioning的UIPercentDrivenInteractiveTransition对象的相应动画进度控制方法
 *          5.在3.中代理交互式转场代理方法里返回UIPercentDrivenInteractiveTransition进度转场动画进度控制对象
 *          6.在本类重写push和pop方法，在push和pop前调用1.类，对当前navigationBar进行相应截屏入相应图片栈
 *          7.push动画时，把pushImages栈中的最后一个元素取出(假navigationBar)，并添加到当前页面的上方，通过控制真navigationBar和后一个页面同时由屏幕右往左移动和当前页面向左移动实现视觉上单独的navigationBar效果，当然动画结束把假navigationBar移除掉
 *          8.pop动画时，把popImage取出(假navigationBar)，并添加到当前页面上方；把pushImages栈中的最后一个元素取出(假navigationBar），并添加到上一个页面上方；然后把真navigationBar移到动画视图栈中两个页面的下方；通过控制当前和上一个页面往右移动（真navigationBar位置不动）实现视觉上单独的navigationBar效果，当然动画结束把两个假navigationBar移除掉，并把真navigationBar移到动画视图栈顶
 *
 *
 * 特别注意：
            1.pop动画可能不止一个页面出栈，在pop前，需调整pushImages栈，将pop到的页面之后的假navigationBar出栈，保证pushImages栈顶是pop动画前一个页面的假navigationBar;
 *         2.navigationBar的Translucent属性会导致页面坐标系发生变化，页面origin.y可能是64，也能是0，自定义动画需做相应处理
 *         3.navigationBar的Translucent属性为YES时，在pop页面出栈数大于1时，居然会临时变成NO？这个问题虽然通过flag解决了，具体原因还得研究研究
 *         4.记住UIViewControllerAnimatedTransition的动画执行在下一个toViewController的ViewDidLoad和ViewWillAppear之后，在ViewDidAppear之前
＊       5.InteractiveTransitioning动画实际上是对animatedTransition相应动画进度的把控
 */
@interface MYCustomNavigationController : UINavigationController

@end
