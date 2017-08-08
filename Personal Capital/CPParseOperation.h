//
//  CPParseOperation.h
//  PersonalCapital
//
//  Created by JIAWEI CHEN on 8/7/17.
//
//

#import <Foundation/Foundation.h>

@protocol CPParseOperationDelegate <NSObject>
@required
- (void)addArticles:(NSArray *)articles;
- (void)parseError:(NSError *)error;
@end

@interface CPParseOperation : NSOperation

@property (nonatomic, copy, readonly) NSData *parseData;
@property (nonatomic, weak) id<CPParseOperationDelegate> delegate;

- (instancetype)initWithData:(NSData *)parseData NS_DESIGNATED_INITIALIZER;

@end
