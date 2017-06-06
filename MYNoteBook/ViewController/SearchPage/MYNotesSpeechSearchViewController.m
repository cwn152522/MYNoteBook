//
//  MYNotesSpeechSearchViewController.m
//  MYNoteBook
//
//  Created by chenweinan on 16/12/5.
//  Copyright © 2016年 chenweinan. All rights reserved.
//

#import "MYNotesSpeechSearchViewController.h"
#import "Waver.h"
#import "MYSearchHisttoryModel.h"
#import "MYNotesUtility.h"

@interface MYNotesSpeechSearchViewController ()<IFlySpeechRecognizerDelegate>//识别协议

@property (strong, nonatomic) MYSearchHisttoryModel *searchModel;

@property (weak, nonatomic) IBOutlet UIButton *recognizerButton;
@property (strong, nonatomic) IFlySpeechRecognizer *iFlySpeechRecognizer;//不带界面的识别对象
@property (weak, nonatomic) IBOutlet Waver *audioWaverView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityLoadingView;
@property (weak, nonatomic) IBOutlet UILabel *recognizeLabel;
@property (weak, nonatomic) IBOutlet UIImageView *emptyImageView;
@property (weak, nonatomic) IBOutlet UILabel *resultEmptyLabel;
@property (assign, nonatomic) CGFloat audioVolum;

@property (copy, nonatomic) NSString *keyword;

@end

@implementation MYNotesSpeechSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"语音搜索";
    
    _searchModel = [[MYSearchHisttoryModel alloc] init];
    
    [self.resultEmptyLabel setText:@"未搜索到结果\n请说出您的关键词重新搜搜索"];
    
    // Do any additional setup after loading the view.
    
    id target = self.navigationController.navigationController.interactivePopGestureRecognizer.delegate;
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:target action:@selector(handleNavigationTransition:)];
    [self.view addGestureRecognizer:pan];
    self.navigationController.navigationController.interactivePopGestureRecognizer.enabled = NO;
    // Do any additional setup after loading the view.
}

- (void)handleNavigationTransition:(UIPanGestureRecognizer *)gesture{};

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.titleLabel setText:@"请按住说话......"];
    [self.recognizeLabel setHidden:YES];
    [self.activityLoadingView stopAnimating];
    [self.emptyImageView setHidden:YES];
    [self.resultEmptyLabel setHidden:YES];
    
    __weak typeof(self) weakSelf = self;
    self.audioWaverView.waveColor = GLOBAL_COLOR;
    self.audioWaverView.waverLevelCallback = ^(Waver * waver) {
        waver.level = weakSelf.audioVolum;
    };
}

#pragma mark private method

-(void)initRecognizer {
    //单例模式，无UI的实例
    if (_iFlySpeechRecognizer == nil) {
        _iFlySpeechRecognizer = [IFlySpeechRecognizer sharedInstance];//创建语音识别对象
        
        //设置识别参数
        
        //扩展参数
        [_iFlySpeechRecognizer setParameter:@"" forKey:[IFlySpeechConstant PARAMS]];
        
        //设置听写模式(应用领域)
        [_iFlySpeechRecognizer setParameter:@"iat" forKey:[IFlySpeechConstant IFLY_DOMAIN]];

        //设置最长录音时间
        [_iFlySpeechRecognizer setParameter:@"30000" forKey:[IFlySpeechConstant SPEECH_TIMEOUT]];
        //设置后端点
        [_iFlySpeechRecognizer setParameter:@"3000" forKey:[IFlySpeechConstant VAD_EOS]];
        //设置前端点
        [_iFlySpeechRecognizer setParameter:@"3000" forKey:[IFlySpeechConstant VAD_BOS]];
        //网络等待时间
        [_iFlySpeechRecognizer setParameter:@"20000" forKey:[IFlySpeechConstant NET_TIMEOUT]];
        
        //设置采样率，推荐使用16K
        [_iFlySpeechRecognizer setParameter:@"16000" forKey:[IFlySpeechConstant SAMPLE_RATE]];
        
        //设置语言
        [_iFlySpeechRecognizer setParameter:@"zh_cn" forKey:[IFlySpeechConstant LANGUAGE]];
        //设置方言
        [_iFlySpeechRecognizer setParameter:@"mandarin" forKey:[IFlySpeechConstant ACCENT]];
        
        //设置是否返回标点符号
        [_iFlySpeechRecognizer setParameter:@"0" forKey:[IFlySpeechConstant ASR_PTT]];
        
        //设置听写结果格式为json
        [_iFlySpeechRecognizer setParameter:@"json" forKey:[IFlySpeechConstant RESULT_TYPE]];
        
        //设置音频来源为麦克风
        [_iFlySpeechRecognizer setParameter:IFLY_AUDIO_SOURCE_MIC forKey:@"audio_source"];
    }
    
    _iFlySpeechRecognizer.delegate = self;
}

