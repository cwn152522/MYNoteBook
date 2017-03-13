//
//  ViewController_PropertyAnimator.m
//  MYNoteBook
//
//  Created by chenweinan on 16/11/27.
//  Copyright © 2016年 chenweinan. All rights reserved.
//

#import "ViewController_PropertyAnimator.h"

@interface ViewController_PropertyAnimator ()

@property (weak, nonatomic) IBOutlet UIView *animatedView;
//@property (strong, nonatomic) UIViewPropertyAnimator *animator;

@end

@implementation ViewController_PropertyAnimator

- (void)viewDidLoad {
    [super viewDidLoad];
//    __weak typeof(self) weakSelf = self;
    //初始化一个属性动画器
//    _animator = [[UIViewPropertyAnimator alloc] initWithDuration:4 curve:UIViewAnimationCurveLinear animations:^{
//        weakSelf.animatedView.bounds = CGRectMake(0, 0, 200, 200);
//    }];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onClickStartAnimating:(id)sender {
//    [_animator startAnimation];
}

- (IBAction)onClickPauseAnimating:(id)sender {
//    [_animator pauseAnimation];
}

- (IBAction)onClickContinueAnimating:(id)sender {
//    UISpringTimingParameters *sp = [[UISpringTimingParameters alloc] initWithDampingRatio:0.6];//弹簧阻尼系数
    //        UICubicTimingParameters *sp1 = [[UICubicTimingParameters alloc] initWithAnimationCurve:UIViewAnimationCurveLinear];
//    [_animator continueAnimationWithTimingParameters:sp durationFactor:0];
}

- (IBAction)onClickStopAnimating:(id)sender {
//    [_animator stopAnimation:NO];//当前动画器是否不需结束，YES则animator马上销毁，No则进入stop状态，等待调用下面方法确定结束位置
//    [_animator finishAnimationAtPosition:UIViewAnimatingPositionEnd];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
