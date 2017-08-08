//
//  Personal_CapitalUITests.m
//  Personal CapitalUITests
//
//  Created by JIAWEI CHEN on 8/6/17.
//
//

#import <XCTest/XCTest.h>

@interface Personal_CapitalUITests : XCTestCase

@end

@implementation Personal_CapitalUITests

- (void)setUp {
    [super setUp];
    
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
    // In UI tests it is usually best to stop immediately when a failure occurs.
    self.continueAfterFailure = NO;
    // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
    [[[XCUIApplication alloc] init] launch];
    
    // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}


- (void)testManualWindowCreation {
    XCTAssertNotNil([[[[XCUIApplication alloc] init] childrenMatchingType:XCUIElementTypeWindow] elementBoundByIndex:0]);
    
}

- (void)testDeviceOrentations {
    [XCUIDevice sharedDevice].orientation = UIDeviceOrientationLandscapeLeft;
    [[[XCUIApplication alloc] init].tables[@"Empty list"] tap];
    [XCUIDevice sharedDevice].orientation = UIDeviceOrientationPortraitUpsideDown;
    [XCUIDevice sharedDevice].orientation = UIDeviceOrientationLandscapeRight;
    [XCUIDevice sharedDevice].orientation = UIDeviceOrientationLandscapeRight;
    [XCUIDevice sharedDevice].orientation = UIDeviceOrientationPortrait;
    [XCUIDevice sharedDevice].orientation = UIDeviceOrientationLandscapeLeft;
    [XCUIDevice sharedDevice].orientation = UIDeviceOrientationPortraitUpsideDown;
    
    
    
}


@end
