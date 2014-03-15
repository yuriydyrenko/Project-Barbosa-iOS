//
//  User_Tests.m
//  Project Barbosa
//
//  Created by Yuriy Dyrenko on 2014-03-13.
//  Copyright (c) 2014 Project Barbosa. All rights reserved.
//

#import "Kiwi.h"
#import "User.h"

SPEC_BEGIN(UserSpec)

describe(@"User", ^{
    it(@"should be return if logged in correctly", ^{
        [[theValue([User loggedIn]) should] equal:theValue(NO)];
        [User setID:@"123456789"];
        [[theValue([User loggedIn]) should] equal:theValue(YES)];
        [User logout];
        [[theValue([User loggedIn]) should] equal:theValue(NO)];
    });
});

SPEC_END
