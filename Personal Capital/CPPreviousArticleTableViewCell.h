//
//  CPPreviousArticleTableViewCell.h
//  PersonalCapital
//
//  Created by JIAWEI CHEN on 8/8/17.
//
//

#import <UIKit/UIKit.h>
#import "Protocols.h"
#import "CPArticleView.h"

/*:
 * the previous article row that has two article views
*/
@interface CPPreviousArticleTableViewCell : UITableViewCell

- (void)setLeftArticle:(id<ArticleItem>)leftArticle rightArticle:(id<ArticleItem>)rightArticle;

@property (nonatomic, weak) id<CPViewLinkDelegate> viewLinkDelegate;

+ (CGFloat)rowHeight;
@end
