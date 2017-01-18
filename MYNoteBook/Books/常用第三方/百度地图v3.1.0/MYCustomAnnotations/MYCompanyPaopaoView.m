//
//  MYCompanyPaopaoView.m
//  MayiW
//
//  Created by chenweinan on 16/7/18.
//  Copyright © 2016年 Jam. All rights reserved.
//

#import "MYCompanyPaopaoView.h"
#import "UIView+YXHView.h"

@implementation MYCompanyPaopaoView

- (instancetype)initWithFrame:(CGRect)frame delegate:(id<MYCompanyPaopaoViewDelegate>)delegate{
    self.delegate = delegate;
    return [self initWithFrame:frame];
}

- (id)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        [self configUIWithFrame:frame];
    }
    return self;
}

#pragma mark configUI

- (void)configUIWithFrame:(CGRect)frame{
    [self setBackgroundColor:[UIColor clearColor]];
    self.layer.shadowOffset = CGSizeMake(0, 3);
   self.layer.shadowOpacity = 0.80;
    [self addSubview:_backView];
    self.alpha = 0.9;
    
    [self addSubview:self.backView];
    [_backView setLayoutLeftFromSuperViewWithConstant:2];
    [_backView setLayoutTopFromSuperViewWithConstant:2];
    [_backView setLayoutRightFromSuperViewWithConstant:2];
    [_backView setLayoutBottomFromSuperViewWithConstant:4];
    
    [self.backView addSubview:self.orgNameLabel];
    [_orgNameLabel setLayoutLeftFromSuperViewWithConstant:4];
    [_orgNameLabel setLayoutTopFromSuperViewWithConstant:4];
    [_orgNameLabel setLayoutRightFromSuperViewWithConstant:4];
    [_orgNameLabel setLayoutHeight:16];
    
    [self.backView addSubview:self.jobNumberLabel];
    [_jobNumberLabel setLayoutLeftFromSuperViewWithConstant:4];
    [_jobNumberLabel setLayoutTop:_orgNameLabel multiplier:1 constant:4];
    [_jobNumberLabel setLayoutRightFromSuperViewWithConstant:4];
    [_jobNumberLabel setLayoutHeight:16];
    
    [self.backView addSubview:self.tipsLabel];
    [_tipsLabel setLayoutLeftFromSuperViewWithConstant:4];
    [_tipsLabel setLayoutTop:_jobNumberLabel multiplier:1 constant:4];
    [_tipsLabel setLayoutRightFromSuperViewWithConstant:4];
    [_tipsLabel setLayoutHeight:16];
}

- (void)drawRect:(CGRect)rect{
    CGPoint leftBottom = CGPointMake(1, rect.size.height - 3);
    CGPoint topLeft = CGPointMake(1, 1);
    CGPoint topRight = CGPointMake(rect.size.width - 1, 1);
    CGPoint rightBottom = CGPointMake(rect.size.width - 1, rect.size.height - 3);
    CGPoint centerBottomRight = CGPointMake(rect.size.width/2 + 3, rect.size.height - 3);
    CGPoint centerBottomCenter = CGPointMake(rect.size.width/2, rect.size.height - 1);
    CGPoint centerBottomLeft = CGPointMake(rect.size.width/2 - 3, rect.size.height - 3);
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path setLineWidth:2];
    [path setLineCapStyle:kCGLineCapRound];
    [path setLineJoinStyle:kCGLineJoinRound];
    [GLOBAL_COLOR setStroke];
    [[UIColor whiteColor] setFill];
    
    [path moveToPoint:leftBottom];
    [path addLineToPoint:topLeft];
    [path addLineToPoint:topRight];
    [path addLineToPoint:rightBottom];
    [path addLineToPoint:centerBottomRight];
    [path addLineToPoint:centerBottomCenter];
    [path addLineToPoint:centerBottomLeft];
    [path closePath];
    [path stroke];
    [path fill];
    
    [super drawRect:rect];
}


- (UIControl *)backView{
    if(!_backView){
        _backView = [[UIControl alloc] init];
        [_backView setTranslatesAutoresizingMaskIntoConstraints:NO];
        [_backView addTarget:self action:@selector(onClickPaopaoView) forControlEvents:UIControlEventTouchUpInside];
    }
    return _backView;
}

- (UILabel *)orgNameLabel{
    if(!_orgNameLabel){
        _orgNameLabel = [[UILabel alloc] init];
        [_orgNameLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
        [_orgNameLabel setTextColor:[UIColor blueColor]];
        [_orgNameLabel setFont:[UIFont systemFontOfSize:15]];
        [_orgNameLabel setTextAlignment:NSTextAlignmentCenter];
    }
    return _orgNameLabel;
}

- (UILabel *)jobNumberLabel{
    if(!_jobNumberLabel){
        _jobNumberLabel = [[UILabel alloc] init];
        [_jobNumberLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
        [_jobNumberLabel setTextColor:[UIColor blackColor]];
        [_jobNumberLabel setFont:[UIFont systemFontOfSize:15]];
        [_jobNumberLabel setTextAlignment:NSTextAlignmentCenter];
    }
    return _jobNumberLabel;
}

- (UILabel *)tipsLabel{
    if(!_tipsLabel){
        _tipsLabel = [[UILabel alloc] init];
        [_tipsLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
        [_tipsLabel setTextColor:[UIColor colorWithWhite:128.0/255.0 alpha:1]];
        [_tipsLabel setFont:[UIFont systemFontOfSize:15]];
        [_tipsLabel setTextAlignment:NSTextAlignmentCenter];
        [_tipsLabel setText:@"查看点评"];
    }
    return _tipsLabel;
}

#pragma mark private Methods

- (void)onClickPaopaoView{
    if(_delegate && [_delegate respondsToSelector:@selector(didClickView:)]){
        [_delegate didClickView:self];
    }
}

- (void)loadCompanyInfoWithOrgName:(NSString *)orgName andJobNumber:(NSString *)jobNumber{
    [_orgNameLabel setText:orgName];
    
    NSMutableAttributedString *jobNumberStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"招聘信息%@条", jobNumber]];
    NSDictionary *attributeDic = @{
                                   NSForegroundColorAttributeName:[UIColor redColor]
                                   };
    [jobNumberStr setAttributes:attributeDic range:NSMakeRange(4, [jobNumber length])];
    [_jobNumberLabel setAttributedText:jobNumberStr];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
