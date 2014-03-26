//
//  PBTripManager.h
//  ProjectBarbosa
//
//  Created by Yuriy Dyrenko on 2014-03-15.
//  Copyright (c) 2014 Project Barbosa. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger
{
    PBTripManagerInvalidJSONReturnedError,
    PBTripManagerJSONParseError
} PBTripManagerError;

@interface PBTripManager : NSObject

+ (void)getAllTripsWithSuccess:(void (^)(NSArray *trips, NSInteger count, NSArray *errors))success failure:(void (^)(NSError *error))failure;
+ (void)getAllTripsForUserID:(NSString *)userID success:(void (^)(NSArray *trips, NSInteger count, NSArray *errors))success failure:(void (^)(NSError *error))failure;

+ (void)storeSavedTrips:(NSArray *)trips;
+ (NSArray *)loadSavedTrips;
+ (void)removeSavedTrips;

@end
