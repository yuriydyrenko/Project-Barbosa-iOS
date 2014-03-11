//
//  LoginViewController.h
//  Project Barbosa
//
//  Created by Yuriy Dyrenko on 2014-03-10.
//  Copyright (c) 2014 Project Barbosa. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LoginViewControllerDelegate;

@interface LoginViewController : UIViewController

@property (nonatomic, assign) id<LoginViewControllerDelegate> delegate;

@end

@protocol LoginViewControllerDelegate <NSObject>

- (void)didFinishLoggingInSuccessfully;

@end