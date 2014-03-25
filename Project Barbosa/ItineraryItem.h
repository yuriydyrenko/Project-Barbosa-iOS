//
//  ItineraryItem.h
//  Project Barbosa
//
//  Created by Yuriy Dyrenko on 2014-03-12.
//  Copyright (c) 2014 Project Barbosa. All rights reserved.
//

#import "JSONModel.h"
#import "ItineraryItemLocation.h"

@protocol ItineraryItem
@end

@interface ItineraryItem : JSONModel

@property (nonatomic, copy) NSString<Optional> *_id;
@property (nonatomic, copy) NSString<Optional> *title;
@property (nonatomic, copy) NSString<Optional> *details;
@property (nonatomic, strong) ItineraryItemLocation<Optional> *location;

- (id)initWithID:(NSString *)_id title:(NSString *)title;
+ (JSONKeyMapper*)keyMapper;

@end
