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
#import <Reachability/Reachability.h>

static NSUInteger kUserNoticesDefaultCapacity = 5;
static NSString *kDefaultURLToTest = @"www.google.com";

static NSString *cellIdentifier = @"TripsCollectionViewCell";
static NSString *tripViewControllerSegue = @"pushTripViewController";
static NSString *loginViewControllerSegue = @"popoverLoginViewController";

typedef NS_ENUM(NSUInteger, PBNoticeType) {
    PBNoticeTypeLogin
};

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
@property (nonatomic, strong) NSMutableDictionary *userNotices;

@end

@implementation MainViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _userNotices = [[NSMutableDictionary alloc] initWithCapacity:kUserNoticesDefaultCapacity];
    Reachability *reach = [Reachability reachabilityWithHostname:kDefaultURLToTest];
    reach.reachableBlock = ^(Reachability *reach)
    {
        dispatch_async(dispatch_get_main_queue(), ^
        {
            if([User loggedIn])
            {
                [self didFinishLoggingInSuccessfully];
            }
            else
            {
                [self showLoginNotice];
            }
            
            [self loadPublicTrips];
        });
    };
    reach.unreachableBlock = ^(Reachability *reach)
    {
        dispatch_async(dispatch_get_main_queue(), ^
        {
            if([User loggedIn])
            {
                [self loadSavedTrips];
            }
            else
            {
                
            }
        });
    };
    
    [reach startNotifier];
}

#pragma mark - UICollectionsViewDataSource
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    TripsCollectionViewCell *cell = (TripsCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    Trip *trip;
    
    if(collectionView == self.userTripsCollectionView)
        trip = self.userTrips[indexPath.row];
    else
        trip = self.publicTrips[indexPath.row];
    
    cell.tripName.text = trip.name;
    [cell.tripImage setImage: [trip getMapImage]];
    
    return cell;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSInteger count;
    
    if(collectionView == self.userTripsCollectionView)
        count = self.userTrips.count;
    else
        count = self.publicTrips.count;
    
    return count;
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
    [self.loginPopoverController dismissPopoverAnimated:YES];
    [self hideLoginNotice];
    [self loadUserTrips];
    
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
    [self loadUserTrips];
}

- (void)logout:(UIBarButtonItem *)button
{
    [User logout];
    UIBarButtonItem *loginButton = [[UIBarButtonItem alloc] initWithTitle:@"Login" style:UIBarButtonItemStylePlain target:self action:@selector(login:)];
    self.navigationItem.leftBarButtonItem = loginButton;
    self.navigationItem.rightBarButtonItem = nil;
    
    self.userTrips = nil;
    [self.userTripsCollectionView reloadData];
    
    [self showLoginNotice];
}

- (void)loadPublicTrips
{
    [PBTripManager getAllTripsWithSuccess:^(NSArray *trips, NSInteger count, NSArray *errors)
    {
        self.publicTrips = trips;
        Trip *trip = [trips objectAtIndex:0];
        NSLog(@"public trips: %@", trip);
        [self.publicTripsCollectionView reloadData];
    }
    failure:^(NSError *error)
    {
        NSLog(@"Error: %@", error);
    }];
}

- (void)loadUserTrips
{
    [PBTripManager getAllTripsForUserID:[User _id] success:^(NSArray *trips, NSInteger count, NSArray *errors)
    {
        NSLog(@"got trips: %@ %@", [trips class], trips);
        self.userTrips = trips;
        [self.userTripsCollectionView reloadData];
        [PBTripManager storeSavedTrips:self.userTrips];
    }
    failure:^(NSError *error)
    {
        NSLog(@"Failed loading user trips.");
    }];
}

- (void)loadSavedTrips
{
    self.userTrips = [PBTripManager loadSavedTrips];
    [self.userTripsCollectionView reloadData];
}

#pragma mark - UI
- (void)showLoginNotice
{
    [self showNoticeType:PBNoticeTypeLogin aboveView:self.userTripsCollectionView text:@"Please login to view your trips."];
}

- (void)hideLoginNotice
{
    [self removeNoticeType:PBNoticeTypeLogin];
}

- (void)showNoticeType:(PBNoticeType)noticeType aboveView:(UIView *)view text:(NSString *)text
{
    UILabel *notice = [[UILabel alloc] initWithFrame:view.frame];
    notice.text = text;
    notice.textAlignment = NSTextAlignmentCenter;
    notice.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:notice];
    [self.view bringSubviewToFront:notice];
    [self.userNotices setObject:notice forKey:@(noticeType)];
}

- (void)removeNoticeType:(PBNoticeType)noticeType
{
    UILabel *notice = self.userNotices[@(noticeType)];
    
    if(notice != nil)
    {
        [notice removeFromSuperview];
        [self.userNotices removeObjectForKey:@(noticeType)];
    }
}

#pragma mark - NSOjbect
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
