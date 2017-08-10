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

/*:
 * tableview cell of the main article 
*/
@interface CPMainArticleTableViewCell : UITableViewCell

@property (nonatomic, weak) id<CPViewLinkDelegate> viewLinkDelegate; // deleagte to handle article click

- (void)setArticle:(id<ArticleItem>)article;

+ (CGFloat)rowHeight;

@end
