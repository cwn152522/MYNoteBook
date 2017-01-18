//
//  indexPageViewController.m
//  MYNoteBook
//
//  Created by chenweinan on 16/11/4.
//  Copyright © 2016年 chenweinan. All rights reserved.
//

#import "IndexPageViewController.h"

@interface IndexPageViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *helloImage;

@end

@implementation IndexPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    __weak typeof(self) weakSelf = self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [UIView transitionWithView:self.view duration:0.1 options:UIViewAnimationOptionCurveLinear animations:^{
            
        } completion:nil];
        CATransition *animation = [CATransition animation];
        animation.type = @"fade";
        animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
        animation.subtype = kCATransitionFromBottom;
        animation.duration = 0.55;
        [weakSelf.view.window.layer addAnimation:animation forKey:nil];
        [weakSelf performSegueWithIdentifier:@"hello" sender:nil];
    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
