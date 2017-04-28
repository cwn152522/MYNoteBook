//
//  UIViewController+CATransition.m
//  modalAnimationDemo
//
//  Created by 陈伟南 on 16/5/12.
//  Copyright © 2016年 陈伟南. All rights reserved.
//

#import "UIViewController+CATransition.h"

@implementation UIViewController (CATransition)

- (void)presentViewController:(UIViewController *)viewController withTransitionType:(CATransitionType)type andSubType:(CATransitionSubType)subType andDuration:(CGFloat)duration{
    CATransition *animation = [self getTransitionWithTransitionType:type andSubType:subType andDuration:duration];
    [self.view.window.layer addAnimation:animation forKey:@"animation"];
    [self presentViewController:viewController animated:NO completion:nil];
}
- (void)dismissViewControllerWithTransitionType:(CATransitionType)type andSubType:(CATransitionSubType)subType andDuration:(CGFloat)duration{
    CATransition *animation = [self getTransitionWithTransitionType:type andSubType:subType andDuration:duration];
    [self.view.window.layer addAnimation:animation forKey:@"animation"];
    [self dismissViewControllerAnimated:NO completion:nil];
}


- (void)pushViewController:(UIViewController *)controller withTransitionType:(CATransitionType)type andSubType:(CATransitionSubType)subType andDuration:(CGFloat)duration{
    CATransition *animation = [self getTransitionWithTransitionType:type andSubType:subType andDuration:duration];
    [self.navigationController.view.layer addAnimation:animation forKey:@"animation"];
    [self.navigationController pushViewController:controller animated:NO];
}
- (void)popViewControllerWithTransitionType:(CATransitionType)type andSubType:(CATransitionSubType)subType andDuration:(CGFloat)duration{
    CATransition *animation = [self getTransitionWithTransitionType:type andSubType:subType andDuration:duration];
    [self.navigationController.view.layer addAnimation:animation forKey:@"animation"];
    [self.navigationController popViewControllerAnimated:NO];
}
- (void)popViewControllerToViewController:(UIViewController *)controller WithTransitionType:(CATransitionType)type andSubType:(CATransitionSubType)subType andDuration:(CGFloat)duration{
    CATransition *animation = [self getTransitionWithTransitionType:type andSubType:subType andDuration:duration];
    [self.navigationController.view.layer addAnimation:animation forKey:@"animation"];
    [self.navigationController popToViewController:controller animated:NO];
}
- (void)popToRootViewControllerWithTransitionType:(CATransitionType)type andSubType:(CATransitionSubType)subType andDuration:(CGFloat)duration{
    CATransition *animation = [self getTransitionWithTransitionType:type andSubType:subType andDuration:duration];
    [self.navigationController.view.layer addAnimation:animation forKey:@"animation"];
    [self.navigationController popToRootViewControllerAnimated:NO];
}


#pragma mark Utility

- (CATransition *)getTransitionWithTransitionType:(CATransitionType)type andSubType:(CATransitionSubType)subType andDuration:(CGFloat)duration{
    CATransition *animation = [CATransition animation];
    animation.subtype = [self getTransitionSubType:subType];
    animation.duration = duration;
    switch (type) {
        case CATransitionTypeCrossDissolve:
            animation.type = kCATransitionFade;
            break;
        case CATransitionTypeRippleEffect:
            animation.type = @"rippleEffect";
            break;
        case CATransitionTypeSuckEffect:
            animation.type = @"suckEffect";
            break;
        case CATransitionTypeOglFlip:
            animation.type = @"oglFlip";
            break;
        case CATransitionTypeCube:
            animation.type = @"cube";
            break;
        case CATransitionTypePageCurl:
            animation.type = @"pageCurl";
            break;
        case CATransitionTypePageUnCurl:
            animation.type = @"pageUnCurl";
            break;
        case CATransitionTypePush:
            animation.type = kCATransitionPush;
            break;
        case CATransitionTypeReveal:
            animation.type = kCATransitionReveal;
            break;
        case CATransitionTypeMoveIn:
            animation.type = kCATransitionMoveIn;
            break;
        default:
            break;
    }
    return animation;
}

- (NSString *)getTransitionSubType:(CATransitionSubType)subType{
    switch (subType) {
        case CATransitionTransformFromDefault:
            return kCATransitionFromRight;
            break;
        case CATransitionTransformFromLeft:
            return kCATransitionFromLeft;
            break;
        case CATransitionTransformFromBottom:
            return kCATransitionFromBottom;
            break;
        case CATransitionTransformFromTop:
            return kCATransitionFromTop;
            break;
        default:
            break;
    }
}


@end
