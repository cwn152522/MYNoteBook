//
//  ViewController_ColorfulProgressView.m
//  MYNoteBook
//
//  Created by chenweinan on 16/11/26.
//  Copyright © 2016年 chenweinan. All rights reserved.
//

#import "ViewController_ColorfulProgressView.h"
#import "MYColorfulCircleProgressView.h"
#import "MYNormalCircleProgressView.h"
#import "MYCustomCircleProgressView.h"

@interface ViewController_ColorfulProgressView ()<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet MYColorfulCircleProgressView *progressView;
@property (weak, nonatomic) IBOutlet MYNormalCircleProgressView *normalCircleProgressView;
@property (weak, nonatomic) IBOutlet MYCustomCircleProgressView *customCircleProgressView;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ViewController_ColorfulProgressView

- (void)viewDidLoad {
    [super viewDidLoad];
    [_progressView setAutoAnimating:NO];
    self.title = @"弧形进度条";
    // Do any additional setup after loading the view.
}

- (IBAction)onClickStopAnimating:(id)sender {
    [_normalCircleProgressView stopAnimating];
    [_progressView stopAnimating];
    [_customCircleProgressView stopAnimating];
}
- (IBAction)onClickResumeAnimating:(id)sender {
    [_normalCircleProgressView startAnimating];
    [_progressView beginAnimating];
    [_customCircleProgressView startAnimating];
}

#pragma mark UITableViewDatasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 20;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell;
    cell = [tableView dequeueReusableCellWithIdentifier:@"aaa"];
    if(cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"aaa"];
    }
    [cell.textLabel setText:@"hahaha"];
    return cell;
}

#pragma mark ScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat contentOffsetY = scrollView.contentOffset.y;
    CGFloat progress = -1.0 * contentOffsetY / 44;
    if(!_progressView.isLoading){
        [_progressView setProgress:progress];
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    __weak typeof(self) weakSelf = self;
    CGFloat progress = -1.0 * scrollView.contentOffset.y / 44;
    if(!_progressView.isLoading){
        if(progress >= 1){
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [weakSelf.progressView stopAnimating];
                [weakSelf.normalCircleProgressView stopAnimating];
                [weakSelf.customCircleProgressView stopAnimating];
            });
            [weakSelf.progressView beginAnimating];
            [weakSelf.normalCircleProgressView startAnimating];
            [weakSelf.customCircleProgressView startAnimating];
        }
    }
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
