//
//  RSSLoader.m
//  PersonalCapital
//
//  Created by JIAWEI CHEN on 8/6/17.
//
//

#import "RSSLoader.h"

@interface RSSLoader()

@end

@implementation RSSLoader

- (instancetype)initWithURLString:(NSString *)feedURLString {
    if ((self = [super init])) {
        if ((_feedURL = [NSURL URLWithString:feedURLString])) {
            return self;
        }
    }
    self = nil;
    return nil;
}

- (instancetype)initWithURL:(NSURL *)feedURL {
    if ((self = [super init])) {
        if ((_feedURL = feedURL)) {
            return self;
        }
    }
    self = nil;
    return nil;
}

@end
