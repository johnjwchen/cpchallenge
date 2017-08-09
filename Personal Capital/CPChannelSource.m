//
//  ChannelSource.m
//  PersonalCapital
//
//  Created by JIAWEI CHEN on 8/7/17.
//
//

#import "CPChannelSource.h"
#import "CPParseOperation.h"

NSString * const kArticles = @"articles";
NSString * const kError = @"error";

@interface CPChannelSource()<CPParseOperationDelegate>
@property (nonatomic, copy) NSString *feedURL;
@property (nonatomic, strong) NSMutableArray *articles;
@property (nonatomic, strong) NSError *error;

// download task
@property (nonatomic, strong) NSURLSessionDataTask *sessionTask;
// queue that manages a NSOperation for parsing the RSS data
@property (nonatomic, strong) NSOperationQueue *parseQueue;
@end

@implementation CPChannelSource

- (instancetype)init {
    NSAssert(NO, @"Invalid use of init; use initWithFeedURLString to create ChannelSource");
    return [self init];
}

- (instancetype)initWithFeedURLString:(NSString *)feedURLString {
    self = [super init];
    
    if (self != nil & feedURLString != nil) {
        _feedURL = feedURLString;
        _articles = [NSMutableArray new];
        _parseQueue = [NSOperationQueue new];
    }
    return self;
}


- (void)load
{
    [_articles removeAllObjects];
    [self didChangeValueForKey:kArticles];
    
    _sessionTask = [[NSURLSession sharedSession] dataTaskWithURL:[NSURL URLWithString:_feedURL] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error != nil && response == nil) {
            if (error.code == NSURLErrorAppTransportSecurityRequiresSecureConnection) {
                NSAssert(NO, @"NSURLErrorAppTransportSecurityRequiresSecureConnection");
            }
            else {
                [self performSelectorOnMainThread:@selector(errorOccur:) withObject:error waitUntilDone:NO];
            }
        }
        if (response != nil) {
            NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
            if (((httpResponse.statusCode/100) == 2) && [response.MIMEType isEqual:@"application/rss+xml"]) {
                // parse the xml data
                CPParseOperation *parseOperation = [[CPParseOperation alloc] initWithData:data];
                parseOperation.delegate = self;
                [_parseQueue addOperation:parseOperation];
            }
            else {
                NSString *errorString =
                NSLocalizedString(@"HTTP Error", @"Error message displayed when receiving an error from the server.");
                NSDictionary *userInfo = @{NSLocalizedDescriptionKey : errorString};
                NSError *error = [NSError errorWithDomain:@"HTTP"
                                                     code:httpResponse.statusCode
                                                 userInfo:userInfo];
                [self performSelectorOnMainThread:@selector(errorOccur:) withObject:error waitUntilDone:NO];
            }
        }
    }];
    
    [_sessionTask resume];
}


#pragma mark - CPParseOperationDelegate

- (void)addArticles:(NSArray *)articles {
    assert([NSThread isMainThread]);
    // use KVO to notify our client of articles change
    [self willChangeValueForKey:kArticles];
    [_articles addObjectsFromArray:articles];
    [self didChangeValueForKey:kArticles];
}

- (void)errorOccur:(NSError *)error {
    assert([NSThread isMainThread]);
    // use KVO to notify our client of this error
    [self willChangeValueForKey:kError];
    _error = error;
    [self didChangeValueForKey:kError];
}

- (void)parseError:(NSError *)error {
    [self parseError:error];
}

@end
