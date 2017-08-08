//
//  CPParseOperationTests.m
//  PersonalCapital
//
//  Created by JIAWEI CHEN on 8/7/17.
//
//

#import <XCTest/XCTest.h>
#import "CPParseOperation.h"
#import "Constants.h"
#import "CPChannelSource.h"


@interface CPParseTests : XCTestCase

@end

@implementation CPParseTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
    // [[NSRunLoop mainRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:10000]];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testCPParseOperationInit {
    NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:RSSFeedURL]];
    XCTAssertNotNil(data);
    CPParseOperation *op = [[CPParseOperation alloc] initWithData:data];
    XCTAssertNotNil(op);
}

- (void)testCPChanelSource {
    CPChannelSource *source = [[CPChannelSource alloc] initWithFeedURLString:RSSFeedURL];
    XCTAssertNotNil(source);
    [source load];
}



- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
