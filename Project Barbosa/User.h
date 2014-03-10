//
//  User.h
//  Project Barbosa
//
//  Created by Yuriy Dyrenko on 2014-03-10.
//  Copyright (c) 2014 Project Barbosa. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject

+ (void)checkIfLoggedIn;
+ (BOOL)loggedIn;
+ (NSString *)_id;
+ (void)setID:(NSString *)id;
+ (void)logout;

@end
