//
//  ViewController_SpeechAudioBuffer.m
//  MYNoteBook
//
//  Created by chenweinan on 16/11/27.
//  Copyright © 2016年 chenweinan. All rights reserved.
//

#import "ViewController_SpeechAudioBuffer.h"
//#import <Speech/Speech.h>
#import <AVFoundation/AVFoundation.h>

@interface ViewController_SpeechAudioBuffer ()//<SFSpeechRecognizerDelegate>

@property (weak, nonatomic) IBOutlet UILabel *tipsLabel;
@property (weak, nonatomic) IBOutlet UIButton *recognizingButton;
@property (weak, nonatomic) IBOutlet UITextField *inputTextField;

@property (strong, nonatomic) AVAudioEngine *audioEngine;//引用语音引擎，负责音频输入
//@property (strong, nonatomic) SFSpeechRecognizer *recognizer;//负责发起语音识别请求，为语音识别器指定一个音频输入源
//@property (strong, nonatomic) SFSpeechAudioBufferRecognitionRequest *audioBufferRecognizerRequest;
//@property (strong, nonatomic) SFSpeechRecognitionTask *recognitionTask;//用於保存發起語音识别结果。通過這個對象，可以取消或中止當前的語音識別任務。

@end

@implementation ViewController_SpeechAudioBuffer

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _recognizingButton.enabled = NO;
    
//    _recognizer = [[SFSpeechRecognizer alloc] initWithLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"]];
//    _recognizer.delegate = self;
    _audioEngine = [[AVAudioEngine alloc] init];
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        AVAudioSession * session = [AVAudioSession sharedInstance];
        [session setCategory:AVAudioSessionCategoryRecord error:nil];
        [session setMode:AVAudioSessionModeMeasurement error:nil];
        [session setActive:YES withOptions:AVAudioSessionSetActiveOptionNotifyOthersOnDeactivation
                     error:nil];
    });
    
//    __weak typeof(self) weakSelf = self;
//    [SFSpeechRecognizer requestAuthorization:^(SFSpeechRecognizerAuthorizationStatus status) {
//        NSLog(@"%@", NSStringFromSelector(_cmd));
//        switch (status) {
//            case SFSpeechRecognizerAuthorizationStatusAuthorized:
//                weakSelf.recognizingButton.enabled = YES;
//                break;
//                
//            default:
//                break;
//        }
//    }];

    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.title = @"即时语音识别";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)onClickRecognizingBtn:(id)sender {
    if(_audioEngine.isRunning){
        [_audioEngine stop];
//        [_audioBufferRecognizerRequest endAudio];//强制停止接收音频输入源数据
//        [_recognitionTask cancel];
//        _recognitionTask = nil;
//        _audioBufferRecognizerRequest = nil;
        
        _recognizingButton.enabled = NO;
        [_recognizingButton setTitle:@"startRecognizing" forState:UIControlStateNormal];
    }else{
        [self startRecognizing];
        
        [_recognizingButton setTitle:@"stopRecognizing" forState:UIControlStateNormal];
    }
}

#pragma mark private methods

- (void)startRecognizing{
//    _audioBufferRecognizerRequest = [[SFSpeechAudioBufferRecognitionRequest alloc] init];
    
    AVAudioInputNode *inPutNode = _audioEngine.inputNode;
    if(inPutNode == nil){
        NSLog(@"Audio engine has no input node");
        return;
    }
    
//    _audioBufferRecognizerRequest.shouldReportPartialResults = YES;
    
    __weak typeof(self) weakSelf = self;
    AVAudioFormat *recordingFormat = [inPutNode outputFormatForBus:0];
    [inPutNode installTapOnBus:0 bufferSize:1024 format:recordingFormat block:^(AVAudioPCMBuffer * _Nonnull buffer, AVAudioTime * _Nonnull when) {
//        [weakSelf.audioBufferRecognizerRequest appendAudioPCMBuffer:buffer];
    }];
    
//    _recognitionTask = [_recognizer recognitionTaskWithRequest:_audioBufferRecognizerRequest resultHandler:^(SFSpeechRecognitionResult * _Nullable result, NSError * _Nullable error) {
//        BOOL isFinal = NO;
//        if(result){
//            dispatch_async(dispatch_get_main_queue(), ^{
//                [weakSelf.inputTextField setText:result.bestTranscription.formattedString];
//            });
//            isFinal = result.isFinal;
//        }
//        
//        if(error != nil || isFinal == YES){
//            [weakSelf.audioEngine stop];
//            [inPutNode removeTapOnBus:0];
//            
//            weakSelf.audioBufferRecognizerRequest = nil;
//            weakSelf.recognitionTask = nil;
//            
//            weakSelf.recognizingButton.enabled = YES;
//        }
//    }];
    
    [weakSelf.audioEngine prepare];
    
    NSError *error;
    BOOL flag = [weakSelf.audioEngine startAndReturnError:&error];
    if(flag){
        NSLog(@"音频引擎启动成功");
    }
    
    [_tipsLabel setText:@"说什么吧，我在听呢......"];
}

#pragma mark SFSpeechRecognizerDelegate

//- (void)speechRecognizer:(SFSpeechRecognizer *)speechRecognizer availabilityDidChange:(BOOL)available{
//    if(available){
//        _recognizingButton.enabled = YES;
//    }else{
//        _recognizingButton.enabled = NO;
//    }
//}

@end
