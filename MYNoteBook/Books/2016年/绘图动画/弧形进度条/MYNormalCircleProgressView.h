//
//  MYNormalCircleProgressView.h
//  MYNoteBook
//
//  Created by chenweinan on 16/12/9.
//  Copyright © 2016年 chenweinan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MYNormalCircleProgressView : UIView

@property (strong, nonatomic) UIColor *lineColor;
@property (assign, nonatomic) CGFloat lineWidth;

@property (assign, nonatomic) BOOL isLoading;

- (void)startAnimating;
- (void)stopAnimating;

@end
