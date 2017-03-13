//
//  CWNImageButton.m
//  MYCloud
//
//  Created by 陈伟南 on 16/2/18.
//  Copyright © 2016年 Jam. All rights reserved.
//

#import "MYUShareButton.h"

@implementation MYUShareButton

-(CGRect)imageRectForContentRect:(CGRect)contentRect
{
    if(!CGRectIsEmpty(_imageFrame)){
        return _imageFrame;
    }
    return contentRect;
}

-(CGRect)titleRectForContentRect:(CGRect)contentRect
{
    if(!CGRectIsEmpty(_labelFrame)){
        return _labelFrame;
    }
       return contentRect;
}

@end
