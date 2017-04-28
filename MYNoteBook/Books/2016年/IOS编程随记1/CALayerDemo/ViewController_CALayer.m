//
//  ViewController.m
//  CALayer_Demo
//
//  Created by chenweinan on 16/10/29.
//  Copyright © 2016年 chenweinan. All rights reserved.
//

#import "ViewController_CALayer.h"
#import "TestLayer.h"

@interface ViewController_CALayer ()

@end

@implementation ViewController_CALayer

- (void)viewDidLoad {
    [super viewDidLoad];
    [self drawDelegateLayer];
//    [self drawDefLayer];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)drawDelegateLayer{
    CGSize size = self.view.bounds.size;
    CALayer *layer = [[CALayer alloc] init];
    layer.backgroundColor = [UIColor redColor].CGColor;
    layer.position = CGPointMake(size.width/2, size.height/2);
    layer.bounds = CGRectMake(0, 0, 50, 50);
    layer.cornerRadius = layer.bounds.size.width/2;
    layer.shadowColor = [UIColor grayColor].CGColor;
    layer.shadowOffset = CGSizeMake(2, 2);
    layer.shadowOpacity = .9;
    layer.masksToBounds = YES;//外边框绘制的阴影消失了，解决方法：新增底部独立阴影图层
    [self.view.layer addSublayer:layer];
    
    //解决图像倒立问题方法（1）：沿着x轴旋转180度
//    layer.transform = CATransform3DMakeRotation(M_PI, 1, 0, 0);
    
    layer.delegate = self;
    [layer setNeedsDisplay];

    //解决图像倒立问题方法（2）：设置contents
//    UIImage *image = [UIImage imageNamed:@"radioImage.jpg"];
//    [layer setContents:(id)image.CGImage];
    
    //解决图像倒立问题方法（3）
    [layer setValue:@M_PI forKeyPath:@"transform.rotation.x"];
}

- (void)drawDefLayer{
    CGSize size = self.view.bounds.size;
    TestLayer *layer = [[TestLayer alloc] init];//也可以新建一个view来addsublayer，则视图控制器只需负责创建视图并addsubview即可
    layer.backgroundColor = [UIColor redColor].CGColor;
    layer.position = CGPointMake(size.width/2, size.height/2);
    layer.bounds = CGRectMake(0, 0, 50, 50);
    layer.cornerRadius = layer.bounds.size.width/2;
    layer.shadowColor = [UIColor grayColor].CGColor;
    layer.shadowOffset = CGSizeMake(2, 2);
    layer.shadowOpacity = .9;
    layer.masksToBounds = YES;//外边框绘制的阴影消失了，解决方法：新增底部独立阴影图层
     [layer setNeedsDisplay];
    [self.view.layer addSublayer:layer];
    
    //解决图像倒立问题（3）
    [layer setValue:@M_PI forKeyPath:@"transform.rotation.x"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark  layer隐式动画属性测试

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    CGPoint point = [[touches anyObject] locationInView:self.view];
    CALayer *layer = [self.view.layer.sublayers lastObject];
     CGFloat width = layer.bounds.size.width;
    layer.position = point;
    if(width == 50){
        width = 4 * width;
        layer.shadowOffset = CGSizeMake(5, 5);
    }else{
        width = 50;
        layer.shadowOffset = CGSizeMake(2, 2);
    }
    layer.bounds = CGRectMake(0, 0, width, width);
    layer.cornerRadius = layer.bounds.size.width/2;
    
    //隐式动画本质是基础动画
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"backgroundColor"];
    animation.duration = 0.8;
    if(width == 50){
        animation.toValue = (__bridge id _Nullable)([UIColor redColor].CGColor);
    }else{
        animation.toValue = (__bridge id _Nullable)([UIColor blueColor].CGColor);
    }
    animation.beginTime = CACurrentMediaTime();
    animation.fillMode = kCAFillModeForwards;//必须设置，否者下面一句无效，图层会被遮盖
    animation.removedOnCompletion = NO;
    [layer addAnimation:animation forKey:@"changeBackground"];
    //CALayer代理绘图
    [layer setNeedsDisplay];
}

#pragma mark  CALayer绘图之代理方法

- (void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx{
    CGContextSaveGState(ctx);
    //解决图像倒立问题（4）：坐标变换
//    CGContextTranslateCTM(ctx, 0, layer1.bounds.size.height);
//    CGContextScaleCTM(ctx, 1, -1);
    
    UIImage *image = [UIImage imageNamed:@"radioImage.jpg"];
    CGContextDrawImage(ctx, layer.bounds, image.CGImage);
    CGContextRestoreGState(ctx);
}

@end
