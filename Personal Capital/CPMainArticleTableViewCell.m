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

+ (CGFloat)rowHeight {
    return [CPArticleView heightFromWidth:[UIScreen mainScreen].bounds.size.width hasDetail:YES];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
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
}

- (void)setArticle:(id<ArticleItem>)article {
    if (article == nil) return;
    [_articleView.imageView setImageOfURLString:article.imageURL];
    [_articleView.titleLabel setText:article.htmlTitle];
    NSString *detail = [NSString stringWithFormat:@"%@ — %@", [self convertDateString:article.pubDate], article.htmlDescription];
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:detail];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 6;
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, detail.length)];
    _articleView.detailLabel.attributedText = attributedString;
    
    [_articleView setNeedsDisplay];
    [_articleView setNeedsLayout];
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