//解析听写json格式的数据
- (NSString *)stringFromJson:(NSString*)params
{
    if (params == NULL) {
        return nil;
    }
    
    NSMutableString *tempStr = [[NSMutableString alloc] initWithString:@""];
    NSDictionary *resultDic  = [NSJSONSerialization JSONObjectWithData:
                                [params dataUsingEncoding:NSUTF8StringEncoding] options:kNilOptions error:nil];
    
    if (resultDic!= nil) {
        NSArray *wordArray = [resultDic objectForKey:@"ws"];
        
        for (int i = 0; i < [wordArray count]; i++) {
            NSDictionary *wsDic = [wordArray objectAtIndex: i];
            NSArray *cwArray = [wsDic objectForKey:@"cw"];
            
            for (int j = 0; j < [cwArray count]; j++) {
                NSDictionary *wDic = [cwArray objectAtIndex:j];
                NSString *str = [wDic objectForKey:@"w"];
                [tempStr appendString: str];
            }
        }
    }
    return tempStr;
}

- (void)requestResult:(NSString *)keyWords {
    [self searchManagerLoading];
    
    NSArray *array = [[MYNotesUtility defaultUtility] filterArrayWithPredicate:[NSPredicate predicateWithFormat:@"(ParentID > 0) AND (Name CONTAINS[c] %@)", keyWords]];
     [self hideRecongizering];
    if([array count]){
        [self performSelector:@selector(popViewController) withObject:nil afterDelay:0.33];
    }else{
         [self showEmptyResult];
        return;
    }
}

- (void)popViewController{
    if(self.resultBlock)
        self.resultBlock(YES, self.keyword);
    [self searchManagerAddKeywords:self.keyword];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)hideRecongizering {
    [self.activityLoadingView stopAnimating];
    [self.recognizeLabel setHidden:YES];
}

- (void)showRecongizering {
    [self.activityLoadingView startAnimating];
    [self.recognizeLabel setHidden:NO];
}

- (void)showEmptyResult {
    [self.resultEmptyLabel setHidden:NO];
    [self.emptyImageView setHidden:NO];
}

- (void)hidenEmptyResult {
    [self.resultEmptyLabel setHidden:YES];
    [self.emptyImageView setHidden:YES];
}

#pragma mark iflyRecognzerDelegate

//识别会话结束返回代理
- (void)onError:(IFlySpeechError *)errorCode {
    
    if (errorCode.errorCode != 0) {
        [self hideRecongizering];
        [self.titleLabel setText:@"请按住说话......"];
        
        UIAlertView *alterView = [[UIAlertView alloc] initWithTitle:@"提示" message:errorCode.errorDesc delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alterView show];
        
        return ;
    }
}

//识别结果返回代理
- (void)onResults:(NSArray *)results isLast:(BOOL)isLast {
    if (isLast)
        return ;
    
    NSMutableString *resultString = [[NSMutableString alloc] init];
    NSDictionary *dic = results[0];
    for (NSString *key in dic)
        [resultString appendFormat:@"%@",key];
    
    NSString *resultFromJson =  [self stringFromJson:resultString];

    if(resultString > 0){
        [self.titleLabel setText:resultFromJson];
        self.keyword = resultFromJson;
        [self requestResult:resultFromJson];
    }else{
        [self hideRecongizering];
        [self showEmptyResult];
    }
}

//音量回调函数
- (void)onVolumeChanged:(int)volume {
    self.audioVolum = volume/50.0f;
}

//开始录音回调
- (void)onBeginOfSpeech{}

//停止录音回调
- (void)onEndOfSpeech{}

//会话取消回调
- (void)onCancel{}

#pragma mark EventResponed

- (IBAction)onStartRecognizer:(id)sender {
    [self.audioWaverView setHidden:NO];
     [self showRecongizering];
    [self hidenEmptyResult];
    
    if(_iFlySpeechRecognizer == nil)
        [self initRecognizer];//初始化识别对象
    
    if (_iFlySpeechRecognizer.isListening)//正在识别
        return;

    [_iFlySpeechRecognizer cancel];//取消之前服务
    
    BOOL ret = [_iFlySpeechRecognizer startListening];//启动识别服务
    
    if (!ret) {
        UIAlertView *alterView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"语音识别失败" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alterView show];
    }
}

- (IBAction)onEndRecognizer:(id)sender {
    [self.audioWaverView setHidden:YES];
     [self hideRecongizering];
    
    self.audioVolum = 0.0f;
    [_iFlySpeechRecognizer stopListening];//关闭识别服务
}

//搜索模块加载数据
- (void)searchManagerLoading {
    [_searchModel loadHistoryData];
}

- (void)searchManagerAddKeywords:(NSString *)keywords {
    [_searchModel addHistory:keywords];
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
