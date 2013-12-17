//
//  FullArticleWebUIViewController.m
//  news4me
//
//  Created by Taeho Kim on 12/15/13.
//  Copyright (c) 2013 Recomio, Inc. All rights reserved.
//

#import "FullArticleWebUIViewController.h"
#import "NJKWebViewProgressView.h"

@interface FullArticleWebUIViewController ()
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@end

@implementation FullArticleWebUIViewController
{
    NJKWebViewProgressView *_progressView;
    NJKWebViewProgress *_progressProxy;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _progressProxy = [[NJKWebViewProgress alloc] init];
    self.webView.delegate = _progressProxy;
    _progressProxy.webViewProxyDelegate = self;
    _progressProxy.progressDelegate = self;
    
    CGFloat progressBarHeight = 2.5f;
    CGRect navigaitonBarBounds = self.navigationController.navigationBar.bounds;
    CGRect barFrame = CGRectMake(0, navigaitonBarBounds.size.height - progressBarHeight, navigaitonBarBounds.size.width, progressBarHeight);
    _progressView = [[NJKWebViewProgressView alloc] initWithFrame:barFrame];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar addSubview:_progressView];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    // Remove progress view
    // because UINavigationBar is shared with other ViewControllers
    [_progressView removeFromSuperview];
}

#pragma mark - NJKWebViewProgressDelegate
- (void)webViewProgress:(NJKWebViewProgress *)webViewProgress updateProgress:(float)progress
{
    [_progressView setProgress:progress animated:YES];
    NSString* title = [self.webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    if (![title isEqualToString:@""]) {
        self.title = title;
    }
}

- (IBAction)touchExitButton:(UIBarButtonItem *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)touchShareButton:(UIBarButtonItem *)sender {
    NSArray* dataToShare = @[self.title, self.webViewUrl];
    
    UIActivityViewController* activityViewController =
    [[UIActivityViewController alloc] initWithActivityItems:dataToShare
                                      applicationActivities:nil];
    [self presentViewController:activityViewController animated:YES completion:^{}];
}

@end
