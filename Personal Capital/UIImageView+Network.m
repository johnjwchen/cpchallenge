//
//  UIImageView+UIImageView_Network.m
//  PersonalCapital
//
//  Created by JIAWEI CHEN on 8/8/17.
//
//

#import "UIImageView+Network.h"
#import <objc/runtime.h>


@implementation UIImageView (Network)

- (void)setImageOfURLString:(NSString *)URLString {
    if (URLString == nil) return;
    NSURL *url = [NSURL URLWithString:URLString];
    if (url == nil) return;
    
    __weak UIImageView *weakSelf = self;
    UIActivityIndicatorView *indicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    indicatorView.center = self.center;
    indicatorView.hidesWhenStopped = YES;
    [self addSubview:indicatorView];
    [indicatorView startAnimating];
    
    NSURLSessionDataTask *downloadTask = [[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        [indicatorView stopAnimating];
        [indicatorView removeFromSuperview];
        [weakSelf setNeedsDisplay];
        if (data != nil && error == nil && weakSelf != nil) {
            UIImage *image = [UIImage imageWithData:data];
            dispatch_async(dispatch_get_main_queue(), ^{
                weakSelf.image = image;
                [weakSelf setNeedsDisplay];
            });
        }
    }];
    
    [downloadTask resume];
}

@end
