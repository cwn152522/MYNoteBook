//
//  WTZGlobal.h
//  wtz
//
//  Created by 贾淼 on 15-1-6.
//  Copyright (c) 2015年 milestone. All rights reserved.
//

#ifndef my_MYLaborGlobal_h
#define my_MYLaborGlobal_h

#define ShiPeiWidth(x) [UIScreen mainScreen].bounds.size.width / 320 * x
#define ShiPeiHeight(x) [UIScreen mainScreen].bounds.size.height / 568 * x

#ifdef DEBUG
#	define DLog(fmt, ...) NSLog((@"%s #%d " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#	define DLog(...)
#endif

#define VERSION 3

#if VERSION == 1
#define BAIDUMAPKEY                     @"ukI2zqEfIOs8v0mNhucSHGiF2gtyrPXI"
//测试外网ip地址

//#define GLOBAL_REQUEST_HOSTNAME         @"58.210.11.170:9138"
//#define GLOBAL_MY_REQUEST_HOSTNAME      @"58.210.11.170:9138"

#define GLOBAL_REQUEST_HOSTNAME         @"http://58.210.11.170:9181"
#define GLOBAL_ANTREQUEST_HOSTNAME @"58.210.11.170:9185"
#define GLOBAL_REQUEST_PATH(string)  [NSString stringWithFormat:@"/%@", string]

//H5模块
//#define H5MODELPATH(string)             [NSString stringWithFormat:@"/mayicloud_provider/%@", string]
//#define REQUEST_H5MODEL_HOSTNAME        @"58.210.11.170:9140"

//#elif VERSION == 2
//#define BAIDUMAPKEY                     @"owejPZk6GCvc9amGoBf88Hkq"
////模拟正式外网ip地址
//#define GLOBAL_REQUEST_HOSTNAME         @"58.210.11.170:9151"
//#define GLOBAL_MY_REQUEST_HOSTNAME      @"58.210.11.170:9151"
//#define GLOBAL_MY_REQUEST_PATH(string)  [NSString stringWithFormat:@"/%@", string]
////H5模块
//#define H5MODELPATH(string)             [NSString stringWithFormat:@"/supply/%@", string]
//#define REQUEST_H5MODEL_HOSTNAME        @"58.210.11.170:9154"

#elif VERSION == 3
#define BAIDUMAPKEY                     @"knok59Xb6WklTEGVAqoVun5HecLN7sSh"//百度地图appkey
#define UMENGSOCIALKEY             @"5852acd2f43e4822b10022be"//友盟appKey
#define BAIDUMTJKEY                      @"e1f4000bea"//百度统计appkey
#define JPUSHKEY                              @"c8627472583b5234e232c86e"//极光推送appkey
#define IFLYMSCKEY                         @"584445ae"//科大讯飞语音识别key

//正式外网ip地址
//#define GLOBAL_REQUEST_HOSTNAME         @"api.mayiy.com"
//#define GLOBAL_MY_REQUEST_HOSTNAME      @"api.mayiy.com"
#define GLOBAL_REQUEST_HOSTNAME         @"http://m.mayiw.com"
#define GLOBAL_ANTREQUEST_HOSTNAME @"http://app.mayiw.com"
#define GLOBAL_REQUEST_PATH(string)  [NSString stringWithFormat:@"/%@", string]
//H5模块
//#define H5MODELPATH(string)             [NSString stringWithFormat:@"/supply/%@", string]
//#define REQUEST_H5MODEL_HOSTNAME        @"download.mayiy.com"

#endif

//#define GLOBAL_REQUEST_PATH(string)     [NSString stringWithFormat:@"/json/mayicloud_provider/%@", string]
#define WINDOW_WIDTH [[UIScreen mainScreen] bounds].size.width
#define WINDOW_HEIGHT [[UIScreen mainScreen] bounds].size.height
#define GLOBAL_COLOR                    [UIColor colorWithRed:243/255.0 green:212/255.0 blue:149/255.0 alpha:1]
#define GLOBAL_ORANGE_COLOR                    RGBCOLOR(255, 154, 0)
#define GLOBAL_GREEN_COLOR             RGBCOLOR(8,176, 1)
#define RGBCOLOR(r,g,b)                 [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]
#define HexColor(hexValue) [UIColor colorWithRed:((float)((hexValue & 0xFF0000) >> 16)) / 255.0 green:((float)((hexValue & 0xFF00) >> 8)) / 255.0 blue:((float)(hexValue & 0xFF)) / 255.0 alpha:1.0]

#define GLOBAL_SVPROGRESS_DURATION 0.88f//SVProgressHUB动画时间

#define GLOBAL_BACKGROUND_COLOR         [UIColor colorWithWhite:229.0/255.0 alpha:1.0f]//列表背景色

#define GLOBAL_ALERT_LINE_COLOR                    RGBCOLOR(242, 110, 38)
#define GLOBAL_CELL_LINE_COLOR          [UIColor colorWithWhite:198.0/255.0 alpha:1.0f]

#define GLOBAL_BLACKCONTENT_COLOR           [UIColor blackColor]
#define GLOBAL_BLACKTIPS_COLOR           [UIColor colorWithWhite:100.0/255.0 alpha:1.0f]
#define GLOBAL_BLACLIGHTKTIPS_COLOR           [UIColor colorWithWhite:140.0/255.0 alpha:1.0f]

#define GLOBAL_DEFAULT_FONT             [UIFont systemFontOfSize:17]
#define GLOBAL_NORMAL_FONT(s)           [UIFont systemFontOfSize:s]

#endif
