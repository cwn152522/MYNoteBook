//
//  ViewController_SliderView.m
//  MYNoteBook
//
//  Created by chenweinan on 16/11/27.
//  Copyright © 2016年 chenweinan. All rights reserved.
//

#import "ViewController_SliderView.h"
#import "MYSliderView.h"

@interface ViewController_SliderView ()<MYSliderViewDatasource, MYSliderViewDelegate>

@property (weak, nonatomic) IBOutlet MYSliderView *sliderView;
@property (strong, nonatomic) NSCache *viewControllerCaches;//所有控制器存储在cache中，仅第一次使用时才load视图，除非控制器nscache回收了，才会第二次load视图

@property (weak, nonatomic) IBOutlet UITextView *logTextView;

@property (copy, nonatomic) NSString *logString;

@end

@implementation ViewController_SliderView

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"MYSliderView";
    
    [_logTextView setText:@""];
    _logString = @"";
    _logTextView.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.7];
    
    _viewControllerCaches = [[NSCache alloc] init];
    _viewControllerCaches.countLimit = 3;
    _sliderView.dataSource = self;
    _sliderView.delegate = self;
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"随机列表" style:UIBarButtonItemStylePlain target:self action:@selector(onClickNext)];
    self.navigationItem.rightBarButtonItem = item;
}

- (void)showLog:(NSString *)logInfo{
    _logString = [NSString stringWithFormat:@"%@\n", [_logString stringByAppendingString:logInfo]];
    [_logTextView setText:_logString];
    [_logTextView scrollRangeToVisible:NSMakeRange(_logString.length - 1, 1)];
}

- (void)onClickNext{
    NSInteger number = [self numberOfViewControllersInSliderView:self.sliderView];
    NSInteger index = arc4random() % number;
    [self.sliderView showViewController:index];
}

#pragma mark MYSliderViewDatasource

- (UIViewController *)baseViewControllerOfSiderView:(MYSliderView *)sliderView{
    return self;
}

- (NSInteger)numberOfViewControllersInSliderView:(MYSliderView *)sliderView{
    return 3;
}

- (UIViewController *)sliderView:(MYSliderView *)sliderView viewControllerAtIndex:(NSInteger)index{
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"SliderView" bundle:nil];
    UIViewController *viewcontroller = [self.viewControllerCaches objectForKey:[NSString stringWithFormat:@"%ld",index]];//尽量objectForKey，不存在返回nil，而valueForKey采用kvc取值，找不到方法实现会抛出异常
    switch (index) {
        case 0:{
            if(viewcontroller == nil){
                viewcontroller = [storyBoard instantiateViewControllerWithIdentifier:@"first"];
                [self.viewControllerCaches setObject:viewcontroller forKey:[NSString stringWithFormat:@"%ld",index]];
            }
        }
            break;
        case 1:{
            if(viewcontroller == nil){
                viewcontroller = [storyBoard instantiateViewControllerWithIdentifier:@"second"];
                [self.viewControllerCaches setObject:viewcontroller forKey:[NSString stringWithFormat:@"%ld",index]];
            }
        }
            break;
        case 2:{
            if(viewcontroller == nil){
                viewcontroller = [storyBoard instantiateViewControllerWithIdentifier:@"third"];
                [self.viewControllerCaches setObject:viewcontroller forKey:[NSString stringWithFormat:@"%ld",index]];
            }
        }
        default:
            break;
    }
    return viewcontroller;
}

#pragma mark MYSliderViewDelegate

- (void)sliderView:(MYSliderView *)sliderView switchingFrom:(NSInteger)fromIndex to:(NSInteger)toIndex percent:(CGFloat)percent{
    //    NSLog(@"从第%ld个视图到第%ld个视图,当前进度：%@%.2f", fromIndex, toIndex, @"%",percent * 100);
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
