//
//  Protocols.h
//  PersonalCapital
//
//  Created by JIAWEI CHEN on 8/7/17.
//
//

#import <Foundation/Foundation.h>

/*:
 * protocol that will be used by the corresonding view to show article content
*/
@protocol ArticleItem <NSObject>

@property (readonly, copy) NSString *htmlTitle;
@property (readonly, copy) NSString *imageURL;
@property (readonly, copy) NSString *htmlDescription;
@property (readonly, copy) NSString *pubDate;
@property (readonly, copy) NSString *link;

@end
