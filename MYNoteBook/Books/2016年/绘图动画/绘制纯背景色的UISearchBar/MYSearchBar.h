//
//  MYSearchBar.h
//  SearchBarDemo
//
//  Created by 陈伟南 on 16/4/6.
//  Copyright © 2016年 陈伟南. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MYSearchBar : UISearchBar

@property (nonatomic, assign, setter = setHasCentredPlaceholder:) BOOL hasCentredPlaceholder;

@property (nonatomic, strong) UIColor *searchBarColor;

- (UITextField *)searchTextFiled;

@end
