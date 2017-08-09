//
//  CPMainArticleTableViewCell.m
//  PersonalCapital
//
//  Created by JIAWEI CHEN on 8/8/17.
//
//

#import "CPMainArticleTableViewCell.h"
#import "CPArticleView.h"
#import "UIImageView+Network.h"

@interface CPMainArticleTableViewCell()

@property (nonatomic, strong) CPArticleView *articleView;

@end

@implementation CPMainArticleTableViewCell

- (NSString *)convertDateString:(NSString *)dateString {
    static NSDateFormatter *dateFormatterToString;
    static NSDateFormatter *dateFormatterFromString;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dateFormatterToString = [[NSDateFormatter alloc] init];
        [dateFormatterToString setDateFormat:@"MMM dd, yyyy"];
        dateFormatterFromString = [[NSDateFormatter alloc] init];
        [dateFormatterFromString setDateFormat:@"E, d MMM yyyy HH:mm:ss Z"];
    });
    
    return [dateFormatterToString stringFromDate: [dateFormatterFromString dateFromString:dateString]];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        _articleView = [[CPArticleView alloc] initShowDetail:YES];
        _articleView.backgroundColor = self.backgroundColor;
        [self setUpContraints];
    }
    return self;
}

- (void)setUpContraints {
    [_articleView.topAnchor constraintEqualToAnchor:self.topAnchor];
    [_articleView.bottomAnchor constraintEqualToAnchor:self.bottomAnchor];
    [_articleView.leftAnchor constraintEqualToAnchor:self.leftAnchor];
    [_articleView.rightAnchor constraintEqualToAnchor:self.rightAnchor];
}

- (void)setArticle:(id<ArticleItem>)article {
    [_articleView.imageView setImageOfURLString:article.link];
    [_articleView.titleLabel setText:article.htmlTitle];
    NSString *detail = [NSString stringWithFormat:@"%@ --- %@", [self convertDateString:article.pubDate], article.htmlDescription];
    [_articleView.detailLabel setText:detail];
    [_articleView setNeedsDisplay];
}

@end
