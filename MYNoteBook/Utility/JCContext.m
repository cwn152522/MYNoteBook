//
//  JCContext.m
//  JC139house
//
//  Created by Jam on 13-3-20.
//  Copyright (c) 2013年 Jam. All rights reserved.
//

#import "JCContext.h"

@implementation JCContext

@synthesize locationLat = _locationLat;
@synthesize locationLng = _locationLng;
@synthesize cityName = _cityName;
@synthesize cityId = _cityId;

- (id)init
{
    self = [super init];
    
    if (self) {
        self.locationLat = nil;
        self.locationLng = nil;
        self.cityName = nil;
        self.cityId = nil;
        self.stackRefreshMethod = [NSMutableArray array];
        self.alterType = AlterPasswordType;
        self.searchType = MYSearchTypeNormal;
        self.regStatus = -2;
        self.hotCompany = [NSArray array];
        self.hotJob = [NSArray array];
        self.isRefreshTrack = NO;
        self.isRefreshEnroll = NO;
        self.isRefreshFullTime = NO;
        self.isRefreshPartTime = NO;
    }
    return self;
}

+ (id)shareContext
{
    static JCContext *shareContext = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareContext = [[self alloc] init];
    });
    return shareContext;
}

@end
