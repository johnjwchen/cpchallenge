//
//  RSSLoader.h
//  PersonalCapital
//
//  Created by JIAWEI CHEN on 8/6/17.
//
//

#import <Foundation/Foundation.h>

@interface RSSLoader : NSObject
@property (nonatomic, readonly, strong) NSURL* feedURL;

- (instancetype)initWithURLString:(NSString *)feedURLString;
- (instancetype)initWithURL:(NSURL *)feedURL;
@end
