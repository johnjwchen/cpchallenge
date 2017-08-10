//
//  CPMainArticleTableViewCell.h
//  PersonalCapital
//
//  Created by JIAWEI CHEN on 8/8/17.
//
//

#import <UIKit/UIKit.h>
#import "Protocols.h"
#import "CPArticleView.h"

@interface CPMainArticleTableViewCell : UITableViewCell

@property (nonatomic, weak) id<CPViewLinkDelegate> viewLinkDelegate;

- (void)setArticle:(id<ArticleItem>)article;

+ (CGFloat)rowHeight;

@end
