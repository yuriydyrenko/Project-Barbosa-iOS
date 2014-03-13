//
//  User_Tests.m
//  Project Barbosa
//
//  Created by Yuriy Dyrenko on 2014-03-13.
//  Copyright (c) 2014 Project Barbosa. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "User.h"

@interface User_Tests : XCTestCase

@end

@implementation User_Tests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testCheckIfLoggedIn
{
    XCTAssertEqual([User loggedIn], false, @"User should not be logged in.");
    
    [User setID:@"123456789"];
    XCTAssertEqual([User loggedIn], true, @"User should be logged in.");
    
    [User logout];
    XCTAssertEqual([User loggedIn], false, @"User should not be logged in.");
}

@end
