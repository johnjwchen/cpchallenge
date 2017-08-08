//
//  Personal_CapitalTests.m
//  Personal CapitalTests
//
//  Created by JIAWEI CHEN on 8/6/17.
//
//

#import <XCTest/XCTest.h>
#import "CPWebViewController.h"

@interface Personal_CapitalTests : XCTestCase

@end

@implementation Personal_CapitalTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}


- (void)testWebPageLoading {
    CPWebViewController *webViewController = [[CPWebViewController alloc] init];
    webViewController.urlString = @"https://www.personalcapital.com/blog/market-news/apple-services-generate-impressive-revenue/?displayMobileNavigation=0";
    [[UIApplication sharedApplication].keyWindow addSubview:webViewController.view];
    
    XCTestExpectation *expectation = [[XCTestExpectation alloc] initWithDescription:@"urlString should be nil when web content loaded."];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(10 * NSEC_PER_SEC)),
                   dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        if (webViewController.urlString == nil)
            [expectation fulfill];
    });
    [self waitForExpectations:@[expectation] timeout:20];
    
}

@end
