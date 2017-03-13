//
//  MYWaterView.h
//  MYRefresh
//
//  Created by 陈伟南 on 2016/10/20.
//  Copyright © 2016年 陈伟南. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MYWaterView : UIView

@property (strong, nonatomic) UIColor *fillColor;//填充色
@property (assign, nonatomic) CGFloat currentLinePointY;//线高

- (void)pauseTimer;

- (void)resumeTimer;

@end
