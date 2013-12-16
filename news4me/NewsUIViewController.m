//
//  NewUIViewController.m
//  news4me
//
//  Created by Taeho Kim on 12/16/13.
//  Copyright (c) 2013 Recomio, Inc. All rights reserved.
//

#import <FacebookSDK/FacebookSDK.h>
#import "RecommendedNewsUIViewController.h"
#import "NewsUIViewController.h"
#import "UserPreferences.h"
#import "FullArticleWebUIViewController.h"

@implementation NewsUIViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    self.tappedArticleUrl = nil;
    self.isLoading = YES;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSLog(@"prepareForSegue");
    
    if ([segue.identifier isEqualToString:@"SegueToFullArticleWebUIViewController"]) {
        NSLog(@"SegueToFullArticleWebUIViewController");
        UINavigationController *navController = (UINavigationController *)segue.destinationViewController;
        FullArticleWebUIViewController *fullArticleWebUIViewController = (FullArticleWebUIViewController *)navController.topViewController;
        fullArticleWebUIViewController.webViewUrl = [NSURL URLWithString:self.tappedArticleUrl];
    }
}

- (void)handleWebViewJavascriptBridge:(id)data callback:(WVJBResponseCallback)responseCallback
{
    if ([data isKindOfClass:[NSString class]]) {
        NSString *message = (NSString *)data;
        
        if ([message isEqualToString:@"init"]) {
            UserPreferences *userPreferences = [UserPreferences getInstance];
            NSString *userId = userPreferences.facebookUserId;
            NSString *accessToken = userPreferences.facebookAccessToken;
            
            NSArray *keys = [NSArray arrayWithObjects:@"userId", @"accessToken", nil];
            NSArray *objects = [NSArray arrayWithObjects:userId, accessToken, nil];
            NSDictionary *dictionary = [NSDictionary dictionaryWithObjects:objects forKeys:keys];
            
            responseCallback(dictionary);
            
        } else if ([message isEqualToString:@"onArticlesLoaded"]) {
            self.isLoading = NO;
            [self.activityIndicator stopAnimating];
            
        } else if ([message isEqualToString:@"onTap"]) {
            [self performSegueWithIdentifier:@"SegueToFullArticleWebUIViewController" sender:self];
        }
    } else {
        NSString *message = data[@"message"];
        
        if ([message isEqualToString:@"onTapArticle"]) {
            NSString *articleId = data[@"articleId"];
            
            UserPreferences* userPreferences = [UserPreferences getInstance];
            
            self.tappedArticleUrl = [NSString stringWithFormat:@"http://news.recom.io/api/v1/articles/%@/redirect/from/facebook/%@", articleId, userPreferences.facebookUserId];
            [self performSegueWithIdentifier:@"SegueToFullArticleWebUIViewController" sender:self];
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
