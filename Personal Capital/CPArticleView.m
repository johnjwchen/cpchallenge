//
//  CPArticleView.m
//  PersonalCapital
//
//  Created by JIAWEI CHEN on 8/8/17.
//
//

#import "CPArticleView.h"


@interface CPArticleView()
@property (nonatomic, readwrite, strong) UIImageView *imageView;
@property (nonatomic, readwrite, strong) UILabel *titleLabel;
@property (nonatomic, readwrite, strong)  UILabel *detailLabel;

@property (nonatomic, strong)NSLayoutConstraint *titleHeightConstraint;
@end

@implementation CPArticleView

// calculate row height
+ (CGFloat)heightFromWidth:(CGFloat)width hasDetail:(BOOL)hasDetail {
    if (hasDetail)
        return width * 30/78 + ([self isPad] ? 100 : 88);
    else
        return width * 30/78 + 44;
}

+ (CGFloat)leftSpaceOfTitle {
    return [UIScreen mainScreen].bounds.size.width * 20/667;
}

+ (CGFloat)isPad {
    return [UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad;
}

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

- (UIFont *)titleFont {
    if ([CPArticleView isPad]) {
        return _detailLabel != nil ? [UIFont preferredFontForTextStyle:UIFontTextStyleTitle3] :
        [UIFont preferredFontForTextStyle:UIFontTextStyleSubheadline];
    }
    else {
        return _detailLabel != nil ? [UIFont preferredFontForTextStyle:UIFontTextStyleSubheadline] :
        (UIDeviceOrientationIsPortrait([UIDevice currentDevice].orientation) ? [UIFont systemFontOfSize:11] :
         [UIFont preferredFontForTextStyle:UIFontTextStyleFootnote]);
    }
}

- (UIFont *)detailFont {
    return [CPArticleView isPad] ? [UIFont preferredFontForTextStyle:UIFontTextStyleBody] :
    [UIFont systemFontOfSize:11];
}

- (CGFloat)titleLabelHeigh {
    return _detailLabel == nil ? 44 : 33;
}

- (instancetype)initShowDetail:(BOOL)showDetail {
    self = [self init];
    if (self) {
        self.layer.borderColor = [UIColor grayColor].CGColor;
        self.layer.borderWidth = 0.9;
        _imageView = [[UIImageView alloc] init];
        _imageView.translatesAutoresizingMaskIntoConstraints = NO;
        _imageView.contentMode = UIViewContentModeScaleAspectFill;
        _imageView.clipsToBounds = YES;
        _imageView.backgroundColor = [UIColor whiteColor];
        
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _titleLabel.numberOfLines = showDetail? 0 : 2;
        _titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        _titleLabel.adjustsFontSizeToFitWidth = NO;
        
        [self addSubview:_imageView];
        [self addSubview:_titleLabel];
        if (showDetail) {
            _detailLabel = [[UILabel alloc] init];
            _detailLabel.translatesAutoresizingMaskIntoConstraints = NO;
            _detailLabel.numberOfLines = [CPArticleView isPad]  ? 3 : 2;
            _detailLabel.lineBreakMode = NSLineBreakByTruncatingTail;
            _detailLabel.adjustsFontSizeToFitWidth = NO;
            [self addSubview:_detailLabel];
        }
        
        _titleLabel.font = [self titleFont];
        _detailLabel.font = [self detailFont];
        
        [self setContraints];
    }
    return self;
}


#pragma mark - set constraints

- (void)updateConstraints {
    _titleHeightConstraint.constant = [self titleLabelHeigh];
    [super updateConstraints];
}

- (void)setContraints {
    UILayoutGuide *margin = self.layoutMarginsGuide;
    [[_imageView.topAnchor constraintEqualToAnchor:margin.topAnchor] setActive:YES];
    [[_imageView.leadingAnchor constraintEqualToAnchor:margin.leadingAnchor] setActive:YES];
    [[_imageView.trailingAnchor constraintEqualToAnchor:margin.trailingAnchor] setActive:YES];

    [[_imageView.bottomAnchor constraintEqualToAnchor:_titleLabel.topAnchor constant:0] setActive:YES];
    [[_titleLabel.leftAnchor constraintEqualToAnchor:margin.leftAnchor constant:[CPArticleView leftSpaceOfTitle]] setActive:YES];
    [[_titleLabel.rightAnchor constraintEqualToAnchor:margin.rightAnchor] setActive:YES];
    _titleHeightConstraint = [_titleLabel.heightAnchor constraintEqualToConstant:[self titleLabelHeigh]];
    [_titleHeightConstraint setActive:YES];
    
    if (_detailLabel == nil) {
        [[_titleLabel.bottomAnchor constraintEqualToAnchor:margin.bottomAnchor constant:-6] setActive:YES];
    }
    else {
        [[_titleLabel.bottomAnchor constraintEqualToAnchor:_detailLabel.topAnchor constant:0] setActive:YES];
        
        [[_detailLabel.leftAnchor constraintEqualToAnchor:margin.leftAnchor constant:[CPArticleView leftSpaceOfTitle]] setActive:YES];
        [[_detailLabel.rightAnchor constraintEqualToAnchor:margin.rightAnchor] setActive:YES];
        [[_detailLabel.bottomAnchor constraintEqualToAnchor:margin.bottomAnchor constant:-6] setActive:YES];
    }
}

#pragma mark - touch events

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    self.backgroundColor = [UIColor lightGrayColor];
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesCancelled:touches withEvent:event];
    self.backgroundColor = [UIColor whiteColor];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesEnded:touches withEvent:event];
    self.backgroundColor = [UIColor whiteColor];
}

@end
