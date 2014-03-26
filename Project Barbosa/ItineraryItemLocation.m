//
//  ItineraryItemLocation.m
//  ProjectBarbosa
//
//  Created by Yuriy Dyrenko on 2014-03-24.
//  Copyright (c) 2014 Project Barbosa. All rights reserved.
//

#import "ItineraryItemLocation.h"

static NSString *kItineraryItemLocationName = @"kItineraryItemLocationName";
static NSString *kItineraryItemLocationLatitude = @"kItineraryItemLocationLatitude";
static NSString *kItineraryItemLocationLongitude = @"kItineraryItemLocationLongitude";

@implementation ItineraryItemLocation

- (id)initWithName:(NSString *)name latitude:(CGFloat)latitude longitude:(CGFloat)longitude
{
    self = [super init];
    
    if(self)
    {
        self.name = name;
        self.latitude = latitude;
        self.longitude = longitude;
    }
    
    return self;
}

- (id)initWithCoder:(NSCoder *)coder
{
    self = [super init];
    
    if(self)
    {
        self.name = [coder decodeObjectForKey:kItineraryItemLocationName];
        self.latitude = [coder decodeFloatForKey:kItineraryItemLocationLatitude];
        self.longitude = [coder decodeFloatForKey:kItineraryItemLocationLongitude];
    }
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)coder
{
    [coder encodeObject:self.name forKey:kItineraryItemLocationName];
    [coder encodeFloat:self.latitude forKey:kItineraryItemLocationLatitude];
    [coder encodeFloat:self.longitude forKey:kItineraryItemLocationLongitude];
}

@end
