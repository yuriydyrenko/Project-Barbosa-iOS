//
//  ItineraryItem.h
//  Project Barbosa
//
//  Created by Yuriy Dyrenko on 2014-03-12.
//  Copyright (c) 2014 Project Barbosa. All rights reserved.
//

#import "JSONModel.h"

@protocol ItineraryItem
@end

@interface ItineraryItem : JSONModel

@property (nonatomic, copy) NSString<Optional> *_id;
@property (nonatomic, copy) NSString<Optional> *title;
@property (nonatomic, copy) NSString<Optional> *details;
@property (nonatomic, copy) NSString<Optional> *latitude;
@property (nonatomic, copy) NSString<Optional> *longitude;
@property (nonatomic, copy) NSString<Optional> *locationName;

- (id)initWithID:(NSString *)_id title:(NSString *)title;
+ (JSONKeyMapper*)keyMapper;

@end
