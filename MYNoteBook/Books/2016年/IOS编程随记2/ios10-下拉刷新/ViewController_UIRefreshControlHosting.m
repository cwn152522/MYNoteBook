//
//  ViewController_UIRefreshControlHosting.m
//  MYNoteBook
//
//  Created by chenweinan on 16/11/27.
//  Copyright © 2016年 chenweinan. All rights reserved.
//

#import "ViewController_UIRefreshControlHosting.h"

@interface ViewController_UIRefreshControlHosting ()

@property (strong, nonatomic) UIScrollView *scrollView;

@end

@implementation ViewController_UIRefreshControlHosting

- (void)viewDidLoad {
    [super viewDidLoad];
    //初始化scrollView
    _scrollView = [[UIScrollView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _scrollView.frame.size.width, _scrollView.frame.size.height)];
    [_scrollView addSubview:contentView];
    [self.view addSubview:_scrollView];
    contentView.backgroundColor = [UIColor purpleColor];
    _scrollView.contentSize = CGSizeMake(contentView.frame.size.width, contentView.frame.size.height + 200);
    
    //下拉刷新控件逻辑处理
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    refreshControl.attributedTitle = [[NSAttributedString alloc] initWithString:@"下拉刷新" attributes:@{NSForegroundColorAttributeName:[UIColor redColor], NSFontAttributeName:[UIFont systemFontOfSize:15]}];
    [refreshControl addTarget:self action:@selector(refresh) forControlEvents:UIControlEventValueChanged];
//    _scrollView.refreshControl = refreshControl;
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)refresh{
    NSLog(@"刷新控件执行了");
//    __weak typeof(self) weakSelf = self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [weakSelf.scrollView.refreshControl endRefreshing];
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
