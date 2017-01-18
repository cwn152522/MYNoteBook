//
//  ViewController_BannerScrollView.m
//  MYNoteBook
//
//  Created by chenweinan on 16/11/26.
//  Copyright © 2016年 chenweinan. All rights reserved.
//

#import "ViewController_BannerScrollView.h"
#import "MYBannerScrollView.h"

@interface ViewController_BannerScrollView ()

@property (weak, nonatomic) IBOutlet MYBannerScrollView *bannerScrollView;

@end

@implementation ViewController_BannerScrollView

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"图片轮播";
    // Do any additional setup after loading the view.
}

- (void)viewDidLayoutSubviews{
    NSString *imageURL1 = @"http://www.uc129.com/uploads/allimg/150428/1-15042Q04030.jpg";
    NSString *imageURL2 = @"http://www.people.com.cn/h/pic/20111031/99/15317457967897249011.jpg";
    NSString *imageURL3 = @"http://school.indexedu.com/data/uploads/picture/westminster_1/20140117144515.jpg";
    //    NSString *imageURL1 = @"morenbanner";
    //    NSString *imageURL2 = @"morenbanner";
    //    NSString *imageURL3 = @"morenbanner";
    
//    _bannerview = [[MYBannerScrollView alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, 164*[[UIScreen mainScreen] bounds].size.width/360)];
    [_bannerScrollView setAutoDuration:5];
    [_bannerScrollView loadImages:@[imageURL1, imageURL2, imageURL3] estimateSize:_bannerScrollView.frame.size];
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
