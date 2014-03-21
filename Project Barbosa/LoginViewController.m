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
@property (nonatomic, weak) IBOutlet UILabel *errorMessage;

@end

@implementation LoginViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

#pragma mark - Actions
- (IBAction)done:(id)sender
{
    UIAlertView *alertView = nil;
    NSString *email = self.email.text;
    NSString *password = self.password.text;
    
    if([email isEqualToString:@""])
    {
        alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Please enter your email." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [self.email becomeFirstResponder];
    }
    
    if([password isEqualToString:@""])
    {
        alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Please enter your password" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [self.password becomeFirstResponder];
    }
    
    if(alertView != nil)
    {
        [alertView show];
        return;
    }
    
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
                for(NSString *message in responseObject)
                {
                    NSLog(@"%@", message);
                }
            }
        }
        else
        {
            NSLog(@"Error");
        }
        
        [PBHTTPSessionManager finishedRequest];
    }
    failure:^(NSURLSessionDataTask *task, NSError *error)
    {
        NSLog(@"Error: %@", error);
        [PBHTTPSessionManager finishedRequest];
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
