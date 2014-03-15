//
//  ViewController.m
//  Project Barbosa
//
//  Created by Yuriy Dyrenko on 2/11/2014.
//  Copyright (c) 2014 Project Barbosa. All rights reserved.
//

#import "MainViewController.h"
#import "PB.h"
#import "AFNetworking.h"
#import "TripsCollectionView.h"
#import "TripsCollectionViewCell.h"
#import "Trip.h"
#import "TripViewController.h"
#import "User.h"

static NSString *cellIdentifier = @"TripsCollectionViewCell";
static NSString *tripViewControllerSegue = @"pushTripViewController";
static NSString *loginViewControllerSegue = @"popoverLoginViewController";

@interface MainViewController ()

@property (nonatomic, strong) NSArray *userTrips;
@property (nonatomic, strong) NSArray *publicTrips;
@property (nonatomic, weak) IBOutlet TripsCollectionView *userTripsCollectionView;
@property (nonatomic, weak) IBOutlet TripsCollectionView *publicTripsCollectionView;
@property (nonatomic, strong) Trip *selectedTrip;
@property (nonatomic, strong) Trip *selectedUserTrip;
@property (nonatomic, strong) Trip *selectedPublicTrip;
@property (nonatomic, strong) IBOutlet UIBarButtonItem *loginButton;
@property (nonatomic, strong) UIPopoverController *loginPopoverController;

@end

@implementation MainViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if([User loggedIn])
    {
        [self didFinishLoggingInSuccessfully];
    }
    
    [PBTripManager getAllTripsWithSuccess:^(NSArray *trips, NSInteger count, NSArray *errors)
    {
        self.publicTrips = trips;
        [self.publicTripsCollectionView reloadData];
    }
    failure:^(NSError *error)
    {
        NSLog(@"Error: %@", error);
    }];
}

#pragma mark - UICollectionsViewDataSource
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    TripsCollectionViewCell *cell = (TripsCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    Trip *publicTrip = self.publicTrips[indexPath.row];
    
    cell.tripName.text = publicTrip.name;
    [cell.tripImage setImage: [publicTrip getMapImage]];
    
    return cell;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.publicTrips count];
}

#pragma mark - UICollectionsViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didHighlightItemAtIndexPath:(NSIndexPath *)indexPath
{
    if(collectionView == self.userTripsCollectionView)
        self.selectedTrip = self.userTrips[indexPath.row];
    else
        self.selectedTrip = self.publicTrips[indexPath.row];
}

#pragma mark - Storyboard
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:tripViewControllerSegue])
    {
        TripViewController *tripViewController = (TripViewController *)segue.destinationViewController;
        tripViewController.trip = self.selectedTrip;
    }
    else if([segue.identifier isEqualToString:loginViewControllerSegue])
    {
        self.loginPopoverController = [(UIStoryboardPopoverSegue *)segue popoverController];
        LoginViewController *loginViewController = ((UINavigationController *)segue.destinationViewController).viewControllers[0];
        loginViewController.delegate = self;
    }
}

-(BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender
{
    BOOL shouldPerform = YES;
    
    if([identifier isEqualToString:loginViewControllerSegue] && self.loginPopoverController.isPopoverVisible)
    {
        shouldPerform = NO;
    }
    
    return shouldPerform;
}

#pragma mark - LoginViewControllerDelegate
- (void)didFinishLoggingInSuccessfully
{
    NSLog(@"user logged in.");
    [self.loginPopoverController dismissPopoverAnimated:YES];
    
    UIBarButtonItem *syncButton = [[UIBarButtonItem alloc] initWithTitle:@"Sync" style:UIBarButtonItemStylePlain target:self action:@selector(sync:)];
    self.navigationItem.leftBarButtonItem = syncButton;
    
    UIBarButtonItem *logoutButton = [[UIBarButtonItem alloc] initWithTitle:@"Logout" style:UIBarButtonItemStylePlain target:self action:@selector(logout:)];
    self.navigationItem.rightBarButtonItem = logoutButton;
}

#pragma mark - Actions
- (void)login:(UIBarButtonItem *)button
{
    [self.loginPopoverController presentPopoverFromBarButtonItem:button permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
}

- (void)sync:(UIBarButtonItem *)button
{
    NSLog(@"sync");
}

- (void)logout:(UIBarButtonItem *)button
{
    [User logout];
    UIBarButtonItem *loginButton = [[UIBarButtonItem alloc] initWithTitle:@"Login" style:UIBarButtonItemStylePlain target:self action:@selector(login:)];
    self.navigationItem.leftBarButtonItem = loginButton;
    self.navigationItem.rightBarButtonItem = nil;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
