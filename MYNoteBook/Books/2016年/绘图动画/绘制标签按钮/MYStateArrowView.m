//
//  MYStateArrowView.m
//  MYCloud
//
//  Created by 陈伟南 on 16/4/12.
//  Copyright © 2016年 Jam. All rights reserved.
//

#import "MYStateArrowView.h"
#import "UIView+CWNView.h"

@implementation MYStateArrowView

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        [_titleLabel setTextColor:[UIColor whiteColor]];
        [_titleLabel setFont:[UIFont systemFontOfSize:13.0f]];
        [_titleLabel setTextAlignment:NSTextAlignmentCenter];
        [_titleLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    }
    return _titleLabel;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self =[super initWithCoder: aDecoder]){
        [self setUp];
    }
    return self;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [self setUp];
           }
    return self;
}

- (void)setUp{
    UIImage *image = [UIImage imageNamed:@"dd_biaoqian"];
    CGFloat top = 3; // 顶端盖高度
    CGFloat bottom = 3 ; // 底端盖高度
    CGFloat left = 3; // 左端盖宽度
    CGFloat right = 10; // 右端盖宽度
    UIEdgeInsets insets = UIEdgeInsetsMake(top, left, bottom, right);
    // 指定为拉伸模式，伸缩后重新赋值
    image = [image resizableImageWithCapInsets:insets resizingMode:UIImageResizingModeStretch];
    self.image = image;
    [self addSubview:self.titleLabel];
    [self.titleLabel setLayoutTopFromSuperViewWithConstant:0];
    [self.titleLabel setLayoutLeftFromSuperViewWithConstant:2.0f];
    [self.titleLabel setLayoutBottomFromSuperViewWithConstant:0];
    [self.titleLabel setLayoutRightFromSuperViewWithConstant:8.0f];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
