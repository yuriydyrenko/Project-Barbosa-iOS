//
//  Trip.h
//  Project Barbosa
//
//  Created by Yuriy Dyrenko on 2/19/2014.
//  Copyright (c) 2014 Project Barbosa. All rights reserved.
//

#import "JSONModel.h"

@interface Trip : JSONModel

@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSArray *itinerary;

- (id)initWithID:(NSString *)id name:(NSString *)name;

@end
