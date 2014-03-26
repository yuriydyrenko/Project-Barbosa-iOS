//
//  ItineraryItemLocation_Tests.m
//  ProjectBarbosa
//
//  Created by Yuriy Dyrenko on 2014-03-25.
//  Copyright (c) 2014 Project Barbosa. All rights reserved.
//

#import "Kiwi.h"
#import "ItineraryItemLocation.h"

SPEC_BEGIN(ItineraryItemLocationSpec)

describe(@"ItineraryItemLocation", ^{
    it(@"should save properties correctly", ^{
        ItineraryItemLocation *location = [[ItineraryItemLocation alloc] initWithName:@"Test" latitude:2.2 longitude:1.1];
        
        [[location shouldNot] beNil];
        [[location.name should] equal:@"Test"];
        [[theValue(location.latitude) should] equal:2.2 withDelta:0.001];
        [[theValue(location.longitude) should] equal:1.1 withDelta:0.001];
    });
});

SPEC_END
