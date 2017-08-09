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

- (instancetype) init {
    self = [super init];
    if (self)
        [self commonInit];
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self)
        [self commonInit];
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder: aDecoder];
    if (self)
        [self commonInit];
    return self;
}

- (void)commonInit {
    self.translatesAutoresizingMaskIntoConstraints = NO;
    _label = [[UILabel alloc] init];
    _label.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:_label];
    UILayoutGuide *margin = self.layoutMarginsGuide;
    [_label.topAnchor constraintEqualToAnchor:margin.topAnchor];
    [_label.leftAnchor constraintEqualToAnchor:margin.leftAnchor constant:[CPArticleView leftSpaceOfTitle]];
    [_label.rightAnchor constraintEqualToAnchor:margin.rightAnchor];
    [_label.bottomAnchor constraintEqualToAnchor:margin.bottomAnchor];
    [self setNeedsUpdateConstraints];
}

@end
