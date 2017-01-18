//
//  MYShareView.m
//  umengSDK_test
//
//  Created by 陈伟南 on 16/9/26.
//  Copyright © 2016年 陈伟南. All rights reserved.
//

#import "MYUShareView.h"
#import "MYUShareButton.h"
#import "MYUShareLineView.h"

#define HexColor(hexValue) [UIColor colorWithRed:((float)((hexValue & 0xFF0000) >> 16)) / 255.0 green:((float)((hexValue & 0xFF00) >> 8)) / 255.0 blue:((float)(hexValue & 0xFF)) / 255.0 alpha:1.0]

@interface MYUShareView()

@property (strong, nonatomic) UIView *blackView;

@end

@implementation MYUShareView

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    if(self = [super initWithCoder:aDecoder]){
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

#pragma mark public methods

- (void)configShareViewWithButtons:(NSArray *)buttons images:(NSArray *)images lineBtnsCount:(NSInteger)lineBtnsCount lineSpace:(CGFloat)lineSpace edgeInset:(UIEdgeInsets)edgeInset imageWidth:(CGFloat)imageWidth{
    if([buttons count] != [images count]){
        NSLog(@"MYUShareView：分享按钮和图标数不一致！");
        return;
    }
    
    CGFloat btnWidth = (self.frame.size.width - edgeInset.left - edgeInset.right)/lineBtnsCount;//按钮宽度
    if(imageWidth > btnWidth)
        imageWidth = btnWidth - 24;//按钮的title高度为16距按钮图片下方4
    
        for (NSInteger i = 0; i < buttons.count; i++) {
        MYUShareButton *button = [[MYUShareButton alloc] initWithFrame:CGRectMake(
                                                                                  edgeInset.left + btnWidth * (i%lineBtnsCount),//left ＋ 按钮宽度
                                                                                  edgeInset.top + lineSpace * (i/lineBtnsCount) + btnWidth * (i/lineBtnsCount),//top ＋ 按钮高度 ＋ 行间距
                                                                                  btnWidth,
                                                                                  btnWidth)];
            
        button.imageFrame = CGRectMake((btnWidth - imageWidth)/2, 0, imageWidth, imageWidth);
        button.labelFrame = CGRectMake((btnWidth - imageWidth)/2, button.imageFrame.origin.y + button.imageFrame.size.height + 4, imageWidth, 16);
            
        button.imageView.layer.cornerRadius = imageWidth/2;
        [button setImage:[UIImage imageNamed:images[i]] forState:UIControlStateNormal];
        [button setTitle:buttons[i] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:13];
        button.titleLabel.textAlignment = NSTextAlignmentCenter;
        [button setTitleColor:HexColor(0x2a2a2a) forState:UIControlStateNormal];
        [button addTarget:self action:@selector(shareBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        button.tag = 1234+i;
        [self addSubview:button];
    }
    
    MYUShareLineView *line = [[MYUShareLineView alloc]initWithFrame:CGRectMake(0, self.frame.size.height-52, [[UIScreen mainScreen] bounds].size.width, 4)];
    line.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [line drawLineWithColor:line.backgroundColor];
    [self addSubview:line];
    
    UIButton *cancleBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, self.frame.size.height-44, [[UIScreen mainScreen] bounds].size.width, 44)];
    [cancleBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancleBtn setTitleColor:[UIColor colorWithWhite:178.0/255.0 alpha:1.0f] forState:UIControlStateNormal];
    [cancleBtn addTarget:self action:@selector(shareBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [cancleBtn setTag:1234+buttons.count];
    
    [self addSubview:cancleBtn];
}

- (void)show{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:self.blackView];
    [window addSubview:self];
    self.transform = CGAffineTransformMakeTranslation(0, _blackView.frame.size.height);
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:0.35f animations:^{
        weakSelf.transform = CGAffineTransformIdentity;
        weakSelf.blackView.alpha = 0.7;
    }];
}

- (void)hide{
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:0.35f animations:^{
        weakSelf.transform = CGAffineTransformMakeTranslation(0, _blackView.frame.size.height);
        weakSelf.blackView.alpha = 0;
    } completion:^(BOOL finished) {
        [[weakSelf subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
        [weakSelf removeFromSuperview];
        [weakSelf.blackView removeFromSuperview];
    }];
}

- (void)hideWithHiddenBlock:(void(^)(BOOL hasHidden))block{
     __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:0.35f animations:^{
        weakSelf.transform = CGAffineTransformMakeTranslation(0, _blackView.frame.size.height);
        weakSelf.blackView.alpha = 0;
    } completion:^(BOOL finished) {
        [[weakSelf subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
        [weakSelf removeFromSuperview];
        [weakSelf.blackView removeFromSuperview];
        if(block){
            block(YES);
        }
    }];
}

#pragma mark private methods

- (UIView *)blackView{
    if(!_blackView){
        _blackView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
        _blackView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.7];
        _blackView.alpha = 0;
    }
    return _blackView;
}

- (void)shareBtnClick:(UIButton *)sender{
    if(_shareBtnClickdBlock){
        _shareBtnClickdBlock(sender.tag - 1234);
    }
}

@end
