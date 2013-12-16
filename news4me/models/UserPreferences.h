//
//  UserPreferences.h
//  news4me
//
//  Created by Taeho Kim on 12/15/13.
//  Copyright (c) 2013 Recomio, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserPreferences : NSObject

@property (retain, nonatomic) NSString* facebookUserId;
@property (retain, nonatomic) NSString* facebookUserName;
@property (retain, nonatomic) NSString* facebookAccessToken;

+ (UserPreferences *)getInstance;

@end
