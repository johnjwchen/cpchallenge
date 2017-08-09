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
    NSURL *url = [NSURL URLWithString:URLString];
    if (url == nil) {
        self.image = nil;
        return;
    }
    
    __weak UIImageView *weakSelf = self;
    UIActivityIndicatorView *indicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    
    indicatorView.center = CGPointMake(self.bounds.size.width/2 - indicatorView.frame.size.width/2, self.bounds.size.height/2 - indicatorView.frame.size.height/2);
    indicatorView.hidesWhenStopped = YES;
    [self addSubview:indicatorView];
    [indicatorView startAnimating];
    
    __weak UIActivityIndicatorView *weakIndicator = indicatorView;
    
    NSURLSessionDataTask *downloadTask = [[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        UIImage *image = [UIImage imageWithData:data];
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakIndicator stopAnimating];
            [weakIndicator removeFromSuperview];
            [weakSelf setNeedsDisplay];
            weakSelf.image = image;
            [weakSelf setNeedsDisplay];
        });
    }];
    
    [downloadTask resume];
}

@end
