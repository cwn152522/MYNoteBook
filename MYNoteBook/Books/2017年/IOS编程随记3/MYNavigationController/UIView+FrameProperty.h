//
//  UIView+FrameProperty.h
//  GuDaShi
//
//  Created by 伟南 陈 on 2017/4/28.
//  Copyright © 2017年 songzhaojie. All rights reserved.
//

#import <UIKit/UIKit.h>//便捷改变view的frame中的某个只读属性

@interface UIView (FrameProperty)

@property (assign, nonatomic) CGFloat frame_x;//相当于frame.origin.x
@property (assign, nonatomic) CGFloat frame_y;//相当于frame.origin.y
@property (assign, nonatomic) CGFloat frame_width;//相当于frame.size.width
@property (assign, nonatomic) CGFloat frame_height;//相当于frame.size.height



#pragma mark 指定时间内改变以上某一个属性，可以设置动画结束回调

/**
 * 在指定时间内完成frame_x的设置
 *
 * @param frame_x            相当于frame.origin.x
 * @param duration           动画时间
 * @param completion       动画结束回调
 */
- (void)setFrame_x:(CGFloat)frame_x withDuration:(CGFloat)duration withCompletionBlock:(void(^)())completion;

/**
 * 在指定时间内完成frame_y的设置
 *
 * @param frame_y            相当于frame.origin.y
 * @param duration           动画时间
 * @param completion       动画结束回调
 */
- (void)setFrame_y:(CGFloat)frame_y withDuration:(CGFloat)duration withCompletionBlock:(void(^)())completion;

/**
 * 在指定时间内完成frame_width的设置
 *
 * @param frame_width    相当于frame.size.width
 * @param duration           动画时间
 * @param completion       动画结束回调
 */
- (void)setFrame_width:(CGFloat)frame_width withDuration:(CGFloat)duration withCompletionBlock:(void(^)())completion;

/**
 * 在指定时间内完成frame_height的设置
 *
 * @param frame_height    相当于frame.size.height
 * @param duration           动画时间
 * @param completion       动画结束回调
 */
- (void)setFrame_height:(CGFloat)frame_height withDuration:(CGFloat)duration withCompletionBlock:(void(^)())completion;

@end
