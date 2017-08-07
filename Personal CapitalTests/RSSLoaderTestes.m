//
//  RSSLoaderTestes.m
//  PersonalCapital
//
//  Created by JIAWEI CHEN on 8/6/17.
//
//

#import <XCTest/XCTest.h>
#import "RSSLoader.h"

@interface RSSLoaderTestes : XCTestCase

@end

@implementation RSSLoaderTestes

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testRSSLoaderInit {
    RSSLoader *nilLoader = [[RSSLoader alloc] initWithURLString:nil];
    XCTAssertNil(nilLoader);
    RSSLoader *nilLoader2 = [[RSSLoader alloc] initWithURL:nil];
    XCTAssertNil(nilLoader2);
    
    RSSLoader *notNilLoader = [[RSSLoader alloc] initWithURLString:@"https://blog.personalcapital.com/feed/?cat=3,891,890,68,284"];
    XCTAssertNotNil(notNilLoader);
    
    RSSLoader *notNilLoader2 = [[RSSLoader alloc] initWithURL:[NSURL URLWithString:@"https://blog.personalcapital.com/feed/?cat=3,891,890,68,284"]];
    XCTAssertNotNil(notNilLoader2);
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
