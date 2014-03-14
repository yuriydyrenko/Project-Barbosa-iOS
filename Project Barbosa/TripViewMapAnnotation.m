//
//  TripViewMapAnnotation.m
//  Project Barbosa
//
//  Created by Yuriy Dyrenko on 2014-03-13.
//  Copyright (c) 2014 Project Barbosa. All rights reserved.
//

#import "TripViewMapAnnotation.h"

@implementation TripViewMapAnnotation

- (id)initWithTitle:(NSString *)title coordinate:(CLLocationCoordinate2D)coordinate
{
    self = [super init];
    
    if(self)
    {
        self.title = title;
        self.coordinate = coordinate;
    }
    
    return self;
}

@end
