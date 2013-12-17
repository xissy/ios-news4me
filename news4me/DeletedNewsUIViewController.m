//
//  DeletedNewsUIViewController.m
//  news4me
//
//  Created by Taeho Kim on 12/16/13.
//  Copyright (c) 2013 Recomio, Inc. All rights reserved.
//

#import "DeletedNewsUIViewController.h"

@interface DeletedNewsUIViewController ()
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@end

@implementation DeletedNewsUIViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.webViewUrl = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"deletedNews" ofType:@"html"]isDirectory:NO];
    [self.webView loadRequest:[NSURLRequest requestWithURL:self.webViewUrl]];
}

@end
