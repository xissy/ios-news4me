//
//  ReadNewsUIViewController.m
//  news4me
//
//  Created by Taeho Kim on 12/14/13.
//  Copyright (c) 2013 Recomio, Inc. All rights reserved.
//

#import "ReadNewsUIViewController.h"

@interface ReadNewsUIViewController ()
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@end

@implementation ReadNewsUIViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.webViewUrl = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"readNews" ofType:@"html"]isDirectory:NO];
    [self.webView loadRequest:[NSURLRequest requestWithURL:self.webViewUrl]];
}

@end
