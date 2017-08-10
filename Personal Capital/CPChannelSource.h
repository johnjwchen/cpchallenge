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

/*:
 * a data modal that holds all aritles of a RSS feed
 * set feedURL and then call the load function to retrive data 
 * use KVO (keys: kArticles, kError) to get data change
*/
@interface CPChannelSource : NSObject

@property (readonly) NSString *feedURL;
@property (readonly) NSArray *articles;
@property (readonly) NSError *error;

- (instancetype)initWithFeedURLString:(NSString *)feedURLString NS_DESIGNATED_INITIALIZER;

- (void)load;

@end
