//
//  ItineraryItem.m
//  Project Barbosa
//
//  Created by Yuriy Dyrenko on 2014-03-12.
//  Copyright (c) 2014 Project Barbosa. All rights reserved.
//

#import "ItineraryItem.h"

static NSString *kItineraryItemID = @"ItineraryItemID";
static NSString *kItineraryItemTitle = @"ItineraryItemTitle";
static NSString *kItineraryItemDetails = @"ItineraryItemDetails";


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

- (void)encodeWithCoder:(NSCoder *)coder
{
    [coder encodeObject:self._id forKey:kItineraryItemID];
    [coder encodeObject:self.title forKey:kItineraryItemTitle];
    [coder encodeObject:self.details forKey:kItineraryItemDetails];
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
