//
//  ViewController_SpeechURL.m
//  MYNoteBook
//
//  Created by chenweinan on 16/11/27.
//  Copyright © 2016年 chenweinan. All rights reserved.
//

#import "ViewController_SpeechURL.h"
//#import <Speech/Speech.h>

@interface ViewController_SpeechURL ()

@property (weak, nonatomic) IBOutlet UILabel *label;

@end

@implementation ViewController_SpeechURL

- (void)viewDidLoad {
    [super viewDidLoad];
    //使用语音识别需向系统请求权限
//    [SFSpeechRecognizer requestAuthorization:^(SFSpeechRecognizerAuthorizationStatus status) {
//        if(status == SFSpeechRecognizerAuthorizationStatusAuthorized)
//            NSLog(@"语音识别权限请求成功");
//    }];
    
    //还必须在info.plist文件中添加相应权限说明，否者报错
    
    //还必须在真机调试，否者报错
    //Privacy - Speech Recognition Usage Description
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.title = @"音频文件识别";
}

- (IBAction)startRecognizing:(id)sender {
    [_label setText:@"识别中"];
    
    //初始化一个识别器
//    SFSpeechRecognizer *recognizer = [[SFSpeechRecognizer alloc] initWithLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"]];
    
    //初始化音频的URL
//    NSURL *url = [[NSBundle mainBundle] URLForResource:@"7822" withExtension:@"wav"];
    
    //初始化相应SFSpeechRecognitionRequest的子类
//    SFSpeechURLRecognitionRequest *request = [[SFSpeechURLRecognitionRequest alloc] initWithURL:url];
    
    //由识别器发起文件识别请求，返回相应请求的task
//    [recognizer recognitionTaskWithRequest:request resultHandler:^(SFSpeechRecognitionResult * _Nullable result, NSError * _Nullable error) {
//        if(error == nil){
//            [_label setText: result.bestTranscription.formattedString];
//        }
//    }];
}

- (IBAction)pushToAudioRecognizerPage:(id)sender {
    [self performSegueWithIdentifier:@"goAudioRecognizer" sender:nil];
}

@end
