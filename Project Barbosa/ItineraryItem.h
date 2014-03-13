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

@property (nonatomic, copy) NSString *_id;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString<Optional> *details;

+ (JSONKeyMapper*)keyMapper;

@end
