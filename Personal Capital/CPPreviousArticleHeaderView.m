//
//  CPPreviousArticleHeaderView.m
//  PersonalCapital
//
//  Created by JIAWEI CHEN on 8/8/17.
//
//

#import "CPPreviousArticleHeaderView.h"
#import "CPArticleView.h"

@interface CPPreviousArticleHeaderView()

@property (nonatomic, readwrite, strong) UILabel *label;

@end

@implementation CPPreviousArticleHeaderView

- (instancetype)initWithReuseIdentifier:(nullable NSString *)reuseIdentifier {
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        self.contentView.translatesAutoresizingMaskIntoConstraints = NO;
        _label = [[UILabel alloc] init];
        _label.font = [UIFont preferredFontForTextStyle:UIFontTextStyleSubheadline];
        _label.translatesAutoresizingMaskIntoConstraints = NO;
        [self.contentView addSubview:_label];
        UILayoutGuide *margin = self.layoutMarginsGuide;
        [[_label.topAnchor constraintEqualToAnchor:margin.topAnchor] setActive:YES];
        [[_label.leftAnchor constraintEqualToAnchor:margin.leftAnchor constant:[CPArticleView leftSpaceOfTitle]] setActive:YES];
        [[_label.rightAnchor constraintEqualToAnchor:margin.rightAnchor] setActive:YES];
        [[_label.bottomAnchor constraintEqualToAnchor:margin.bottomAnchor] setActive:YES];
        [self setNeedsUpdateConstraints];
    }
    return self;
}

@end
