//
//  WebUIViewController.m
//  BabyShopR
//
//  Created by Taeho Kim on 12/13/13.
//  Copyright (c) 2013 Recomio, Inc. All rights reserved.
//

#import "WebUIViewController.h"

@interface WebUIViewController () <UIWebViewDelegate>

@end

@implementation WebUIViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if (!self.activityIndicator) {
        //start an animator symbol for the webpage loading to follow
        UIActivityIndicatorView *progressWheel = [[UIActivityIndicatorView alloc]
                                                  initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        
        //makes activity indicator disappear when it is stopped
        progressWheel.hidesWhenStopped = YES;
        
        //used to locate position of activity indicator
        progressWheel.center = CGPointMake(160, 160);
        
        self.activityIndicator = progressWheel;
        [self.view addSubview: self.activityIndicator];
    }
    
	[self.activityIndicator startAnimating];
    
    // set webView default options.
    [self.webView setDelegate:self];
    [self.webView.scrollView setDelegate:self];
    [self.webView.scrollView setDelaysContentTouches:NO];
    [self.webView.scrollView setDecelerationRate:UIScrollViewDecelerationRateNormal];
    
    // init bridge and set handler.
    self.bridge = [WebViewJavascriptBridge bridgeForWebView:self.webView webViewDelegate:self handler:^(id data, WVJBResponseCallback responseCallback) {
        [self handleWebViewJavascriptBridge:data callback:responseCallback];
    }];
    
    if (self.webViewUrl) {
        [self.webView loadRequest:[NSURLRequest requestWithURL:self.webViewUrl]];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)handleWebViewJavascriptBridge:(id)data callback:(WVJBResponseCallback)responseCallback
{
    NSLog(@"handleWebViewJavascriptBridge");
}

- (void)handleReachingBottom {
    NSLog(@"handleReachingBottom");
}

#pragma mark - UIWebViewDelegate
- (void)webViewDidStartLoad:(UIWebView *)webView
{
    NSLog(@"webViewDidStartLoad");
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    NSLog(@"webViewDidFinishLoad");
	[self.activityIndicator stopAnimating];
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView.contentOffset.y > scrollView.contentSize.height - scrollView.frame.size.height) {
        [self handleReachingBottom];
    }
}

@end
