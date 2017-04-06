//
//  ViewController_UMSocial.m
//  MYNoteBook
//
//  Created by chenweinan on 16/12/16.
//  Copyright © 2016年 chenweinan. All rights reserved.
//

#import "ViewController_UMSocial.h"
#import "MYUShareView.h"
#import "MYUShareManager.h"
#import "MYULoginManager.h"

@interface ViewController_UMSocial ()<UIAlertViewDelegate>

@property (strong, nonatomic) MYUShareView *shareView;
@property (assign, nonatomic) UMSocialPlatformType selectType;

@end

@implementation ViewController_UMSocial

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"友盟分享和授权测试";
    // Do any additional setup after loading the view.
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

- (IBAction)onClickShare:(UIButton *)sender {
    if(!_shareView){
        CGFloat btnWidth = ([[UIScreen mainScreen] bounds].size.width - 0 - 0)/5;
        _shareView = [[MYUShareView alloc]initWithFrame:CGRectMake(0,[[UIScreen mainScreen] bounds].size.height - btnWidth * 2 - 10 - 10 - 85,[[UIScreen mainScreen] bounds].size.width, btnWidth * 2 + 10 + 10 + 85)];
    }
    
    NSArray *btnImages = @[@"wo_wdezhanewm_qq",@"wo_wdezhanewm_komgjian",@"wo_wdezhanewm_weixin",@"wo_wdezhanewm_pengyouquan",@"fx_duanxin"];
    NSArray *btnTitles = @[@"QQ", @"QQ空间", @"微信", @"朋友圈",@"短信"];
    
    [_shareView configShareViewWithButtons:btnTitles images:btnImages lineBtnsCount:4 lineSpace:10 edgeInset:UIEdgeInsetsMake(20, 0, 0, 0) imageWidth:50];
    [_shareView show];
    
    [self testShare];
}

- (IBAction)onClickAuthorization:(id)sender {
    if(!_shareView){
        _shareView = [[MYUShareView alloc]initWithFrame:CGRectMake(0,[[UIScreen mainScreen] bounds].size.height - 245,[[UIScreen mainScreen] bounds].size.width, 245)];
    }
    
    NSArray *btnImages = @[@"wo_wdezhanewm_qq",@"wo_wdezhanewm_komgjian",@"wo_wdezhanewm_weixin",@"wo_wdezhanewm_pengyouquan",@"fx_duanxin"];
    NSArray *btnTitles = @[@"QQ", @"QQ空间", @"微信", @"朋友圈",@"短信"];
    
    [_shareView configShareViewWithButtons:btnTitles images:btnImages lineBtnsCount:4 lineSpace:10 edgeInset:UIEdgeInsetsMake(20, 0, 0, 0) imageWidth:50];
    [_shareView show];
    
    [self testLogin];
}

#pragma mark private methods

- (void)shareDataWithPlatform:(UMSocialPlatformType)platformType
{
    [[MYUShareManager defaultManager] setTitle: @"分享的标题"];
    [[MYUShareManager defaultManager] setDescr: @"分享的概述"];
    [[MYUShareManager defaultManager] setThumbImage:[UIImage imageNamed:@"image"]];
    
    int random = arc4random() % 4;
    switch (random) {
        case 0://文本分享
            [[MYUShareManager defaultManager] shareText:@"http://m.mayiw.com" platformType:platformType currentVC:self completion:^(id result, NSError *error) {
                NSLog(@"文本分享结果\n%@\n%@", result, error);
            }];
            break;
        case 1://图片分享
            [[MYUShareManager defaultManager] shareImage:@"https://dev.umeng.com/images/tab2_1.png" platformType:platformType currentVC:self completion:^(id result, NSError *error) {
                NSLog(@"图片分享结果\n%@\n%@", result, error);
            }];
            break;
        case 2://音乐分享
            [[MYUShareManager defaultManager] shareMusicUrl:@"http://music.huoxing.com/upload/20130330/1364651263157_1085.mp3" platformType:platformType currentVC:self completion:^(id result, NSError *error) {
                NSLog(@"音乐分享结果\n%@\n%@", result, error);
            }];
            break;
        case 3://视频分享
            [[MYUShareManager defaultManager] shareVideoUrl:@"http://video.sina.com.cn/p/sports/cba/v/2013-10-22/144463050817.html" platformType:platformType currentVC:self completion:^(id result, NSError *error) {
                NSLog(@"视频分享结果%@\n%@", result, error);
            }];
            break;
        default:
            break;
    }
}

- (void)testShare{
    __weak typeof(self) weakSelf = self;
    _shareView.shareBtnClickdBlock = ^(NSInteger btnTag){
        if(btnTag == 5)//取消按钮，直接关闭分享视图
            [weakSelf.shareView hide];
        else{
            [weakSelf
             .shareView hideWithHiddenBlock:^(BOOL hasHidden) {//分享按钮，在分享视图完全移除后进行第三方跳转
                 switch (btnTag) {
                     case 0:
                         [weakSelf shareDataWithPlatform:UMSocialPlatformType_QQ];
                         break;
                     case 1:
                         [weakSelf shareDataWithPlatform:UMSocialPlatformType_Qzone];
                         break;
                     case 2:
                         [weakSelf shareDataWithPlatform:UMSocialPlatformType_WechatSession];
                         break;
                     case 3:
                         [weakSelf shareDataWithPlatform:UMSocialPlatformType_WechatTimeLine];
                         break;
                     case 4:
                         [weakSelf shareDataWithPlatform:UMSocialPlatformType_Sms];
                         break;
                         
                     default:
                         break;
                 }
             }];
        }
    };
}


- (void)testLogin{
    __weak typeof(self) weakSelf = self;
    _shareView.shareBtnClickdBlock = ^(NSInteger btnTag){
        if(btnTag == 5)//取消按钮，直接关闭分享视图
            [weakSelf.shareView hide];
        else{
            __block UMSocialPlatformType type;
            [weakSelf
             .shareView hideWithHiddenBlock:^(BOOL hasHidden) {//分享按钮，在分享视图完全移除后进行第三方跳转
                 switch (btnTag) {
                     case 0:
                         type = UMSocialPlatformType_QQ;
                         break;
                     case 1:
                         type = UMSocialPlatformType_Qzone;
                         break;
                     case 2:
                         type = UMSocialPlatformType_WechatSession;
                         break;
                     case 3:
                         type = UMSocialPlatformType_WechatTimeLine;
                         break;
                     case 4:
                         type = UMSocialPlatformType_Sms;
                         break;
                         
                     default:
                         break;
                 }
                 
                 if([[MYULoginManager defaultManager] isAuth:type]){
                     [[[UIAlertView alloc] initWithTitle:@"提示" message:@"是否取消对该平台的授权" delegate:weakSelf cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil] show];
                     _selectType = type;
                 }else{
                     [[MYULoginManager defaultManager] authWithPlatform:type currentVC:weakSelf completion:^(UMSocialAuthResponse *result, NSError *error) {
                         NSLog(@"%@\n%@", result, error);
                     }];
                 }
             }];
        }
    };
}

#pragma mark UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(buttonIndex == 1){
        [[MYULoginManager defaultManager] cancelAuthWithPlatform:_selectType completion:^(id result, NSError *error) {
            NSLog(@"%@", error);
        }];
    }
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
