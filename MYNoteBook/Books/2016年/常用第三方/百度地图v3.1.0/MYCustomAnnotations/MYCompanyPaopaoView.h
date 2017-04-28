//
//  MYCompanyPaopaoView.h
//  MayiW
//
//  Created by chenweinan on 16/7/18.
//  Copyright © 2016年 Jam. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MYCompanyPaopaoView;

@protocol MYCompanyPaopaoViewDelegate <NSObject>

- (void)didClickView:(MYCompanyPaopaoView *)paopaoView;

@end

@interface MYCompanyPaopaoView : UIControl

@property (strong, nonatomic) UIControl *backView;
@property (strong, nonatomic) UILabel *orgNameLabel;
@property (strong, nonatomic) UILabel *jobNumberLabel;
@property (strong, nonatomic) UILabel *tipsLabel;

@property (assign, nonatomic) id <MYCompanyPaopaoViewDelegate> delegate;

- (instancetype)initWithFrame:(CGRect)frame delegate:(id<MYCompanyPaopaoViewDelegate>)delegate;
- (void)loadCompanyInfoWithOrgName:(NSString *)orgName andJobNumber:(NSString *)jobNumber;

@end
