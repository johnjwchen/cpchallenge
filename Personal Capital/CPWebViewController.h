//
//  CPWebViewController.h
//  PersonalCapital
//
//  Created by JIAWEI CHEN on 8/7/17.
//
//

#import <UIKit/UIKit.h>

/*:
 * a UIViewController holds a UIWebView to display web content
 * set the urlString before showing the View Controller
*/
@interface CPWebViewController : UIViewController
@property (nonatomic, readonly) UIWebView *webView;
@property (nonatomic, copy) NSString *urlString;
@end
