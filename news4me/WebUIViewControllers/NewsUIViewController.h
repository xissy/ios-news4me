//
//  NewUIViewController.h
//  news4me
//
//  Created by Taeho Kim on 12/16/13.
//  Copyright (c) 2013 Recomio, Inc. All rights reserved.
//

#import "WebWithRefreshUIViewController.h"

@interface NewsUIViewController : WebWithRefreshUIViewController
@property (assign, atomic) BOOL isLoading;
@property (assign, nonatomic) NSString *tappedArticleUrl;

@end
