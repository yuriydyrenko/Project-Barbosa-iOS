//
//  LoginViewController.m
//  Project Barbosa
//
//  Created by Yuriy Dyrenko on 2014-03-10.
//  Copyright (c) 2014 Project Barbosa. All rights reserved.
//

#import "LoginViewController.h"
#import "PBHTTPSessionManager.h"
#import "User.h"

@interface LoginViewController ()

@property (nonatomic, weak) IBOutlet UITextField *email;
@property (nonatomic, weak) IBOutlet UITextField *password;

@end

@implementation LoginViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

#pragma mark - Actions
- (IBAction)done:(id)sender
{
    NSString *email = self.email.text;
    NSString *password = self.password.text;
    
    if([email isEqualToString:@""])
    {
        [self showErrorAlertWithMessage:@"Please enter your email."];
        [self.email becomeFirstResponder];
    }
    else if([password isEqualToString:@""])
    {
        [self showErrorAlertWithMessage:@"Please enter your password"];
        [self.password becomeFirstResponder];
    }
    else
    {
        [PBHTTPSessionManager startedRequest];
        PBHTTPSessionManager *manager = [PBHTTPSessionManager manager];
        [manager POST:@"login" parameters:@{@"email": email, @"password": password} success:^(NSURLSessionDataTask *task, id responseObject)
        {
            if(responseObject != nil)
            {
                if([responseObject isKindOfClass:[NSDictionary class]])
                {
                    [User setID:[responseObject objectForKey:@"userID"]];
                    [self.delegate didFinishLoggingInSuccessfully];
                }
                else
                {
                    NSString *errorMessage = @"";
                    
                    for(NSString *message in responseObject)
                    {
                        [errorMessage stringByAppendingFormat:@"%@ ", message];
                    }
                    
                    [self showErrorAlertWithMessage:errorMessage];
                }
            }
            else
            {
                [self showErrorAlertWithMessage:@"A server error has occured, could not login."];
            }
            
            [PBHTTPSessionManager finishedRequest];
        }
        failure:^(NSURLSessionDataTask *task, NSError *error)
        {
            [self showErrorAlertWithMessage:@"Could not connect to server."];
            [PBHTTPSessionManager finishedRequest];
        }];
    }
}

- (void)showErrorAlertWithMessage:(NSString *)message
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:message delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
    [alertView show];
}

@end
