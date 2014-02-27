//
//  Trip.h
//  Project Barbosa
//
//  Created by Yuriy Dyrenko on 2/19/2014.
//  Copyright (c) 2014 Project Barbosa. All rights reserved.
//

#import "JSONModel.h"

@interface Trip : JSONModel

@property (nonatomic, copy) NSString *_id;
@property (nonatomic, copy) NSString *name;

- (id)initWithID:(NSString *)_id name:(NSString *)name;

@end
