//
//  ItineraryItemLocation.h
//  ProjectBarbosa
//
//  Created by Yuriy Dyrenko on 2014-03-24.
//  Copyright (c) 2014 Project Barbosa. All rights reserved.
//

#import "JSONModel.h"

@protocol ItineraryItemLocation
@end

@interface ItineraryItemLocation : JSONModel

@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) CGFloat latitude;
@property (nonatomic, assign) CGFloat longitude;

@end