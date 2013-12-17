//
//  StarredNewsUIViewController.m
//  news4me
//
//  Created by Taeho Kim on 12/16/13.
//  Copyright (c) 2013 Recomio, Inc. All rights reserved.
//

#import "StarredNewsUIViewController.h"

@interface StarredNewsUIViewController ()
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@end

@implementation StarredNewsUIViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.webViewUrl = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"starredNews" ofType:@"html"]isDirectory:NO];
    [self.webView loadRequest:[NSURLRequest requestWithURL:self.webViewUrl]];
}

@end
