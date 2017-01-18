//
//  ViewControllerV2.m
//  MYImageViewAnimation
//
//  Created by chenweinan on 16/10/25.
//  Copyright © 2016年 chenweinan. All rights reserved.
//

#import "ViewControllerV2.h"
#import "UIView+YXHView.h"

@interface ViewControllerV2 ()

@property (strong, nonatomic) UIView *loadingView;
@property (strong, nonatomic) UIImageView *loadingImageView;
@property (strong, nonatomic) UILabel *loadingLabel;
@property (strong, nonatomic) NSArray *loadingImages;


@end

@implementation ViewControllerV2

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"imageView帧动画";
    [self.view setBackgroundColor:[UIColor whiteColor]];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self beginLoadingAnimation];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIView *)loadingView{
    if(!_loadingView){
        _loadingView = [[UIView alloc] init];
        [_loadingView setTranslatesAutoresizingMaskIntoConstraints:NO];
        _loadingView.backgroundColor = [UIColor whiteColor];
    }
    return _loadingView;
}

- (UIImageView *)loadingImageView{
    if(!_loadingImageView){
        _loadingImageView = [[UIImageView alloc] init];
        _loadingImages = @[[UIImage imageNamed:@"loading0001"], [UIImage imageNamed:@"loading0002"], [UIImage imageNamed:@"loading0003"]];
        _loadingImageView.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _loadingImageView;
}

- (UILabel *)loadingLabel{
    if(!_loadingLabel){
        _loadingLabel = [[UILabel alloc] init];
        _loadingLabel.translatesAutoresizingMaskIntoConstraints = NO;
        [_loadingLabel setTextColor:[UIColor blackColor]];
        [_loadingLabel setText:@"正在努力加载..."];
    }
    return _loadingLabel;
}

- (void)beginLoadingAnimation{
    if(_loadingView && _loadingView.alpha == 0)
        return;
    
    [self.loadingView removeFromSuperview];
    
    [self.view addSubview:self.loadingView];
    [_loadingView setLayoutTopFromSuperViewWithConstant:0];
    [_loadingView setLayoutBottomFromSuperViewWithConstant:0];
    [_loadingView setLayoutLeftFromSuperViewWithConstant:0];
    [_loadingView setLayoutRightFromSuperViewWithConstant:0];
    
    
    [self.loadingView addSubview:self.loadingImageView];
    [_loadingImageView setLayoutCenterX:self.loadingView];
    [_loadingImageView setLayoutCenterY:self.loadingView constant:-50];
    [_loadingImageView setLayoutWidth:85];
    [_loadingImageView setLayoutHeight:85];
    
    
    [self.loadingView addSubview:self.loadingLabel];
    [_loadingLabel setLayoutCenterX:_loadingImageView];
    [_loadingLabel setLayoutTop:_loadingImageView multiplier:1 constant:20];
    
    _loadingImageView.animationImages = _loadingImages;
    _loadingImageView.animationDuration = 0.133;
    _loadingImageView.animationRepeatCount = 0;
    
    [self.view layoutIfNeeded];
    [self.view bringSubviewToFront:_loadingView];
    
    [_loadingImageView startAnimating];
    
}

- (void)endLoadingAnimation:(NSTimeInterval)timeOutSinceNow{
    if(_loadingView.alpha == 0)
        return;
    [self performSelector:@selector(removeLoadingView) withObject:nil afterDelay:timeOutSinceNow];
}

- (void)removeLoadingView{
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:0.33 animations:^{
        weakSelf.loadingView.alpha = 0;
    }completion:^(BOOL finished) {
        [weakSelf.loadingImageView stopAnimating];
        [weakSelf.loadingImageView removeFromSuperview];
        [weakSelf.loadingLabel removeFromSuperview];
        [weakSelf.loadingView removeFromSuperview];
    }];
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
