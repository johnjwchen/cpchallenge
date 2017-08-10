//
//  CPPreviousArticleHeaderView.m
//  PersonalCapital
//
//  Created by JIAWEI CHEN on 8/8/17.
//
//

#import "CPPreviousArticleHeaderTableViewCell.h"
#import "CPArticleView.h"

@interface CPPreviousArticleHeaderTableViewCell()

@property (nonatomic, readwrite, strong) UILabel *label;

@end

@implementation CPPreviousArticleHeaderTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
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
    }
    return self;
}

@end
