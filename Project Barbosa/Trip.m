//
//  Trip.m
//  Project Barbosa
//
//  Created by Yuriy Dyrenko on 2/19/2014.
//  Copyright (c) 2014 Project Barbosa. All rights reserved.
//

#import "Trip.h"

static NSString *kTripID = @"kTripID";
static NSString *kTripName = @"kTripName";
static NSString *kTripItinerary = @"kTripItinerary";

@implementation Trip

- (id)initWithID:(NSString *)_id name:(NSString *)name
{
    self = [super init];
    
    if(self)
    {
        self._id = _id;
        self.name = name;
    }
    
    return self;
}

- (id)initWithCoder:(NSCoder *)coder
{
    self = [super init];
    
    if(self)
    {
        self._id = [coder decodeObjectForKey:kTripID];
        self.name = [coder decodeObjectForKey:kTripName];
        self.itinerary = [coder decodeObjectForKey:kTripItinerary];
    }
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)coder
{
    [coder encodeObject:self._id forKey:kTripID];
    [coder encodeObject:self.name forKey:kTripName];
    [coder encodeObject:self.itinerary forKey:kTripItinerary];
}

- (UIImage*)getMapImage
{
    NSString* path = @"http://maps.googleapis.com/maps/api/staticmap?center=UofM+Winnipeg&zoom=13&size=200x168&maptype=roadmap&markers=color:red%7Clabel:C%7CUofM+Winnipeg&sensor=false";
    NSURL *imageURL = [NSURL URLWithString:path];
    NSData *imageData = [NSData dataWithContentsOfURL:imageURL];
    UIImage *image = [UIImage imageWithData:imageData];
    return image;
}

@end
