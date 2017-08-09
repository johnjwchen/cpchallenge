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
    [self setNeedsLayout];
}
- (CGFloat)borderWidth {
    return self.layer.borderWidth;
}

- (instancetype)initShowDetail:(BOOL)showDetail {
    self = [self init];
    if (self) {
        self.layer.borderColor = [UIColor grayColor].CGColor;
        self.layer.borderWidth = 0.9;
        _imageView = [[UIImageView alloc] init];
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.numberOfLines = 1;
        if (showDetail) {
            _detailLabel = [[UILabel alloc] init];
            _detailLabel.numberOfLines = IDIOM == IPAD ? 3 : 2;
            
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
    [[_imageView.topAnchor constraintEqualToAnchor:self.topAnchor constant:self.borderWidth] setActive:YES];
    [[_imageView.leftAnchor constraintEqualToAnchor:self.leftAnchor constant:self.borderWidth] setActive:YES];
    [[_imageView.rightAnchor constraintEqualToAnchor:self.rightAnchor constant:self.borderWidth] setActive:YES];
    [[_imageView.bottomAnchor constraintEqualToAnchor:_titleLabel.topAnchor constant:1] setActive:YES];
    
    [[_titleLabel.leftAnchor constraintEqualToAnchor:self.leftAnchor constant: [CPArticleView leftSpaceOfTitle]] setActive:YES];
    [[_titleLabel.rightAnchor constraintEqualToAnchor:self.rightAnchor constant:self.borderWidth] setActive:YES];
    [[_titleLabel.heightAnchor constraintEqualToConstant:44] setActive:YES];
    if (_detailLabel == nil) {
        [[_titleLabel.bottomAnchor constraintEqualToAnchor:self.bottomAnchor constant:self.borderWidth] setActive:YES];
    }
    else {
        [[_titleLabel.bottomAnchor constraintEqualToAnchor:_detailLabel.topAnchor constant:1] setActive:YES];
        [[_detailLabel.leftAnchor constraintEqualToAnchor:self.leftAnchor constant:[CPArticleView leftSpaceOfTitle]] setActive:YES];
        [[_detailLabel.rightAnchor constraintEqualToAnchor:self.rightAnchor constant:self.borderWidth] setActive:YES];
        [_detailLabel.heightAnchor constraintEqualToConstant: heightForDetailLabelOfOneLine * _detailLabel.numberOfLines];
    }
}

@end
