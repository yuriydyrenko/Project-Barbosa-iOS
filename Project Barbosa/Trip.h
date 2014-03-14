//
//  Trip.h
//  Project Barbosa
//
//  Created by Yuriy Dyrenko on 2/19/2014.
//  Copyright (c) 2014 Project Barbosa. All rights reserved.
//

#import "JSONModel.h"
#import "ItineraryItem.h"

@interface Trip : JSONModel

@property (nonatomic, strong) NSString *_id;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSArray<ItineraryItem, Optional> *itinerary;

- (id)initWithID:(NSString *)_id name:(NSString *)name;
- (UIImage*)getMapImage;

@end
