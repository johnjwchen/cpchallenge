//
//  ChannelSource.h
//  PersonalCapital
//
//  Created by JIAWEI CHEN on 8/7/17.
//
//

#import <Foundation/Foundation.h>

OBJC_EXTERN NSString * const kArticles;
OBJC_EXTERN NSString * const kError;

@interface CPChannelSource : NSObject

@property (readonly) NSString *feedURL;
@property (readonly) NSArray *articles;
@property (readonly) NSError *error;

- (instancetype)initWithFeedURLString:(NSString *)feedURLString NS_DESIGNATED_INITIALIZER;

- (void)load;

@end
