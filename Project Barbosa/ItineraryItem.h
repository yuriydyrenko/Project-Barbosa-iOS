//
//  ItineraryItem.h
//  Project Barbosa
//
//  Created by Yuriy Dyrenko on 2014-03-12.
//  Copyright (c) 2014 Project Barbosa. All rights reserved.
//

#import "JSONModel.h"

@interface ItineraryItemLocation : JSONModel

@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) CGFloat latitude;
@property (nonatomic, assign) CGFloat longitude;

@end

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
