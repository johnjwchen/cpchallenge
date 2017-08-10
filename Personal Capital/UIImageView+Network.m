//
//  UIImageView+UIImageView_Network.m
//  PersonalCapital
//
//  Created by JIAWEI CHEN on 8/8/17.
//
//

#import "UIImageView+Network.h"
#import <objc/runtime.h>


static char kDownloadTask;
static char kIndicator;

@implementation UIImageView (Network)

/*:
 * Asynchronously download the image data while display a indicator on the image view
*/
- (void)setImageOfURLString:(NSString *)URLString {
    NSURL *url = [NSURL URLWithString:URLString];
    if (url == nil) {
        self.image = nil;
        return;
    }
    // cancel previous download task
    NSURLSessionDataTask *oldTask = objc_getAssociatedObject(self, &kDownloadTask);
    UIActivityIndicatorView *oldIndicator = objc_getAssociatedObject(self, &kIndicator);
    [oldTask cancel];
    [oldIndicator stopAnimating];
    [oldIndicator removeFromSuperview];
    
    // remove them
    objc_setAssociatedObject(self, &kIndicator, nil, OBJC_ASSOCIATION_RETAIN);
    objc_setAssociatedObject(self, &kDownloadTask, nil, OBJC_ASSOCIATION_RETAIN);
    
    __weak UIImageView *weakSelf = self;
    UIActivityIndicatorView *indicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    
    indicatorView.center = CGPointMake(self.bounds.size.width/2 - indicatorView.frame.size.width/2, self.bounds.size.height/2 - indicatorView.frame.size.height/2);
    indicatorView.hidesWhenStopped = YES;
    [self addSubview:indicatorView];
    [indicatorView startAnimating];
    
    __weak UIActivityIndicatorView *weakIndicator = indicatorView;
    // download the image data
    NSURLSessionDataTask *downloadTask = [[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        UIImage *image = [UIImage imageWithData:data];

        // back to main thread
        dispatch_async(dispatch_get_main_queue(), ^{
            if (weakSelf != nil) {
                objc_setAssociatedObject(weakSelf, &kIndicator, nil, OBJC_ASSOCIATION_RETAIN);
                objc_setAssociatedObject(weakSelf, &kDownloadTask, nil, OBJC_ASSOCIATION_RETAIN);
            }
            [weakIndicator stopAnimating];
            [weakIndicator removeFromSuperview];
            
            weakSelf.image = image;
            [weakSelf setNeedsDisplay];
        });
    }];
    
    objc_setAssociatedObject(self, &kIndicator, indicatorView, OBJC_ASSOCIATION_RETAIN);
    objc_setAssociatedObject(self, &kDownloadTask, downloadTask, OBJC_ASSOCIATION_RETAIN);
    [downloadTask resume];
}

@end
