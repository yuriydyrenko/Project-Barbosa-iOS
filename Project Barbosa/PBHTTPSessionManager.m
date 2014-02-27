//
//  PBHTTPManager.m
//  Project Barbosa
//
//  Created by Yuriy Dyrenko on 2/27/2014.
//  Copyright (c) 2014 Project Barbosa. All rights reserved.
//

#import "PBHTTPSessionManager.h"

@implementation PBHTTPSessionManager

+ (instancetype)manager
{
    NSURL *baseURL;
    
    if(DEBUG)
    {
        baseURL = [NSURL URLWithString:@"http://localhost:3000/api/"];
    }
    else
    {
        baseURL = [NSURL URLWithString:@"http://project-barbosa.herokuapp.com/api/"];
    }
    
    return [[[self class] alloc] initWithBaseURL:baseURL];
}

@end
