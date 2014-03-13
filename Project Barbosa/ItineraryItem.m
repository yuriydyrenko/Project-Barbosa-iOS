//
//  ItineraryItem.m
//  Project Barbosa
//
//  Created by Yuriy Dyrenko on 2014-03-12.
//  Copyright (c) 2014 Project Barbosa. All rights reserved.
//

#import "ItineraryItem.h"

@implementation ItineraryItem

+ (JSONKeyMapper*)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{
        @"_id": @"_id",
        @"title": @"title",
        @"description": @"details"
    }];
}


@end
