//
//  WebUIViewController.h
//  BabyShopR
//
//  Created by Taeho Kim on 12/13/13.
//  Copyright (c) 2013 Recomio, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WebViewJavascriptBridge.h"

@interface WebUIViewController : UIViewController <UIWebViewDelegate, UIScrollViewDelegate>

@property (retain, nonatomic) NSURL* webViewUrl;
@property (retain, nonatomic) IBOutlet UIWebView *webView;
@property (retain, nonatomic) WebViewJavascriptBridge* bridge;
@property (retain, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
    
@end
