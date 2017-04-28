//
//  MYCompanyPointAnnotation.h
//  MayiW
//
//  Created by chenweinan on 16/7/18.
//  Copyright © 2016年 Jam. All rights reserved.
//

#import <BaiduMapAPI_Map/BMKPointAnnotation.h>//只引入所需的单个头文件

/*
 *附近职位Annotation
 */
@interface MYCompanyPointAnnotation : BMKPointAnnotation

@property (copy, nonatomic) NSString *orgName;
@property (copy, nonatomic) NSString *jobCount;

@end
