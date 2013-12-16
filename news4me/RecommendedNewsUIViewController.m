//
//  RecommendedNewsUIViewController.m
//  news4me
//
//  Created by Taeho Kim on 12/14/13.
//  Copyright (c) 2013 Recomio, Inc. All rights reserved.
//

#import "RecommendedNewsUIViewController.h"

@interface RecommendedNewsUIViewController ()
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@end

@implementation RecommendedNewsUIViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.webViewUrl = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"recommendedNews" ofType:@"html"]isDirectory:NO];
    [self.webView loadRequest:[NSURLRequest requestWithURL:self.webViewUrl]];
}

@end
