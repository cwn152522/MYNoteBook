//
//  MYNavigationController.m
//  MYNavigationControllerDemo
//
//  Created by 陈伟南 on 16/11/6.
//  Copyright © 2016年 陈伟南. All rights reserved.
//

#import "MYNavigationControllerV2.h"
#import "MYNavControllerTransitioningDelegateV2.h"
#import <objc/runtime.h>

@implementation UIViewController (MYNav)

- (NavigationView *)navigationBar{
    if([self isMemberOfClass:[MYNavigationControllerV2 class]])
        return nil;
    NavigationView *navigationBar = objc_getAssociatedObject(self, _cmd);
    return navigationBar;
}
- (void)setNavigationBar:(NavigationView *)navigationBar{
    if([self isMemberOfClass:[MYNavigationControllerV2 class]])
        return;
    objc_setAssociatedObject(self, @selector(navigationBar), navigationBar, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSString *)navigationBar_title{
    if([self isMemberOfClass:[MYNavigationControllerV2 class]])
        return nil;
    return objc_getAssociatedObject(self, _cmd);
}
- (void)setNavigationBar_title:(NSString *)navigationBar_title{
    if([self isMemberOfClass:[MYNavigationControllerV2 class]])
        return;
    [[self navigationBar] zhongJianLableSheZhiLable:navigationBar_title withZiShiYing:NO withFont:17];
    objc_setAssociatedObject(self, @selector(navigationBar_title), navigationBar_title, OBJC_ASSOCIATION_COPY);
}

- (NSString *)navigationBar_leftImage{
    if([self isMemberOfClass:[MYNavigationControllerV2 class]])
        return nil;
    return objc_getAssociatedObject(self, _cmd);
}
- (void)setNavigationBar_leftImage:(NSString *)navigationBar_leftImage{
    if([self isMemberOfClass:[MYNavigationControllerV2 class]])
        return;
    [[self navigationBar] leftBtnSheZhiImage:navigationBar_leftImage withText:navigationBar_leftImage withHidden:NO];
    objc_setAssociatedObject(self, @selector(navigationBar_leftImage), navigationBar_leftImage, OBJC_ASSOCIATION_COPY);
}

- (NSString *)navigationBar_rightImage{
    if([self isMemberOfClass:[MYNavigationControllerV2 class]])
        return nil;
    return objc_getAssociatedObject(self, _cmd);
}
- (void)setNavigationBar_rightImage:(NSString *)navigationBar_rightImage{
    if([self isMemberOfClass:[MYNavigationControllerV2 class]])
        return;
    [[self navigationBar] reghtBtnSheZhiImage:navigationBar_rightImage withText:@"" withHidden:NO];
    objc_setAssociatedObject(self, @selector(navigationBar_rightImage), navigationBar_rightImage, OBJC_ASSOCIATION_COPY);
}

- (NSString *)navigationBar_leftTitle{
    if([self isMemberOfClass:[MYNavigationControllerV2 class]])
        return nil;
    return objc_getAssociatedObject(self, _cmd);
}
- (void)setNavigationBar_leftTitle:(NSString *)navigationBar_leftTitle{
    if([self isMemberOfClass:[MYNavigationControllerV2 class]])
        return;
    [[self navigationBar] leftBtnSheZhiImage:@"" withText:navigationBar_leftTitle withHidden:NO];
    objc_setAssociatedObject(self, @selector(navigationBar_leftTitle), navigationBar_leftTitle, OBJC_ASSOCIATION_COPY);
}

- (NSString *)navigationBar_rightTitle{
    if([self isMemberOfClass:[MYNavigationControllerV2 class]])
        return nil;
    return objc_getAssociatedObject(self, _cmd);
}
- (void)setNavigationBar_rightTitle:(NSString *)navigationBar_rightTitle{
    if([self isMemberOfClass:[MYNavigationControllerV2 class]])
        return;
    [[self navigationBar] reghtBtnSheZhiImage:@"" withText:navigationBar_rightTitle withHidden:NO];
    objc_setAssociatedObject(self, @selector(navigationBar_rightTitle), navigationBar_rightTitle, OBJC_ASSOCIATION_COPY);
}

- (id<NavigationViewViewDlegate>)navigationBar_delegate{
    if([self isMemberOfClass:[MYNavigationControllerV2 class]])
        return nil;
    return [self navigationBar].delegate;
}
- (void)setNavigationBar_delegate:(id<NavigationViewViewDlegate>)navigationBar_delegate{
    if([self isMemberOfClass:[MYNavigationControllerV2 class]])
        return;
    [[self navigationBar] setDelegate:navigationBar_delegate];
}

- (BOOL)navigationBar_hidden{
    if([self isMemberOfClass:[MYNavigationControllerV2 class]])
        return NO;
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}
- (void)setNavigationBar_hidden:(BOOL)navigationBar_hidden{
    if([self isMemberOfClass:[MYNavigationControllerV2 class]])
        return;
    objc_setAssociatedObject(self, @selector(navigationBar_hidden), [NSNumber numberWithBool:navigationBar_hidden], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [[self navigationBar] setHidden:navigationBar_hidden];
}

@end






@implementation UINavigationController (MYNav)

- (void)setPopPanGestureEnabled:(BOOL)popGestureEnabled{
    if([self isKindOfClass:[MYNavigationControllerV2 class]]){
        [(MYNavigationControllerV2 *)self setInteractPopPanGestureEnabled:popGestureEnabled];
    }
}
- (BOOL)popPanGestureEnabled{
    if([self isKindOfClass:[MYNavigationControllerV2 class]]){
       return  [(MYNavigationControllerV2 *)self interactPopPanGestureEnabled];
    }
    return NO;
}

- (void)setPopEdgePanGestureEnabled:(BOOL)popEdgePanGestureEnabled{
    if([self isKindOfClass:[MYNavigationControllerV2 class]]){
        [(MYNavigationControllerV2 *)self setInteractPopEdgePanGestureEnabled:popEdgePanGestureEnabled];
    }
}
- (BOOL)popEdgePanGestureEnabled{
    if([self isKindOfClass:[MYNavigationControllerV2 class]]){
        return  [(MYNavigationControllerV2 *)self interactPopEdgePanGestureEnabled];
    }
    return NO;
}

@end







@interface MYNavigationControllerV2 ()

@property (nonatomic, strong) MYNavControllerTransitioningDelegateV2 *navDelegate;

@end

@implementation MYNavigationControllerV2

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navDelegate = [[MYNavControllerTransitioningDelegateV2 alloc] initWithNavigationController:self];
    self.navDelegate.interactivePopPanGestureRecognizer.enabled = NO;
    self.navDelegate.interactivePopEdgePanGestureRecognizer.enabled = NO;
    self.navigationBar.hidden = YES;
    
    UIViewController *rootViewController = [self.viewControllers firstObject];
    NavigationView *navigationBar = [[NavigationView alloc]initWithFrame:CGRectMake(0, 0,[UIScreen mainScreen].bounds.size.width, 64)];
    navigationBar.backgroundColor=[UIColor colorWithRed:201/255.0 green:8/255.0 blue:19/255.0 alpha:1];
    [navigationBar leftBtnSheZhiImage:@"" withText:@"" withHidden:NO];
    [navigationBar zhongJianLableSheZhiLable:@"" withZiShiYing:NO withFont:17];
    [navigationBar reghtBtnSheZhiImage:@"" withText:@"" withHidden:NO];
    [rootViewController setNavigationBar:navigationBar];
    [rootViewController.view addSubview:navigationBar];
    [rootViewController setNavigationBar_delegate:rootViewController];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark 重写父类方法

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    NavigationView *navigationBar = [[NavigationView alloc]initWithFrame:CGRectMake(0, 0,[UIScreen mainScreen].bounds.size.width, 64)];
    navigationBar.backgroundColor=[UIColor colorWithRed:201/255.0 green:8/255.0 blue:19/255.0 alpha:1];
    [navigationBar leftBtnSheZhiImage:@"zhiboLeft" withText:@"" withHidden:NO];
    [navigationBar zhongJianLableSheZhiLable:@"" withZiShiYing:NO withFont:17];
    [navigationBar reghtBtnSheZhiImage:@"" withText:@"" withHidden:NO];
    [viewController setNavigationBar:navigationBar];
    [viewController.view addSubview:navigationBar];
    [viewController setNavigationBar_delegate:viewController];

    [super pushViewController:viewController animated:animated];
}

- (UIViewController *)popViewControllerAnimated:(BOOL)animated{
   return [super popViewControllerAnimated:animated];
}

- (NSArray<UIViewController *> *)popToViewController:(UIViewController *)viewController animated:(BOOL)animated{
    return [super popToViewController:viewController animated:animated];
}

- (NSArray<UIViewController *> *)popToRootViewControllerAnimated:(BOOL)animated{
    return [super popToRootViewControllerAnimated:animated];
}

#pragma mark set方法

- (void)setInteractPopPanGestureEnabled:(BOOL)interactPopGestureEnabled{
    self.navDelegate.interactivePopPanGestureRecognizer.enabled = interactPopGestureEnabled;
    if(interactPopGestureEnabled == YES){//与边缘、系统边缘手势互斥
        self.navDelegate.interactivePopEdgePanGestureRecognizer.enabled = !interactPopGestureEnabled;
        self.interactivePopGestureRecognizer.enabled = !interactPopGestureEnabled;
    }else{//同步禁用边缘、系统边缘手势
        self.navDelegate.interactivePopEdgePanGestureRecognizer.enabled = interactPopGestureEnabled;
        self.interactivePopGestureRecognizer.enabled = interactPopGestureEnabled;
    }
    
    _interactPopPanGestureEnabled = interactPopGestureEnabled;
}

- (void)setInteractPopEdgePanGestureEnabled:(BOOL)interactPopEdgePanGestureEnabled{
    self.navDelegate.interactivePopEdgePanGestureRecognizer.enabled = interactPopEdgePanGestureEnabled;
    if(interactPopEdgePanGestureEnabled == YES){//与全屏、系统边缘手势互斥
        self.navDelegate.interactivePopPanGestureRecognizer.enabled = !interactPopEdgePanGestureEnabled;
        self.interactivePopGestureRecognizer.enabled = !interactPopEdgePanGestureEnabled;
    }else{//同步禁用全屏、系统边缘手势
        self.navDelegate.interactivePopEdgePanGestureRecognizer.enabled = interactPopEdgePanGestureEnabled;
        self.interactivePopGestureRecognizer.enabled = interactPopEdgePanGestureEnabled;
    }
    
    _interactPopEdgePanGestureEnabled = interactPopEdgePanGestureEnabled;
}

@end
