//
//  RunHorseLampViewController.m
//  MYNoteBook
//
//  Created by chenweinan on 17/4/3.
//  Copyright © 2017年 chenweinan. All rights reserved.
//

#import "RunHorseLampViewController.h"
#import "RunHorseLampView.h"
#import "UIView+CWNView.h"

@interface RunHorseLampViewController ()

@property (strong, nonatomic) RunHorseLampView *lampView;//跑马灯

@end

@implementation RunHorseLampViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configNavigationBar];
    
    
    __weak typeof(self) weakSelf = self;
    [self.view addSubview:self.lampView];
    [self.lampView cwn_makeConstraints:^(UIView *maker) {
        maker.centerXtoSuper(0).centerYtoSuper(0).width(weakSelf.view.frame.size.width).height(30);
    }];
    
    [self.lampView startRuning:[NSString stringWithFormat:@"%@", @"测试啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊哦哦哦哦                      "]];
    
    [self.lampView setRunHourseLampViewClickBlock:^{
    }];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

- (void)configNavigationBar{
    self.title = @"跑马灯";
    
    id target = self.navigationController.navigationController.interactivePopGestureRecognizer.delegate;
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:target action:@selector(handleNavigationTransition:)];
    [self.view addGestureRecognizer:pan];
    self.navigationController.navigationController.interactivePopGestureRecognizer.enabled = NO;
    // Do any additional setup after loading the view.
}

- (void)handleNavigationTransition:(UIPanGestureRecognizer *)gesture{};

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (RunHorseLampView *)lampView{
    if(!_lampView){
        _lampView = [[RunHorseLampView alloc] init];
    }
    return _lampView;
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
