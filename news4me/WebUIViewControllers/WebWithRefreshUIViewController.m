//
//  WebWithRefreshUIViewController.m
//  BabyShopR
//
//  Created by Taeho Kim on 12/13/13.
//  Copyright (c) 2013 Recomio, Inc. All rights reserved.
//

#import "WebWithRefreshUIViewController.h"

@interface WebWithRefreshUIViewController ()

@end

@implementation WebWithRefreshUIViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self action:@selector(handleRefresh:) forControlEvents:UIControlEventValueChanged];
    [self.webView.scrollView addSubview:refreshControl];
}

- (void)handleRefresh:(UIRefreshControl *)refresh {
    [refresh endRefreshing];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
