//
//  Trip.m
//  Project Barbosa
//
//  Created by Yuriy Dyrenko on 2/19/2014.
//  Copyright (c) 2014 Project Barbosa. All rights reserved.
//

#import "Trip.h"

@implementation Trip

- (id)initWithID:(NSString *)id name:(NSString *)name
{
    self = [super init];
    
    if(self)
    {
        self.id = id;
        self.name = name;
    }
    
    return self;
}

@end
