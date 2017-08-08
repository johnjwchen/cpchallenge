//
//  CPArticle.h
//  PersonalCapital
//
//  Created by JIAWEI CHEN on 8/7/17.
//
//

#import <Foundation/Foundation.h>
#import "Protocols.h"

@interface CPArticle : NSObject <ArticleItem>

@property (nonatomic, readwrite, copy) NSString *htmlTitle;
@property (nonatomic, readwrite, copy) NSString *imageURL;
@property (nonatomic, readwrite, copy) NSString *htmlDescription;
@property (nonatomic, readwrite, copy) NSString *pubDate;
@property (nonatomic, readwrite, copy) NSString *link;

@end
