//
//  ItineraryItem_Tests.m
//  Project Barbosa
//
//  Created by Yuriy Dyrenko on 2014-03-13.
//  Copyright (c) 2014 Project Barbosa. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ItineraryItem.h"

@interface ItineraryItem_Tests : XCTestCase

@end

@implementation ItineraryItem_Tests

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

- (void)testIDAndTitle
{
    ItineraryItem *item = [[ItineraryItem alloc] initWithID:@"1" title:@"Test Itinerary Item"];
    
    XCTAssertEqual(item._id, @"1", @"Itinerary Trip Item ID not equal");
    XCTAssertEqual(item.title, @"Test Itinerary Item", @"Itinerary Item Trip name not equal.");
}

@end
