//
//  CPWebViewController.m
//  PersonalCapital
//
//  Created by JIAWEI CHEN on 8/7/17.
//
//

#import "CPWebViewController.h"


@interface CPWebViewController ()<UIWebViewDelegate>
@property (nonatomic, strong) UIWebView *webView;
@property (nonatomic, strong) UIActivityIndicatorView *indicatorView;
@end

@implementation CPWebViewController

#pragma mark - orientation support

- (BOOL)shouldAutorotate {
    return YES;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskAll;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Loading...";
    _webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    _webView.delegate = self;
    [self.view addSubview:_webView];
    _indicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    _indicatorView.hidesWhenStopped = YES;
    [self.view addSubview:_indicatorView];
    self.title = nil;
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    _webView.frame = self.view.bounds;
    _indicatorView.center = _webView.center;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear: animated];
    if (_urlString != nil) {
        NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:_urlString]];
        [_webView loadRequest:request];
        [_indicatorView startAnimating];
    }
}

#pragma mark - UIWebViewDelegate

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    return YES;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    _urlString = nil;
    [_indicatorView stopAnimating];
    if (self.title == nil) {
        self.title = [_webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    }
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    [_indicatorView stopAnimating];
}

@end
