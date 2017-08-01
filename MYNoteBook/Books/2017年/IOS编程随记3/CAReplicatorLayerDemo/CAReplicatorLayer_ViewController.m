//
//  CAReplicatorLayer_ViewController.m
//  MYNoteBook
//
//  Created by 伟南 陈 on 2017/8/1.
//  Copyright © 2017年 chenweinan. All rights reserved.
//

#import "CAReplicatorLayer_ViewController.h"
#import "LoadingView.h"
#import "LoadingView1.h"

@interface CAReplicatorLayer_ViewController ()

@property (weak, nonatomic) IBOutlet LoadingView *loadingView1;
@property (weak, nonatomic) IBOutlet LoadingView1 *loadingView2;

@end

@implementation CAReplicatorLayer_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.loadingView1 startAnimation];
    [self.loadingView2 startAnimation];
    // Do any additional setup after loading the view from its nib.
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
