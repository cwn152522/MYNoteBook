//
//  MYNoteDetailWebViewController.m
//  MYNoteBook
//
//  Created by chenweinan on 16/11/28.
//  Copyright © 2016年 chenweinan. All rights reserved.
//

#import "MYNoteDetailWebViewController.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import <WebKit/WebKit.h>

@interface MYNoteDetailWebViewController ()<UIWebViewDelegate>

@property (strong, nonatomic) UIView *webView;

@end

@implementation MYNoteDetailWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"笔记详情";
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self configWebView];
    
    
    id target = self.navigationController.navigationController.interactivePopGestureRecognizer.delegate;
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:target action:@selector(handleNavigationTransition:)];
    [self.view addGestureRecognizer:pan];
    self.navigationController.navigationController.interactivePopGestureRecognizer.enabled = NO;
    // Do any additional setup after loading the view.
}

- (void)handleNavigationTransition:(UIPanGestureRecognizer *)gesture{};

- (void)viewWillDisappear:(BOOL)animated{
    _webView = nil;
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
#ifdef DEBUG
    [[BaiduMobStat defaultStat] pageviewStartWithName:self.title];
#endif
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
#ifndef DEBUG
    [[BaiduMobStat defaultStat] pageviewEndWithName:self.title];
#endif
}

- (void)dealloc{
    DLog(@"%@页面正常注销", NSStringFromClass([self class]));
}

- (void)configWebView{
    if([UIDevice currentDevice].systemVersion.floatValue > 7.0){
        self.webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, WINDOW_WIDTH, WINDOW_HEIGHT - 64)];
//        (WKWebView *)self.webView  = YES;
    }else{
    self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, WINDOW_WIDTH, WINDOW_HEIGHT - 64)];
        [(UIWebView *)self.webView setScalesPageToFit:YES];
    }
    [self.view addSubview:self.webView];
    
    
    NSURL *fileUrl;
    if(_filePath){
        fileUrl = [NSURL fileURLWithPath:_filePath];
    }
    if([self.webView isMemberOfClass:[WKWebView class]])
        [(WKWebView *)self.webView loadRequest:[NSURLRequest requestWithURL:fileUrl]];
    else
        [(UIWebView *)self.webView loadRequest:[NSURLRequest requestWithURL:fileUrl]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSString *)getContentTypeWithFilePath:(NSString *)filePath{
    if (![[NSFileManager defaultManager] fileExistsAtPath:filePath])
        return nil;
    
    CFStringRef UTI = UTTypeCreatePreferredIdentifierForTag(kUTTagClassFilenameExtension, (__bridge CFStringRef)[filePath pathExtension], NULL);
    CFStringRef MIMEType = UTTypeCopyPreferredTagWithClass (UTI, kUTTagClassMIMEType);
    CFRelease(UTI);
    if (!MIMEType)
        return @"application/octet-stream";
    
    return (__bridge NSString *)(MIMEType);
}

#pragma mark UIWebViewDelegate

- (void)webViewDidFinishLoad:(UIWebView *)webView{
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
