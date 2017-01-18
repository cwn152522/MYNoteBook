//
//  MYNotesSpeechSearchViewController.h
//  MYNoteBook
//
//  Created by chenweinan on 16/12/5.
//  Copyright © 2016年 chenweinan. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^SpeechRecognizerResult)(BOOL isResult, NSString *keyWords);

@interface MYNotesSpeechSearchViewController : UIViewController

@property (strong, nonatomic) SpeechRecognizerResult resultBlock;

@end
