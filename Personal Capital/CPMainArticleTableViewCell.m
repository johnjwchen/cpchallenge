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


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.translatesAutoresizingMaskIntoConstraints = NO;
        self.backgroundColor = [UIColor whiteColor];
        
        _articleView = [[CPArticleView alloc] initShowDetail:YES];
        _articleView.backgroundColor = self.backgroundColor;
        _articleView.translatesAutoresizingMaskIntoConstraints = NO;
        [self.contentView addSubview:_articleView];
        
        [self setUpContraints];
    }
    return self;
}

- (void)setUpContraints {
    UILayoutGuide *margin = self.contentView.layoutMarginsGuide;
    [[_articleView.topAnchor constraintEqualToAnchor:margin.topAnchor] setActive:YES];
    [[_articleView.bottomAnchor constraintEqualToAnchor:margin.bottomAnchor] setActive:YES];
    [[_articleView.leftAnchor constraintEqualToAnchor:margin.leftAnchor] setActive:YES];
    [[_articleView.rightAnchor constraintEqualToAnchor:margin.rightAnchor] setActive:YES];
    [self setNeedsUpdateConstraints];
}

- (void)setArticle:(id<ArticleItem>)article {
    [_articleView.imageView setImageOfURLString:article.imageURL];
    [_articleView.titleLabel setText:article.htmlTitle];
    NSString *detail = nil;
    if (article)
        detail = [NSString stringWithFormat:@"%@ --- %@", [self convertDateString:article.pubDate], article.htmlDescription];
    [_articleView.detailLabel setText:detail];
    [_articleView setNeedsDisplay];
}


- (NSString *)convertDateString:(NSString *)dateString {
    static NSDateFormatter *dateFormatterToString;
    static NSDateFormatter *dateFormatterFromString;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
         NSLocale *enUSPOSIXLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
        dateFormatterToString = [[NSDateFormatter alloc] init];
        [dateFormatterToString setDateFormat:@"MMMM d, yyyy"];
        [dateFormatterToString setLocale:enUSPOSIXLocale];
        dateFormatterFromString = [[NSDateFormatter alloc] init];
        [dateFormatterFromString setLocale:enUSPOSIXLocale];
        // Tue, 08 Aug 2017 20:36:02 +0000
        [dateFormatterFromString setDateFormat:@"E, dd MMM yyyy HH:mm:ss Z"];
    });
    
    NSDate *date = [dateFormatterFromString dateFromString:dateString];
    return [dateFormatterToString stringFromDate: date];
}

@end
