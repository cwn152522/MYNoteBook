//
//  MYCloud
//  MYIndicatorView.h
//
//  Created by 陈伟南 on 16/1/5.
//  Copyright © 2016年 陈伟南. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface MYIndicatorView : UIView

@property (strong, nonatomic) UIColor *fillColor;//填充色

- (void)startAnimating;
- (void)stopAnimating;

@end
