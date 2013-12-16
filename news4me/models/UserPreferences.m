//
//  UserPreferences.m
//  news4me
//
//  Created by Taeho Kim on 12/15/13.
//  Copyright (c) 2013 Recomio, Inc. All rights reserved.
//

#import "UserPreferences.h"

@implementation UserPreferences

static UserPreferences *instance = nil;

+ (UserPreferences *)getInstance
{
    @synchronized(self) {
        if (instance == nil) {
            instance = [UserPreferences new];
        }    
    }
    
    return instance;
}

@end
