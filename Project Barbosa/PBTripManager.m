//
//  PBTripManager.m
//  ProjectBarbosa
//
//  Created by Yuriy Dyrenko on 2014-03-15.
//  Copyright (c) 2014 Project Barbosa. All rights reserved.
//

#import "PBTripManager.h"
#import "PB.h"
#import "Trip.h"

@implementation PBTripManager

+ (void)getAllTripsWithSuccess:(void (^)(NSArray *trips, NSInteger count, NSArray *errors))success failure:(void (^)(NSError *error))failure
{
    [self getTripsFromPath:@"trips" success:success failure:failure];
}

+ (void)getAllTripsForUserID:(NSString *)userID success:(void (^)(NSArray *trips, NSInteger count, NSArray *errors))success failure:(void (^)(NSError *error))failure
{
    NSString *path = [NSString stringWithFormat:@"trips?userID=%@", userID];
    [self getTripsFromPath:path success:success failure:failure];
}

+ (void)getTripsFromPath:(NSString *)path success:(void (^)(NSArray *trips, NSInteger count, NSArray *errors))success failure:(void (^)(NSError *error))failure;
{
    [PBHTTPSessionManager startedRequest];
    PBHTTPSessionManager *manager = [PBHTTPSessionManager manager];
    [manager GET:@"trips" parameters:nil success:^(NSURLSessionDataTask *task, id responseObject)
    {
        NSError *error = nil;
        
        if(responseObject != nil)
        {
            Trip *trip = nil;
            NSError *error = nil;
            NSInteger count = [responseObject[@"trips"] count];
            NSMutableArray *trips = [[NSMutableArray alloc] initWithCapacity:count];
            NSMutableArray *errors = [[NSMutableArray alloc] init];
            
            for(id tripDictionary in responseObject[@"trips"])
            {
                trip = [[Trip alloc] initWithDictionary:tripDictionary error:&error];
                
                if(!error)
                {
                    [trips addObject:trip];
                }
                else
                {
                    [errors addObject:error];
                }
            }
            
            success(trips, count, errors);
        }
        else
        {
            if(failure)
            {
                error = [NSError errorWithDomain:@"PBGetTripsErrorDomain" code:PBTripManagerInvalidJSONReturnedError userInfo:nil];
                failure(error);
            }
        }
    }
    failure:^(NSURLSessionDataTask *task, NSError *error)
    {
        if(failure)
        {
            failure(error);
        }
    }];
}

@end
