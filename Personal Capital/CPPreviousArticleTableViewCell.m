//
//  CPPreviousArticleTableViewCell.m
//  PersonalCapital
//
//  Created by JIAWEI CHEN on 8/8/17.
//
//

#import "CPPreviousArticleTableViewCell.h"
#import "UIImageView+Network.h"

@interface CPPreviousArticleTableViewCell()
@property (nonatomic, strong) CPArticleView *leftArticleView;
@property (nonatomic, strong) CPArticleView *rightArticleView;
@end

@implementation CPPreviousArticleTableViewCell

+ (CGFloat)rowHeight {
    CGFloat ratio = UIDeviceOrientationIsPortrait([UIDevice currentDevice].orientation) || [UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPhone ? 1 : 0.7;
    return ratio * [CPArticleView heightFromWidth:[UIScreen mainScreen].bounds.size.width/2 hasDetail:NO];
}

- (void)clickArticle:(CPArticleView *)articleView {
    [_viewLinkDelegate viewArticleURL:articleView.urlString];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.translatesAutoresizingMaskIntoConstraints = NO;
        self.backgroundColor = [UIColor whiteColor];
        
        _leftArticleView = [[CPArticleView alloc] initShowDetail:NO];
        _leftArticleView.backgroundColor = self.backgroundColor;
        _leftArticleView.translatesAutoresizingMaskIntoConstraints = NO;
        [self.contentView addSubview:_leftArticleView];
        [_leftArticleView addTarget:self action:@selector(clickArticle:) forControlEvents:UIControlEventTouchUpInside];
        
        _rightArticleView = [[CPArticleView alloc] initShowDetail:NO];
        _rightArticleView.backgroundColor = self.backgroundColor;
        _rightArticleView.translatesAutoresizingMaskIntoConstraints = NO;
        [self.contentView addSubview:_rightArticleView];
        [_rightArticleView addTarget:self action:@selector(clickArticle:) forControlEvents:UIControlEventTouchUpInside];
        
        [self setUpContraints];
    }
    return self;
}


- (void)setUpContraints {
    UILayoutGuide *margin = self.contentView.layoutMarginsGuide;
    
    [[_leftArticleView.topAnchor constraintEqualToAnchor:margin.topAnchor] setActive:YES];
    [[_leftArticleView.leftAnchor constraintEqualToAnchor:margin.leftAnchor constant:[CPArticleView leftSpaceOfTitle]] setActive:YES];
    [[_leftArticleView.bottomAnchor constraintEqualToAnchor:margin.bottomAnchor] setActive:YES];
    
    [[_leftArticleView.rightAnchor constraintEqualToAnchor:_rightArticleView.leftAnchor constant:-[CPArticleView leftSpaceOfTitle]] setActive:YES];
    
    [[_leftArticleView.widthAnchor constraintEqualToAnchor:_rightArticleView.widthAnchor] setActive:YES];
    
    [[_rightArticleView.topAnchor constraintEqualToAnchor:margin.topAnchor] setActive:YES];
    [[_rightArticleView.rightAnchor constraintEqualToAnchor:margin.rightAnchor constant:-[CPArticleView leftSpaceOfTitle]] setActive:YES];
    [[_rightArticleView.bottomAnchor constraintEqualToAnchor:margin.bottomAnchor] setActive:YES];
    
    [self.contentView setNeedsUpdateConstraints];
}

// set aritcle content: image, title 
- (void)setLeftArticle:(id<ArticleItem>)leftArticle rightArticle:(id<ArticleItem>)rightArticle {
    _leftArticleView.urlString = leftArticle.link;
    [_leftArticleView.imageView setImageOfURLString: leftArticle.imageURL];
    [_leftArticleView.titleLabel setText:leftArticle.htmlTitle];
    
    [_rightArticleView setHidden:(rightArticle == nil)];
    _rightArticleView.urlString = rightArticle.link;
    [_rightArticleView.imageView setImageOfURLString:rightArticle.imageURL];
    [_rightArticleView.titleLabel setText:rightArticle.htmlTitle];
    
    [_rightArticleView setNeedsLayout];
    [_rightArticleView layoutIfNeeded];
    [_leftArticleView setNeedsLayout];
    [_leftArticleView layoutIfNeeded];
}


@end
