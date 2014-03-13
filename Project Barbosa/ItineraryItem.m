//
//  ItineraryItem.m
//  Project Barbosa
//
//  Created by Yuriy Dyrenko on 2014-03-12.
//  Copyright (c) 2014 Project Barbosa. All rights reserved.
//

#import "ItineraryItem.h"

@implementation ItineraryItem

- (id)initWithID:(NSString *)_id title:(NSString *)title
{
    self = [super init];
    
    if(self)
    {
        self._id = _id;
        self.title = title;
    }
    
    return self;
}

+ (JSONKeyMapper*)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{
        @"_id": @"_id",
        @"title": @"title",
        @"description": @"details",
        @"location": @"location"
    }];
}


@end
