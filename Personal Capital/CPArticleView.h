//
//  CPArticleView.h
//  PersonalCapital
//
//  Created by JIAWEI CHEN on 8/8/17.
//
//

#import <UIKit/UIKit.h>

@protocol CPViewLinkDelegate <NSObject>

@required
- (void)viewArticleURL:(NSString *)articleURLString;

@end

/*:
 * The view represents the retangle area of article with image, title and (or) detail
*/
@interface CPArticleView : UIControl
@property (nonatomic, readwrite) CGColorRef borderColor;
@property (nonatomic, readwrite) CGFloat borderWidth;
@property (nonatomic, readonly) UIImageView * imageView;
@property (nonatomic, readonly) UILabel *titleLabel;
@property (nonatomic, readonly)  UILabel * detailLabel;

@property (nonatomic, copy) NSString *urlString;

- (instancetype)initShowDetail:(BOOL)showDetail;

+ (CGFloat)leftSpaceOfTitle;
+ (CGFloat)heightFromWidth:(CGFloat)width hasDetail:(BOOL)hasDetail;

@end
