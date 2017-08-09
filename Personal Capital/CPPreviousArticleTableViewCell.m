//
//  CPPreviousArticleTableViewCell.m
//  PersonalCapital
//
//  Created by JIAWEI CHEN on 8/8/17.
//
//

#import "CPPreviousArticleTableViewCell.h"
#import "CPArticleView.h"
#import "UIImageView+Network.h"

@interface CPPreviousArticleTableViewCell()
@property (nonatomic, strong) CPArticleView *leftArticleView;
@property (nonatomic, strong) CPArticleView *rightArticleView;
@end

@implementation CPPreviousArticleTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        _leftArticleView = [[CPArticleView alloc] initShowDetail:NO];
        _leftArticleView.backgroundColor = self.backgroundColor;
        [self addSubview:_leftArticleView];
        _rightArticleView = [[CPArticleView alloc] initShowDetail:NO];
        _rightArticleView.backgroundColor = self.backgroundColor;
        [self addSubview:_rightArticleView];
        
        [self setUpContraints];
    }
    return self;
}

- (void)setUpContraints {
    UILayoutGuide *margin = self.layoutMarginsGuide;
    [_leftArticleView.topAnchor constraintEqualToAnchor:margin.topAnchor];
    
    [_leftArticleView addConstraint:[NSLayoutConstraint constraintWithItem:_leftArticleView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1 constant:0]];
    
    [_leftArticleView addConstraint:[NSLayoutConstraint constraintWithItem:_leftArticleView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1 constant:[CPArticleView leftSpaceOfTitle]]];
   
    
    [_leftArticleView.rightAnchor constraintEqualToAnchor:_rightArticleView.leftAnchor constant:-[CPArticleView leftSpaceOfTitle]];
    
     [_leftArticleView addConstraint:[NSLayoutConstraint constraintWithItem:_leftArticleView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1 constant:0]];
    
    [_leftArticleView.bottomAnchor constraintEqualToAnchor:self.bottomAnchor];
    [_rightArticleView.topAnchor constraintEqualToAnchor:self.topAnchor];
    [_rightArticleView.rightAnchor constraintEqualToAnchor:self.rightAnchor constant:-[CPArticleView leftSpaceOfTitle]];
    [_rightArticleView.bottomAnchor constraintEqualToAnchor:self.bottomAnchor];
}

- (void)setLeftArticle:(id<ArticleItem>)leftArticle rightArticle:(id<ArticleItem>)rightArticle {
    [_leftArticleView.imageView setImageOfURLString: leftArticle.imageURL];
    [_leftArticleView.titleLabel setText:leftArticle.htmlTitle];
    [_rightArticleView.imageView setImageOfURLString:rightArticle.imageURL];
    [_rightArticleView.titleLabel setText:rightArticle.htmlTitle];
}

@end
