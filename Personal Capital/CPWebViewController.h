//
//  CPWebViewController.h
//  PersonalCapital
//
//  Created by JIAWEI CHEN on 8/7/17.
//
//

#import <UIKit/UIKit.h>

@interface CPWebViewController : UIViewController
@property (nonatomic, readonly) UIWebView *webView;
@property (nonatomic, copy) NSString *urlString;
@end
