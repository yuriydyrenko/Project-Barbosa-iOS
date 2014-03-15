//
//  PBTripManager_Tests.m
//  ProjectBarbosa
//
//  Created by Yuriy Dyrenko on 2014-03-15.
//  Copyright (c) 2014 Project Barbosa. All rights reserved.
//

#import "Kiwi.h"
#import "PBTripManager.h"

SPEC_BEGIN(PBTripManagerSpec)

describe(@"PBTripManager", ^{
    registerMatchers(@"PB");
    
    it(@"should get an array of all trips from the server within four seconds", ^{
        __block NSArray *allTrips = nil;
        
        [PBTripManager getAllTripsWithSuccess:^(NSArray *trips, NSInteger count, NSArray *errors) {
            [[theValue(trips.count) should] equal:theValue(count)];
            [[errors should] beEmpty];
            allTrips = trips;
        } failure:nil];
        
        [[expectFutureValue(allTrips) shouldEventuallyBeforeTimingOutAfter(4.0)] beNonNil];
    });
});

SPEC_END
