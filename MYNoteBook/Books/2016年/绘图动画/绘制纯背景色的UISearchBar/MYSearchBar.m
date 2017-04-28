//
//  YYSearchBar.m
//  SearchBarDemo
//
//  Created by 陈伟南 on 16/4/6.
//  Copyright © 2016年 陈伟南. All rights reserved.
//

#import "MYSearchBar.h"
#import "UIImage+ImageEffects.h"

@implementation MYSearchBar

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.hasCentredPlaceholder = NO;
        //self.searchBarColor = [UIColor colorWithWhite:0.9 alpha:1];
        [self setTintColor:GLOBAL_COLOR];
        self.placeholder = @"请输入关键字                         ";
        self.showsBookmarkButton = YES;
        [self setBackgroundImage:[UIImage imageWithColor:[UIColor clearColor] size:CGSizeMake(WINDOW_WIDTH*0.5, 44.0f)]];
        [self setImage:[UIImage imageNamed:@"search_talk"] forSearchBarIcon:UISearchBarIconBookmark state:UIControlStateNormal];
        
        UITextField *textField = [[[[self subviews] objectAtIndex:0] subviews] objectAtIndex:1];
        textField.layer.cornerRadius = 14.0f;
        textField.layer.masksToBounds = YES;
        textField.backgroundColor = self.searchBarColor;
        textField.borderStyle = UITextBorderStyleRoundedRect;
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        self.hasCentredPlaceholder = NO;
        //self.searchBarColor = [UIColor colorWithWhite:0.9 alpha:1];
        [self setTintColor:GLOBAL_COLOR];
        self.placeholder = @"请输入关键字                                                ";
        [self setBackgroundImage:[UIImage imageWithColor:[UIColor clearColor] size:CGSizeMake(WINDOW_WIDTH*0.5 - 44.0f, 44.0f)]];
        [self setImage:[UIImage imageNamed:@"search_talk"] forSearchBarIcon:UISearchBarIconBookmark state:UIControlStateNormal];
        
        UITextField *textField = [[[[self subviews] objectAtIndex:0] subviews] objectAtIndex:1];
        textField.layer.cornerRadius = 14.0f;
        textField.layer.masksToBounds = YES;
        textField.backgroundColor = self.searchBarColor;
        textField.borderStyle = UITextBorderStyleRoundedRect;
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    UITextField *textField = [[[[self subviews] objectAtIndex:0] subviews] objectAtIndex:1];
    textField.backgroundColor = self.searchBarColor;
    [super drawRect:rect];
}

- (void)setSearchBarColor:(UIColor *)searchBarColor {
    _searchBarColor = searchBarColor;
    [self setNeedsDisplay];
}

- (void)setHasCentredPlaceholder:(BOOL)hasCentredPlaceholder {
    _hasCentredPlaceholder = hasCentredPlaceholder;
    
    SEL centerSelector = NSSelectorFromString([NSString stringWithFormat:@"%@%@", @"setCenter", @"Placeholder:"]);
    if ([self respondsToSelector:centerSelector]) {
        NSMethodSignature *signature = [[UISearchBar class] instanceMethodSignatureForSelector:centerSelector];
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
        [invocation setTarget:self];
        [invocation setSelector:centerSelector];
        [invocation setArgument:&_hasCentredPlaceholder atIndex:2];
        [invocation invoke];
    }
}

- (UITextField *)searchTextFiled{
     UITextField *textField = [[[[self subviews] objectAtIndex:0] subviews] objectAtIndex:1];
    return textField;
}

@end
