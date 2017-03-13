//
//  testLayer.m
//  CALayer_Demo
//
//  Created by chenweinan on 16/10/29.
//  Copyright © 2016年 chenweinan. All rights reserved.
//

#import "TestLayer.h"

@implementation TestLayer

- (void)drawInContext:(CGContextRef)ctx{
    CGContextSaveGState(ctx);
    UIImage *image = [UIImage imageNamed:@"radioImage.jpg"];
    CGContextDrawImage(ctx, self.bounds, image.CGImage);
    CGContextRestoreGState(ctx);
}

@end
