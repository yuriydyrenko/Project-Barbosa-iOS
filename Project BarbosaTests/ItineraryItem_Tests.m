//
//  ItineraryItem_Tests.m
//  Project Barbosa
//
//  Created by Yuriy Dyrenko on 2014-03-13.
//  Copyright (c) 2014 Project Barbosa. All rights reserved.
//

#import "Kiwi.h"
#import "ItineraryItem.h"
#import "ItineraryItemLocation.h"

SPEC_BEGIN(ItineraryItemSpec)

describe(@"ItineraryItem", ^{
    it(@"should save properties correctly", ^{
        ItineraryItem *item = [[ItineraryItem alloc] initWithID:@"1" title:@"Test Itinerary Item"];
        
        [[item._id should] equal:@"1"];
        [[item.title should] equal:@"Test Itinerary Item"];
    });
    
    it(@"should init from JSON correctly", ^{
        ItineraryItem *item = nil;
        NSDictionary *itemDictionary = nil;
        NSString *itemJSONString = @"{\"_id\": \"53310206ebb90700006cc89c\", \"title\": \"Depart Winnipeg\", \"location\": { \"longitude\": -97.24, \"latitude\": 49.91, \"name\": \"Winnipeg James Armstrong Richardson International Airport\"}}";
        NSData *itemData = [itemJSONString dataUsingEncoding:NSUTF8StringEncoding];
        NSError *error = nil;
        
        [[itemData shouldNot] beNil];
        itemDictionary = [NSJSONSerialization JSONObjectWithData:itemData options:0 error:&error];
        [[error should] beNil];
        
        item = [[ItineraryItem alloc] initWithDictionary:itemDictionary error:&error];
        [[item shouldNot] beNil];
        [[error should] beNil];
        
        [[item._id should] equal:@"53310206ebb90700006cc89c"];
        [[item.title should] equal:@"Depart Winnipeg"];
        [[item.location shouldNot] beNil];
    });
    
    it(@"should encode and decode with NSCoder", ^{
        ItineraryItemLocation *itemLocation = [[ItineraryItemLocation alloc] initWithName:@"Test Location" latitude:2.2 longitude:1.1];
        ItineraryItem *item = [[ItineraryItem alloc] initWithID:@"1" title:@"Test title"];
        item.details = @"Test details";
        item.location = itemLocation;
        
        [[itemLocation shouldNot] beNil];
        [[item shouldNot] beNil];
        
        NSData *itemData = [NSKeyedArchiver archivedDataWithRootObject:item];
        [[itemData shouldNot] beNil];
        
        ItineraryItem *decodedItem = [NSKeyedUnarchiver unarchiveObjectWithData:itemData];
        [[decodedItem shouldNot] beNil];
        [[decodedItem._id should] equal:@"1"];
        [[decodedItem.title should] equal:@"Test title"];
        [[decodedItem.details should] equal:@"Test details"];
        [[decodedItem.location shouldNot] beNil];
        [[decodedItem.location.name should] equal:@"Test Location"];
        [[theValue(decodedItem.location.latitude) should] equal:2.2 withDelta:0.001];
        [[theValue(decodedItem.location.longitude) should] equal:1.1 withDelta:0.001];
    });
});

SPEC_END
