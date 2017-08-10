//
//  CPParseOperation.m
//  PersonalCapital
//
//  Created by JIAWEI CHEN on 8/7/17.
//
//

#import "CPParseOperation.h"
#import "CPArticle.h"

#pragma mark - Parser constants

static NSUInteger const kSizeOfArticleBatch = 10;
static NSString * const kArticleName = @"item";
static NSString * const kTitleName = @"title";
static NSString * const kImageName = @"media:content";
static NSString * const kDescriptionName = @"description";
static NSString * const kPubDateName = @"pubDate";
static NSString * const kLinkName = @"link";

@interface CPParseOperation() <NSXMLParserDelegate>

@property (nonatomic) CPArticle *currentArticle;
@property (nonatomic) NSMutableArray *currentParseBatch;

@property (nonatomic) NSMutableString *currentParsedString;
@property (nonatomic, assign) BOOL accumulatingParsedString;

// a stack containing  elements as they are being parsed. for detating malformed xml
@property (nonatomic, strong) NSMutableArray *elementStack;
@property (nonatomic, strong) NSSet *parseTags;
@end

@implementation CPParseOperation


- (instancetype)init {
    NSAssert(NO, @"Invalid use of init; use initWithData to create CPParseOperation");
    return [self init];
}

- (instancetype)initWithData:(NSData *)parseData {
    self = [super init];
    if (self != nil && parseData != nil) {
        _parseData = [parseData copy];
        _currentParseBatch = [NSMutableArray new];
        _currentParsedString = [NSMutableString new];
        _elementStack = [[NSMutableArray alloc] init];
        
        _parseTags = [[NSSet alloc] initWithObjects:kArticleName, kTitleName, kImageName, kDescriptionName, kPubDateName, kLinkName, nil];
    }
    return self;
}

- (void)main
{
    NSXMLParser *parser = [[NSXMLParser alloc] initWithData:_parseData];
    parser.delegate = self;
    [parser parse];
    
    // add the rest articles
    if (_currentParseBatch.count > 0) {
        [self addArticle:_currentParseBatch];
        [_currentParseBatch removeAllObjects];
    }
}

#pragma mark - Notification of data change or error

- (void)addArticle:(NSArray *)articles {
    if (_delegate == nil) return;
    if (![NSThread isMainThread]) {
        dispatch_sync(dispatch_get_main_queue(), ^{
            [_delegate addArticles:articles];
        });
    }
    else {
        [_delegate addArticles:articles];
    }
}


- (void)handleParseError:(NSError *)parseError
{
    if (_delegate == nil) return;
    if (![NSThread isMainThread]) {
        dispatch_sync(dispatch_get_main_queue(), ^{
            [_delegate parseError:parseError];
        });
    }
    else {
        [_delegate parseError:parseError];
    }
}


#pragma mark - NSXMLParserDelegate

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    [self.elementStack addObject:elementName];
   
    if ([elementName isEqualToString:kArticleName]) {
        CPArticle *article = [CPArticle new];
        _currentArticle = article;
    }
    if ([elementName isEqualToString:kImageName]) {
        _currentArticle.imageURL = attributeDict[@"url"];
    }
    
    if ([_parseTags containsObject:elementName]) {
        _accumulatingParsedString = YES;
        _currentParsedString = [NSMutableString stringWithString:@""];
    }
}


- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    if ([elementName isEqualToString:_elementStack.lastObject]) {
        [_elementStack removeLastObject];
    }
    else {
        NSLog(@"could not find end element of \"%@\"", elementName);
        [_elementStack removeAllObjects];
        [parser abortParsing];
    }
    
    if ([elementName isEqualToString:kArticleName]) {
        [_currentParseBatch addObject:_currentArticle];
        
        if (_currentParseBatch.count >= kSizeOfArticleBatch) {
            [self addArticle:_currentParseBatch];
            [_currentParseBatch removeAllObjects];
        }
    }
    else if ([elementName isEqualToString:kTitleName]) {
        _currentArticle.htmlTitle = _currentParsedString;
    }
    else if ([elementName isEqualToString:kLinkName]) {
        _currentArticle.link = _currentParsedString;
    }
    else if ([elementName isEqualToString:kPubDateName]) {
        _currentArticle.pubDate = _currentParsedString;
    }
    
    _accumulatingParsedString = NO;
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    if (_accumulatingParsedString) {
        [_currentParsedString appendString:string];
    }
}

- (void)parser:(NSXMLParser *)parser foundCDATA:(NSData *)CDATABlock {
    if ([_elementStack.lastObject isEqualToString:kDescriptionName]) {
        NSString *htmlDescription = [[NSString alloc] initWithData:CDATABlock encoding:NSUTF8StringEncoding];
        static NSRegularExpression *regExpression;
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            regExpression = [[NSRegularExpression alloc] initWithPattern:@"<.?p>" options:NSRegularExpressionCaseInsensitive error:nil];
        });
        _currentArticle.htmlDescription = [regExpression stringByReplacingMatchesInString:htmlDescription options:0 range:NSMakeRange(0, [htmlDescription length]) withTemplate:@""];
    }
}

- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError
{
    if (parseError.code != NSXMLParserDelegateAbortedParseError) {
        [self handleParseError:parseError];
    }
}



@end
