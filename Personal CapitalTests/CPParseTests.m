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
@property (nonatomic, strong) XCTestExpectation *sourceExpectation;
@property (nonatomic, strong) CPChannelSource *source;
@end

@implementation CPParseTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
    //[[NSRunLoop mainRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:10000]];
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

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"articles"] && [object isKindOfClass:[CPChannelSource class]]) {
        if (_source.articles.count > 10) {
            [_sourceExpectation fulfill];
            [_source removeObserver:self forKeyPath:keyPath];
        }
    }
}

- (void)testCPChanelSource {
    _source = [[CPChannelSource alloc] initWithFeedURLString:RSSFeedURL];
    XCTAssertNotNil(_source);
    
    [_source addObserver:self forKeyPath:@"articles" options:0 context:nil];
    _sourceExpectation = [self expectationWithDescription:@"soure have articles."];
 
    [self measureBlock:^{
        [_source load];
        [self waitForExpectations:@[_sourceExpectation] timeout:12];
    }];
}



@end
