//
//  CPArticleView.h
//  PersonalCapital
//
//  Created by JIAWEI CHEN on 8/8/17.
//
//

#import <UIKit/UIKit.h>


@interface CPArticleView : UIView
@property (nonatomic, readonly) UIImageView * imageView;
@property (nonatomic, readonly) UILabel *titleLabel;
@property (nonatomic, readonly)  UILabel * detailLabel;

- (instancetype)initShowDetail:(BOOL)showDetail;

@end
