//
//  CPPreviousArticleTableViewCell.h
//  PersonalCapital
//
//  Created by JIAWEI CHEN on 8/8/17.
//
//

#import <UIKit/UIKit.h>
#import "Protocols.h"

@interface CPPreviousArticleTableViewCell : UITableViewCell

- (void)setLeftArticle:(id<ArticleItem>)leftArticle rightArticle:(id<ArticleItem>)rightArticle;

@end
