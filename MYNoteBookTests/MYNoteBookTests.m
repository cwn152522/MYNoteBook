//
//  MYNoteBookTests.m
//  MYNoteBookTests
//
//  Created by chenweinan on 16/11/3.
//  Copyright © 2016年 chenweinan. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "MYNetwork.h"
#import "MYGetJobDetailRequest.h"
#import "MYGetJobDetailResponed.h"

#import "MYNotesUtility.h"

@interface MYNoteBookTests : XCTestCase

@property (strong, nonatomic) MYNotesUtility *notesUtility;

@end

@implementation MYNoteBookTests

- (void)setUp {//初始化代码，在测试方法调用之前调用
    [super setUp];
    
    self.notesUtility = [MYNotesUtility defaultUtility];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {//每个测试用例执行结束后都会调用
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
    
    self.notesUtility = nil;
}

- (void)testExample {//测试用例的例子
    NSArray *array = [self.notesUtility filterArrayWithPredicate:[NSPredicate predicateWithFormat:@"Name CONTAINS %@", @"绘制"]];
    XCTAssertNotNil(array, @"测试不通过！");
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

- (void)testExpectationExample{
    XCTestExpectation *expectation = [self expectationWithDescription:@"MYGetJobDetailRequest"];
    
    MYGetJobDetailRequest *request = [[MYGetJobDetailRequest alloc] init];
    request.ID = [@"5865" integerValue];
    
    NSInteger requestId = [[MYNetworkProxy defaultProxy] httpPostWithRequestObj:request entityClass:@"MYGetJobDetailResponed" withCompleteBlock:^(MYNetworkResponse *response) {
        [expectation fulfill];
        if(response.status == MYNetworkResponseStatusSuccessed){
            MYGetJobDetailResponed *responed = (MYGetJobDetailResponed *)response.content;
            XCTAssertNotNil(responed, @"请求成功，数据出错");
            return ;
        }else if(response.status == MYNetworkResponseStatusFailed){
            XCTFail(@"请求失败");
        }
    }];
    
    [self waitForExpectationsWithTimeout:10 handler:^(NSError * _Nullable error) {
        [[MYNetworkProxy defaultProxy] cancelRequestWithRequestId:requestId taskType:MYNetworkTaskTypeData];
    }];
}

- (void)testPerformanceExample {//测试性能例子
    // This is an example of a performance test case.
    [self measureBlock:^{
        int num = 0;
        for (int a = 0; a < 100; a ++) {
            num = a + 10 * 100;
            NSLog(@"%d", num);
        }
        // Put the code you want to measure the time of here.
    }];
}

@end
