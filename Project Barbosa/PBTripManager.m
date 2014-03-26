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

static NSString *kSavedTrips = @"PBSavedTrips";

@implementation PBTripManager

+ (void)getAllTripsWithSuccess:(void (^)(NSArray *trips, NSInteger count, NSArray *errors))success failure:(void (^)(NSError *error))failure
{
    [self getTripsFromPath:@"trips" parameters:nil success:success failure:failure];
}

+ (void)getAllTripsForUserID:(NSString *)userID success:(void (^)(NSArray *trips, NSInteger count, NSArray *errors))success failure:(void (^)(NSError *error))failure
{
    [self getTripsFromPath:@"trips" parameters:@{@"userID": userID} success:success failure:failure];
}

+ (void)getTripsFromPath:(NSString *)path parameters:(NSDictionary *)parameters success:(void (^)(NSArray *trips, NSInteger count, NSArray *errors))success failure:(void (^)(NSError *error))failure;
{
    [PBHTTPSessionManager startedRequest];
    PBHTTPSessionManager *manager = [PBHTTPSessionManager manager];
    [manager GET:path parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject)
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
            
            success([trips copy], count, errors);
        }
        else
        {
            if(failure)
            {
                error = [NSError errorWithDomain:@"PBGetTripsErrorDomain" code:PBTripManagerInvalidJSONReturnedError userInfo:nil];
                failure(error);
            }
        }
        
        [PBHTTPSessionManager finishedRequest];
    }
    failure:^(NSURLSessionDataTask *task, NSError *error)
    {
        if(failure)
        {
            failure(error);
        }
        
        [PBHTTPSessionManager finishedRequest];
    }];
}

+ (void)storeSavedTrips:(NSArray *)trips
{
    if([trips isKindOfClass:[NSArray class]] || [trips isKindOfClass:[NSMutableArray class]])
    {
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:trips];
        [[NSUserDefaults standardUserDefaults] setObject:data forKey:kSavedTrips];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

+ (NSArray *)loadSavedTrips
{
    NSData *data = (NSData *)[[NSUserDefaults standardUserDefaults] objectForKey:kSavedTrips];
    NSArray *trips = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    return trips;
}

+ (void)removeSavedTrips
{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:kSavedTrips];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

@end
