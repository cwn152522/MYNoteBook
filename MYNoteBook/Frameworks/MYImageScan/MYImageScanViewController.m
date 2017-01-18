//
//  MYImageScanViewController.m
//  图片浏览器
//
//  Created by 陈伟南 on 16/1/5.
//  Copyright © 2016年 陈伟南. All rights reserved.
//

#import "MYImageScanViewController.h"
#import "MYImageScanCollectionViewCell.h"
#import "UIView+YXHView.h"
#import "NSArray+SafeMethod.h"
#import "FrontView.h"
#import "MYImageScanProgressView.h"

@interface MYImageScanViewController ()

@property (nonatomic, strong) UILabel *pagesLabel;
@property (nonatomic, strong) UIButton *backButton;
@property (nonatomic, strong) FrontView *frontView;

@property (assign, nonatomic) BOOL animated;

@end

@implementation MYImageScanViewController

static NSString * const reuseIdentifier = @"Cell";

-(instancetype)init
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = [UIScreen mainScreen].bounds.size;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.minimumInteritemSpacing = 0;
    layout.minimumLineSpacing = 0;
    return [super initWithCollectionViewLayout:layout];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.collectionView registerClass:[MYImageScanCollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    self.collectionView.pagingEnabled = YES;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.showsVerticalScrollIndicator = NO;
    
    [self.view addSubview:self.backButton];
    [self.view addSubview:self.pagesLabel];
//    [self.pagesLabel setTopFromSuperViewWithConstant:20.f];
//    [self.pagesLabel setHeight:16.f];
//    [self.pagesLabel setCenterX:self.view];
    self.pagesLabel.backgroundColor = [UIColor clearColor];
    self.pagesLabel.text = [NSString stringWithFormat:@"%ld/%ld", (long)self.index+1, (unsigned long)self.imageArray.count];
    if (self.scrollViewStyle != MYImageScanScrollViewDefault) {
        [self.view addSubview:self.frontView];
    }
    
//    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissImageScanView)];
//    gesture.numberOfTapsRequired = 1;
//    gesture.numberOfTouchesRequired = 1;
//    self.view.userInteractionEnabled = YES;
//    [self.view addGestureRecognizer:gesture];
    if(self.navigationController){
        self.navigationController.navigationBar.hidden = YES;
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:self.index inSection:0];
    [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
    
    MYImageScanProgressView *progressView = [[MYImageScanProgressView alloc] initWithFrame:CGRectMake(0, 0, _backButton.frame.size.width, _backButton.frame.size.height) andLineWidth:1 andLineColor:[UIColor whiteColor]];
    [progressView setUserInteractionEnabled:NO];
    [self.backButton addSubview:progressView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - show/dissmiss methods
- (void)showImageScanVC:(UIViewController *)vc animated:(BOOL)animated
{
    _animated = animated;
    __weak typeof(vc) weakVC = vc;
    if (weakVC != nil) {
        [weakVC presentViewController:self animated:_animated completion:nil];
    }
}

- (void)dismissImageScanView
{
    if(self.navigationController)
        [self.navigationController popViewControllerAnimated:YES];
    else
    [self dismissViewControllerAnimated:_animated completion:nil];
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.imageArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MYImageScanCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    [cell configCellWithImagePath:[self.imageArray objectSafetyAtIndex:indexPath.row]];
    self.pagesLabel.text = [NSString stringWithFormat:@"%ld/%ld", (long)indexPath.row+1, (unsigned long)self.imageArray.count];
    self.index = indexPath.row;
    return cell;
}

#pragma mark - saveImage

- (void)saveImageToAlbum
{
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self.index inSection:0];
    MYImageScanCollectionViewCell *cell = (MYImageScanCollectionViewCell *)[self.collectionView cellForItemAtIndexPath:indexPath];
    UIImageWriteToSavedPhotosAlbum(cell.scrollImageView.imageView.image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo{
    if (error == nil) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"已存入手机相册" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alert show];
    }else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请前往\"设置-隐私-照片\"开启权限" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alert show];
    }
}

#pragma mark - initViews

-(UILabel *)pagesLabel
{
    if (!_pagesLabel) {
        _pagesLabel = [[UILabel alloc] initWithFrame:CGRectMake(screenWidth/2 - 20, 20, 40, 16)];
        _pagesLabel.textAlignment = NSTextAlignmentCenter;
        _pagesLabel.textColor = [UIColor whiteColor];
        _pagesLabel.font = [UIFont systemFontOfSize:14.0f];
        //[_pagesLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    }
    return _pagesLabel;
}

- (UIButton *)backButton {
    if (!_backButton) {
        _backButton = [[UIButton alloc] init];
        _backButton.frame = CGRectMake(10, 40, 34, 34);
        CAShapeLayer *shapeLayer = [CAShapeLayer layer];
        shapeLayer.frame = CGRectMake(0, 0, 34, 34);
        shapeLayer.strokeColor = [UIColor whiteColor].CGColor;
        shapeLayer.fillColor = [UIColor clearColor].CGColor;
        UIBezierPath *path = [UIBezierPath bezierPath];
        [path moveToPoint:CGPointMake(10, 10)];
        [path addLineToPoint:CGPointMake(24, 24)];
        [path moveToPoint:CGPointMake(24, 10)];
        [path addLineToPoint:CGPointMake(10, 24)];
        [shapeLayer setPath:path.CGPath];
        [_backButton.layer addSublayer:shapeLayer];
        
        [_backButton addTarget:self action:@selector(dismissImageScanView) forControlEvents:UIControlEventTouchUpInside];
    }
    return _backButton;
}

-(UIView *)frontView
{
    if (!_frontView) {
        _frontView = [[FrontView alloc] initWithFrame:CGRectMake(0, screenHeight-110, screenHeight, 110)];
        _frontView.backgroundColor = [UIColor clearColor];
        _frontView.scrollViewStyle = self.scrollViewStyle;
        [_frontView.saveButton addTarget:self action:@selector(saveImageToAlbum) forControlEvents:UIControlEventTouchUpInside];
    }
    return _frontView;
}

@end
