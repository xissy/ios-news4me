//
//  RecommendedNewsUIViewController.m
//  news4me
//
//  Created by Taeho Kim on 12/14/13.
//  Copyright (c) 2013 Recomio, Inc. All rights reserved.
//

#import <FacebookSDK/FacebookSDK.h>
#import "RecommendedNewsUIViewController.h"
#import "WebViewJavascriptBridge.h"
#import "UserPreferences.h"

@interface RecommendedNewsUIViewController ()
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (assign, atomic) BOOL isLoading;

@end

@implementation RecommendedNewsUIViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    self.isLoading = YES;
    self.webViewUrl = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"recommendedNews" ofType:@"html"]isDirectory:NO];
    [self.webView loadRequest:[NSURLRequest requestWithURL:self.webViewUrl]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
}

- (void)handleWebViewJavascriptBridge:(id)data callback:(WVJBResponseCallback)responseCallback
{
    if ([data isKindOfClass:[NSString class]]) {
        NSString* message = (NSString*)data;
        
        if ([message isEqualToString:@"getApiUrl"]) {
            UserPreferences* userPreferences = [UserPreferences getInstance];
            NSString* userId = userPreferences.facebookUserId;
            NSString* accessToken = userPreferences.facebookAccessToken;
            
            NSString* url = [NSString stringWithFormat:@"http://news.recom.io/api/v1/news/facebook/%@?accessToken=%@", userId, accessToken];
            responseCallback(url);
            
        } else if ([message isEqualToString:@"onArticelsLoaded"]) {
            self.isLoading = NO;
            [self.activityIndicator stopAnimating];
        }
    }
}

- (void)handleReachingBottom
{
    if (self.isLoading) {
        return;
    }
    
    self.isLoading = YES;
    [self.activityIndicator startAnimating];
    [self.bridge send:@"loadMore"];
}

@end
