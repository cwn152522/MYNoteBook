//
//  NavigationView.m
//  GuDaShi
//
//  Created by songzhaojie on 17/1/12.
//  Copyright © 2017年 songzhaojie. All rights reserved.
//

#import "NavigationView.h"
#import "UIView+CWNView.h"

@implementation NavigationView

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */
-(id)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if (self){
    }
    
    return self;
}

- (void)leftBtnSheZhiImage:(NSString *)image withText:(NSString *)text  withHidden:(BOOL)hidded{
    if(!_leftBtn){
        _leftBtn=[MYImageButton buttonWithType:UIButtonTypeCustom];
        [_leftBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _leftBtn.titleLabel.font=[UIFont systemFontOfSize:15];
        [_leftBtn addTarget:self action:@selector(Leftbtn) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_leftBtn];
        
        [_leftBtn cwn_makeConstraints:^(UIView *maker) {
            maker.leftToSuper(2.5).topToSuper(20).bottomToSuper(0).width(100);
        }];
    }
    
//    if([image length]){//图片
        UIImage *imageView = [UIImage imageNamed:image];
        _leftBtn.imageFrame=CGRectMake(10, (self.frame.size.height - 20) / 2 - imageView.size.height / 2, imageView.size.width, imageView.size.height);
        [_leftBtn setImage:imageView forState:UIControlStateNormal];
//    }
    
//    if([text length]){//文字
        _leftBtn.labelFrame = CGRectMake(10, 0, 90, self.frame.size.height - 20);
        [_leftBtn setTitle:text forState:UIControlStateNormal];
        [_leftBtn.titleLabel setTextAlignment:NSTextAlignmentLeft];
//    }
    
    _leftBtn.hidden=hidded;
}
-(void)leftBtnSheZhiImage:(NSString *)image  withText:(NSString *)text withHidden:(BOOL)hidded withfloatX:(float)floatX withfloatY:(float)floatY withWidth:(float)width withHeight:(float)height
{
    [self leftBtnSheZhiImage:image withText:text withHidden:hidded];
}

- (void)zhongJianLableSheZhiLable:(NSString *)lable withZiShiYing:(BOOL)ZiShiYing withFont:(float)font{
    if(!_zHongJianlable){
        _zHongJianlable=[[UILabel alloc]init];
        [self addSubview:_zHongJianlable];
        
        [_zHongJianlable cwn_makeConstraints:^(UIView *maker) {
            maker.centerXtoSuper(0).topToSuper(20).bottomToSuper(0);
        }];
        
        _zHongJianlable.adjustsFontSizeToFitWidth=ZiShiYing;
        _zHongJianlable.textAlignment=NSTextAlignmentCenter;
        _zHongJianlable.font=[UIFont systemFontOfSize:font];
        _zHongJianlable.textColor=[UIColor whiteColor];
    }
    _zHongJianlable.text=lable;
}
-(void)zhongJianLableSheZhiLable:(NSString *)lable withZiShiYing:(BOOL)ZiShiYing  withFont:(float)font withfloatX:(float)floatX withfloatY:(float)floatY withWidth:(float)width withHeight:(float)height
{
    [self zhongJianLableSheZhiLable:lable withZiShiYing:ZiShiYing withFont:font];
}

- (void)reghtBtnSheZhiImage:(NSString *)image withText:(NSString *)text withHidden:(BOOL)hidded{
    if(!_reghtBtn){
        _reghtBtn=[MYImageButton buttonWithType:UIButtonTypeCustom];
        [_reghtBtn addTarget:self action:@selector(reghtBtn1) forControlEvents:UIControlEventTouchUpInside];
        [_reghtBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _reghtBtn.titleLabel.font=[UIFont systemFontOfSize:15];
        _reghtBtn.titleLabel.textColor=[UIColor whiteColor];
        [self addSubview:_reghtBtn];
        
        [_reghtBtn cwn_makeConstraints:^(UIView *maker) {
            maker.rightToSuper(2.5).topToSuper(20).bottomToSuper(0).width(100);
        }];
    }
    
//    if([image length]){//图片
        UIImage *imageView = [UIImage imageNamed:image];
        _reghtBtn.imageFrame=CGRectMake(100 - imageView.size.width - 10, (self.frame.size.height - 20) / 2 - imageView.size.height / 2, imageView.size.width, imageView.size.height);
        [_reghtBtn setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
//    }
    
//    if([text length]){//文字
        _reghtBtn.labelFrame = CGRectMake(0, 0, 90, self.frame.size.height - 20);
         [_reghtBtn setTitle:text forState:UIControlStateNormal];
        [_reghtBtn.titleLabel setTextAlignment:NSTextAlignmentRight];
//    }
    
    
    _reghtBtn.hidden=hidded;
}
-(void)reghtBtnSheZhiImage:(NSString *)image withText:(NSString *)text withHidden:(BOOL)hidded withfloatX:(float)floatX withfloatY:(float)floatY withWidth:(float)width withHeight:(float)height withImageWidth:(float)imageWidth withImageHeight:(float)imageHeight
{
    [self reghtBtnSheZhiImage:image withText:text withHidden:hidded];
}

-(void)Leftbtn
{
    if ([_delegate respondsToSelector:@selector(navigationViewLeftDlegate)]) {
        [_delegate navigationViewLeftDlegate];
    }
    
    
}
-(void)reghtBtn1
{
    if ([_delegate respondsToSelector:@selector(navigationViewReghtDlegate)]) {
        [_delegate navigationViewReghtDlegate];
    }
    
    
    
}
@end
