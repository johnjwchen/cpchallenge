//
//  CPParseOperation.h
//  PersonalCapital
//
//  Created by JIAWEI CHEN on 8/7/17.
//
//

#import <Foundation/Foundation.h>

/*:
 * for notifing delegate it has new aritcles or an error occurs.
*/
@protocol CPParseOperationDelegate <NSObject>
@required
- (void)addArticles:(NSArray *)articles;
- (void)parseError:(NSError *)error;
@end

/*:
 * Operation to parse a RSS feed xml
 * set the parseData as the content
*/
@interface CPParseOperation : NSOperation

@property (nonatomic, copy, readonly) NSData *parseData;
@property (nonatomic, weak) id<CPParseOperationDelegate> delegate;

- (instancetype)initWithData:(NSData *)parseData NS_DESIGNATED_INITIALIZER;

@end
