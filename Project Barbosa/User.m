//
//  User.m
//  Project Barbosa
//
//  Created by Yuriy Dyrenko on 2014-03-10.
//  Copyright (c) 2014 Project Barbosa. All rights reserved.
//

#import "User.h"

@implementation User

static NSString *_id = nil;

+ (void)checkIfLoggedIn
{
    _id = [[NSUserDefaults standardUserDefaults] objectForKey:@"userID"];
}

+ (BOOL)loggedIn
{
    BOOL loggedIn = NO;
    
    if(_id != nil)
    {
        loggedIn = YES;
    }
    
    return loggedIn;
}

+ (NSString *)_id
{
    return _id;
}

+ (void)setID:(NSString *)id
{
    [[NSUserDefaults standardUserDefaults] setObject:id forKey:@"userID"];
    _id = id;
}

+ (void)logout
{
    _id = nil;
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"userID"];
    [[NSUserDefaults standardUserDefaults] removePersistentDomainForName:[[NSBundle mainBundle] bundleIdentifier]];
}

@end
