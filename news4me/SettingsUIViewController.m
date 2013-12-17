//
//  SettingsUIViewController.m
//  news4me
//
//  Created by Taeho Kim on 12/17/13.
//  Copyright (c) 2013 Recomio, Inc. All rights reserved.
//

#import <FacebookSDK/FacebookSDK.h>
#import "SettingsUIViewController.h"
#import "UserPreferences.h"

@interface SettingsUIViewController ()
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@end

@implementation SettingsUIViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.webViewUrl = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"settings" ofType:@"html"]isDirectory:NO];
    [self.webView loadRequest:[NSURLRequest requestWithURL:self.webViewUrl]];
}

- (void)handleWebViewJavascriptBridge:(id)data callback:(WVJBResponseCallback)responseCallback
{
    if ([data isKindOfClass:[NSString class]]) {
        NSString *message = (NSString *)data;
        
        if ([message isEqualToString:@"init"]) {
            UserPreferences *userPreferences = [UserPreferences getInstance];
            NSString *userId = userPreferences.facebookUserId;
            NSString *userName = userPreferences.facebookUserName;
            
            NSArray *keys = [NSArray arrayWithObjects:@"userId", @"userName", nil];
            NSArray *objects = [NSArray arrayWithObjects:userId, userName, nil];
            NSDictionary *dictionary = [NSDictionary dictionaryWithObjects:objects forKeys:keys];
            
            responseCallback(dictionary);
            
        } else if ([message isEqualToString:@"logout"]) {
            [FBSession.activeSession closeAndClearTokenInformation];
            
            [self dismissViewControllerAnimated:YES completion:nil];
        }
    }
}

@end
