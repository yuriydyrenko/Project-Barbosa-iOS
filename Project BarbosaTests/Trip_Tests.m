//
//  Trip_Tests.m
//  Project Barbosa
//
//  Created by Yuriy Dyrenko on 2/28/2014.
//  Copyright (c) 2014 Project Barbosa. All rights reserved.
//

#import "Kiwi.h"
#import "Trip.h"

SPEC_BEGIN(TripSpec)

describe(@"Trip", ^{
    it(@"should map a trip with no itinerary items correctly", ^{
        Trip *trip = nil;
        NSDictionary *tripDictionary = nil;
        NSString *tripJSONString = @"{\"_id\": \"5323373703ebc20200ce35df\", \"__v\": 0, \"archived\": false, \"date\": \"2014-03-14T17:07:03.719Z\", \"location\": \"London\", \"user\": \"Jules Verne\", \"itinerary\": [], \"name\": \"Around the World in Eighty Days\"}";
        NSData *tripData = [tripJSONString dataUsingEncoding:NSUTF8StringEncoding];
        NSError *error = nil;
        
        [[tripData shouldNot] beNil];
        tripDictionary = [NSJSONSerialization JSONObjectWithData:tripData options:0 error:&error];
        [[error should] beNil];
        trip = [[Trip alloc] initWithDictionary:tripDictionary error:&error];
        [[trip shouldNot] beNil];
        [[error should] beNil];
        
        [[trip._id should] equal:@"5323373703ebc20200ce35df"];
        [[trip.name should] equal:@"Around the World in Eighty Days"];
        [[trip.itinerary should] beEmpty];
    });
    
    it(@"should error while mapping a trip with valid data", ^{
        Trip *trip = nil;
        NSDictionary *tripDictionary = nil;
        NSString *tripJSONString = @"{\"__v\": 0, \"archived\": false, \"date\": \"2014-03-14T17:07:03.719Z\", \"location\": \"London\", \"user\": \"Jules Verne\", \"itinerary\": []}";
        NSData *tripData = [tripJSONString dataUsingEncoding:NSUTF8StringEncoding];
        NSError *error = nil;
        
        [[tripData shouldNot] beNil];
        tripDictionary = [NSJSONSerialization JSONObjectWithData:tripData options:0 error:&error];
        [[error should] beNil];
        trip = [[Trip alloc] initWithDictionary:tripDictionary error:&error];
        [[trip should] beNil];
        [[error shouldNot] beNil];
    });
});

SPEC_END
