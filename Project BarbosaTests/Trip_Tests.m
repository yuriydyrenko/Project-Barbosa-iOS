//
//  Trip_Tests.m
//  Project Barbosa
//
//  Created by Yuriy Dyrenko on 2/28/2014.
//  Copyright (c) 2014 Project Barbosa. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "Trip.h"
#import "JSONModel.h"

@interface Trip_Tests : XCTestCase

@end

@implementation Trip_Tests

- (void)setUp
{
    [super setUp];
    // Put setup code here; it will be run once, before the first test case.
}

- (void)tearDown
{
    // Put teardown code here; it will be run once, after the last test case.
    [super tearDown];
}

- (void)testIDAndName
{
    Trip *trip = [[Trip alloc] initWithID:@"1" name:@"Test Trip"];
    
    XCTAssertEqual(trip._id, @"1", @"Trip ID not equal");
    XCTAssertEqual(trip.name, @"Test Trip", @"Trip name not equal.");
    
    XCTAssertNotEqual(trip._id, @"2", @"Trip ID error.");
    XCTAssertNotEqual(trip.name, @"Test Trip 2", @"Trip name not equal.");
}

- (void)testJSONModelDictionaryKeyMapping
{
    NSError *error;
    NSDictionary *tripDictionary = @{@"_id" : @"2", @"name" : @"Test Trip 2"};
    Trip *trip = [[Trip alloc] initWithDictionary:tripDictionary error:&error];
    
    XCTAssertEqual(trip._id, @"2", @"Trip ID not equal");
    XCTAssertEqual(trip.name, @"Test Trip 2", @"Trip name not equal.");
    
    XCTAssertNotEqual(trip._id, @"1", @"Trip ID error.");
    XCTAssertNotEqual(trip.name, @"Test Trip", @"Trip name error.");
}

@end
