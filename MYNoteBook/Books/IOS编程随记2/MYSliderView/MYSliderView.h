//
//  MYSliderView.h
//  MYSiderViewDemo
//
//  Created by chenweinan on 16/11/8.
//  Copyright © 2016年 chenweinan. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MYSliderView;

@protocol  MYSliderViewDatasource<NSObject>

@required;
- (UIViewController *)baseViewControllerOfSiderView:(MYSliderView *)sliderView;
- (NSInteger)numberOfViewControllersInSliderView:(MYSliderView *)sliderView;
- (UIViewController *)sliderView:(MYSliderView *)sliderView viewControllerAtIndex:(NSInteger)index;

@end

@protocol MYSliderViewDelegate <NSObject>

@optional;
- (void)sliderView:(MYSliderView *)sliderView switchingFrom:(NSInteger)fromIndex to:(NSInteger) toIndex percent:(CGFloat)percent;

@end

@interface MYSliderView : UIView

/**
 * 概述：
 * 结合之前独立navigationBar和bannerScrollView两者的封装思想完成了此次sliderView的实现，sliderView类似ScrollView，但能更高效，避免很多情况下内存的浪费，比如类似网易新闻顶部导航：如果有30个TableView或CollectionView列表的数据，由scrollView来嵌套30个列表，再假设每个列表都有banner轮播100张图片，那内存消耗是相当可怕的。此次封装的sliderView，结合NSCache的使用，可以做到，滑动过程最多load三个视图，并且滑动结束只保留一个视图，极大节省了内存的消耗。此次封装是解耦思想的一大体现。
 *
 *
 * 实现：
 * 1.baseVC使用NSCache存储相应列表对应的VC，然后作为sliderview的数据源为其提供baseVC、滑动结束显示的当前VC以及相应列表对应的VC总数
 * 2.初始化sliderView：获取到数据源后调用showViewControllerAtIndex:0，将第1r个VC即currentVC添加到baseVC作为子控制器，将视图添加到sliderView，设置约束，其中有个动态约束用来控制VC的view移动，每次调用showViewControllerAtIndex都会重置sliderview
 * 3.给sliderview添加pan手势，在手势触发方法里处理相应逻辑：
 *    3.1 滑过程如果判断往右则通过代理向baseVC获取上一ViewController，添加到baseVC作为子控制器，将视图添加到sliderView，约束紧贴currentVC左边沿；左滑获取下一个viewController，添加到baseVC作为子控制器，将视图添加到sliderView，约束紧贴currentVC右边沿
 *   3.2 滑动结束判断最终显示的是上一页还是下一页，实现动画将currentVC的约束左或右移一个sliderView宽度，然后调用showViewControllerAtIndex:页数，将所有vc移除掉，并将最终显示的作为仅存的currentVC
 *
 *
 * 注意事项:
 * 1.实现的3.1步骤，将所有vc移除掉，会走viewDisappear，然后将最终列表重新显示出来，即最终列表连续走了viewDisappear和viewAppear，而另外两个列表vc则只走viewDisappear
 * 2.baseVC初始化sliderView，以及所有列表VC，建议将列表VC添加至NSCache，并设置cache限制数，假如5个列表VC,限制数为4，那么1-4列表第一次显示时会走viewDidLoad加载视图，5出来后1会dealloc，因为到了Cache限制，会将前面的cache干掉，然后让5进来。从5移回2，所有视图只会走viewDisappear和viewAppear，而移回1时，会重新viewDidLoad加载视图5又被干掉。网易有时候滑到后面专题列表回前面会重新刷新，可能就是类似原理吧。
 * 3.本次封装仅实现了slider视图，将滑动进度通过代理传到baseVC，如果需要实现像网易那样切换的顶部导航，导航UI随滑动进度改变，则可以实现该代理方法获取进度
 *
 */


@property (nonatomic, assign) id<MYSliderViewDatasource> dataSource;
@property (nonatomic, assign) id<MYSliderViewDelegate> delegate;

- (void)showViewController:(NSInteger)index;

@end
