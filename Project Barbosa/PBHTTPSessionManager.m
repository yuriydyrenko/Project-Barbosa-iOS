//
//  PBHTTPManager.m
//  Project Barbosa
//
//  Created by Yuriy Dyrenko on 2/27/2014.
//  Copyright (c) 2014 Project Barbosa. All rights reserved.
//

#import "PBHTTPSessionManager.h"

@implementation PBHTTPSessionManager

static NSUInteger _requests;

+ (instancetype)manager
{
    PBHTTPSessionManager *manager;
    NSURL *baseURL;
    
    if(DEBUG)
    {
        //baseURL = [NSURL URLWithString:@"http://localhost:3000/"];
        baseURL = [NSURL URLWithString:@"http://project-barbosa.herokuapp.com/"];
    }
    else
    {
        baseURL = [NSURL URLWithString:@"http://project-barbosa.herokuapp.com/"];
    }
    
    //AFJSONRequestSerializer *requestSerializer = [AFJSONRequestSerializer serializer];
    //AFHTTPResponseSerializer *responseSerializer = [AFHTTPResponseSerializer serializer];
    manager = [[[self class] alloc] initWithBaseURL:baseURL];
    //manager.requestSerializer = requestSerializer;
    //manager.responseSerializer = responseSerializer;
    
    return manager;
}

#pragma mark - Class Methods
+ (void)startedRequest
{
    _requests++;
    
    if(_requests == 1)
    {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    }
}

+ (void)finishedRequest
{
    if(_requests != 0)
    {
        _requests--;
        
        if(_requests == 0)
        {
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        }
    }
}

@end
