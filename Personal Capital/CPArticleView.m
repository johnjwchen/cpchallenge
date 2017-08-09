//
//  CPArticleView.m
//  PersonalCapital
//
//  Created by JIAWEI CHEN on 8/8/17.
//
//

#import "CPArticleView.h"

#define IDIOM    UI_USER_INTERFACE_IDIOM()
#define IPAD     UIUserInterfaceIdiomPad

@interface CPArticleView()
@property (nonatomic, readwrite, strong) UIImageView *imageView;
@property (nonatomic, readwrite, strong) UILabel *titleLabel;
@property (nonatomic, readwrite, strong)  UILabel *detailLabel;
@end

@implementation CPArticleView

- (void)setBorderColor:(CGColorRef)borderColor {
    self.layer.borderColor = borderColor;
    [self.layer setNeedsDisplay];
}
- (CGColorRef)borderColor {
    return self.layer.borderColor;
}
- (void)setBorderWidth:(CGFloat)borderWidth {
    self.layer.borderWidth = borderWidth;
    [self setLayoutMargins:UIEdgeInsetsMake(self.borderWidth, self.borderWidth, self.borderWidth, self.borderWidth)];
    [self setNeedsUpdateConstraints];
}
- (CGFloat)borderWidth {
    return self.layer.borderWidth;
}

- (instancetype)initShowDetail:(BOOL)showDetail {
    self = [self init];
    if (self) {
        self.translatesAutoresizingMaskIntoConstraints = NO;
        self.layer.borderColor = [UIColor grayColor].CGColor;
        self.layer.borderWidth = 0.9;
        _imageView = [[UIImageView alloc] init];
        _imageView.translatesAutoresizingMaskIntoConstraints = NO;
        _imageView.contentMode = UIViewContentModeScaleAspectFit;
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _titleLabel.numberOfLines = 1;
        [self addSubview:_imageView];
        [self addSubview:_titleLabel];
        if (showDetail) {
            _detailLabel = [[UILabel alloc] init];
            _detailLabel.translatesAutoresizingMaskIntoConstraints = NO;
            _detailLabel.numberOfLines = IDIOM == IPAD ? 3 : 2;
            [self addSubview:_detailLabel];
            
        }
        [self setContraints];
    }
    return self;
}


+ (CGFloat)leftSpaceOfTitle {
    return 20;
}
static CGFloat heightForDetailLabelOfOneLine = 25;
- (void)setContraints {
    UILayoutGuide *margin = self.layoutMarginsGuide;
    [[_imageView.topAnchor constraintEqualToAnchor:margin.topAnchor] setActive:YES];
    [[_imageView.leftAnchor constraintEqualToAnchor:margin.leftAnchor] setActive:YES];
    [[_imageView.rightAnchor constraintEqualToAnchor:margin.rightAnchor] setActive:YES];
    

    [[_imageView.bottomAnchor constraintEqualToAnchor:_titleLabel.topAnchor constant:0] setActive:YES];
    [[_titleLabel.leftAnchor constraintEqualToAnchor:margin.leftAnchor constant:[CPArticleView leftSpaceOfTitle]] setActive:YES];
    [[_titleLabel.rightAnchor constraintEqualToAnchor:margin.rightAnchor] setActive:YES];
    [[_titleLabel.heightAnchor constraintEqualToConstant:44] setActive:YES];
    
    if (_detailLabel == nil) {
        [[_titleLabel.bottomAnchor constraintEqualToAnchor:margin.bottomAnchor] setActive:YES];
    }
    else {
        [[_titleLabel.bottomAnchor constraintEqualToAnchor:_detailLabel.topAnchor constant:0] setActive:YES];
        
        [[_detailLabel.leftAnchor constraintEqualToAnchor:margin.leftAnchor constant:[CPArticleView leftSpaceOfTitle]] setActive:YES];
        [[_detailLabel.rightAnchor constraintEqualToAnchor:margin.rightAnchor] setActive:YES];
        [[_detailLabel.bottomAnchor constraintEqualToAnchor:margin.bottomAnchor] setActive:YES];
     
        [[_detailLabel.heightAnchor constraintEqualToConstant: heightForDetailLabelOfOneLine * _detailLabel.numberOfLines] setActive:YES];
    }
    [self setNeedsUpdateConstraints];
}

@end
