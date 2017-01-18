//
//  MYBaseTipsViewController.m
//  MYCloud
//
//  Created by 陈伟南 on 16/3/17.
//  Copyright © 2016年 Jam. All rights reserved.
//

#import "MYBaseTipsViewController.h"
#import "MYTipsCoverView.h"

@interface MYBaseTipsViewController ()

@property (nonatomic, strong) UIView *middleView;

@property (nonatomic, strong) MYTipsCoverView *backgroundView;
@property (nonatomic, strong) UITapGestureRecognizer *tapGesture;

@end

@implementation MYBaseTipsViewController

- (MYTipsCoverView *)backgroundView {
    if (!_backgroundView) {
        _backgroundView = [[MYTipsCoverView alloc] initWithBlur:self.isBlur];
    }
    return _backgroundView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.backgroundView.userInteractionEnabled = YES;
    _tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onBackgroundClicked)];
    _tapGesture.numberOfTapsRequired = 1;
    [self.backgroundView addGestureRecognizer:_tapGesture];  
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.view setBackgroundColor:[UIColor clearColor]];
    [self.view insertSubview:self.backgroundView atIndex:0];
    self.backgroundView.alpha = 0;
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        weakSelf.backgroundView.alpha = 1;
    } completion:^(BOOL finished) {
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)showViewWithAnimation:(UIView *)animationView {
    self.middleView = animationView;
    animationView.alpha = 0.0f;
    
    __weak typeof(self) selfWeak = self;
    [UIView animateWithDuration:0.05 delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        selfWeak.backgroundView.alpha = 1.0;
    } completion:^(BOOL finished) {
        CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
        scaleAnimation.fromValue = [NSNumber numberWithFloat:1.0];
        scaleAnimation.toValue = [NSNumber numberWithFloat:0.0];
        scaleAnimation.fillMode = kCAFillModeForwards;
        scaleAnimation.removedOnCompletion = NO;
        scaleAnimation.duration = 0.05;
        scaleAnimation.delegate = self;
        [animationView.layer addAnimation:scaleAnimation forKey:@"scales"];
    }];
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    self.middleView.alpha = 1.0f;
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
    animation.duration = 0.2;
    animation.values = @[@0, @0.41, @0.82, @1.0];
    animation.keyTimes = @[@0, @(3.0/6.0), @(5.0/6.0), @1];
    animation.additive = YES;
    animation.fillMode = kCAFillModeForwards;
    animation.removedOnCompletion = NO;
    [self.middleView.layer addAnimation:animation forKey:@"scale"];
}

- (void)insertIntoParentViewController:(UIViewController *)parentViewController {
    [parentViewController addChildViewController:self];
    [self.view setTranslatesAutoresizingMaskIntoConstraints:NO];
    [parentViewController.view addSubview:self.view];

    NSDictionary *layoutViews = @{@"view":self.view};
    NSArray *constraints_H = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[view]|" options:0 metrics:nil views:layoutViews];
    NSArray *constraints_V = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|[view]|" options:0 metrics:nil views:layoutViews];
    [parentViewController.view addConstraints:constraints_H];
    [parentViewController.view addConstraints:constraints_V];

    [self willMoveToParentViewController:parentViewController];
    [self beginAppearanceTransition:YES animated:NO];
    [self endAppearanceTransition];
}

- (void)onCloseWithAnimationDuration:(CGFloat)duration {
    if(duration < 0)
        duration = 0.33;
    __weak typeof(self) selfWeak = self;
    [UIView animateWithDuration:duration
                          delay:0.0
                        options: UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         selfWeak.view.alpha = 0;
                     }
                     completion:^(BOOL finished){
                         [selfWeak willMoveToParentViewController:nil];
                         [selfWeak.view removeFromSuperview];
                         [selfWeak removeFromParentViewController];
                     }];
}

- (void)onBackgroundClicked{
    [self onCloseWithAnimationDuration:0.33];
}

- (void)setBlurRadius:(CGFloat)blurRadius {
    _blurRadius = blurRadius;
    self.backgroundView.isBlur = YES;
    self.backgroundView.blurRadius= blurRadius;
}

- (void)setBlurColor:(UIColor *)blurColor {
    _blurColor = blurColor;
    self.backgroundView.isBlur = YES;
    self.backgroundView.blurColor = blurColor;
}

- (void)setBackgroundEnable:(BOOL)enable {
    self.backgroundView.userInteractionEnabled = enable;
}

- (void)setTarget:(id)target tapSEL:(SEL)tapAction{
    [self.tapGesture removeTarget:self action:@selector(onBackgroundClicked)];
    [self.tapGesture addTarget:target action:tapAction];
}

@end
