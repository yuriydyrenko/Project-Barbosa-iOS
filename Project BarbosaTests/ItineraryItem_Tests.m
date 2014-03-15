//
//  ItineraryItem_Tests.m
//  Project Barbosa
//
//  Created by Yuriy Dyrenko on 2014-03-13.
//  Copyright (c) 2014 Project Barbosa. All rights reserved.
//

#import "Kiwi.h"
#import "ItineraryItem.h"

SPEC_BEGIN(ItineraryItemSpec)

describe(@"ItineraryItem", ^{
    it(@"should save properties correctly", ^{
        ItineraryItem *item = [[ItineraryItem alloc] initWithID:@"1" title:@"Test Itinerary Item"];
        
        [[item._id should] equal:@"1"];
        [[item.title should] equal:@"Test Itinerary Item"];
    });
});

SPEC_END
