//
//  TripViewController.m
//  Project Barbosa
//
//  Created by Yuriy Dyrenko on 2/19/2014.
//  Copyright (c) 2014 Project Barbosa. All rights reserved.
//

#import "TripViewController.h"
#import "Trip.h"

@interface TripViewController ()

@property (nonatomic, strong) MKMapView *mapView;

@end

@implementation TripViewController

#pragma mark - UIViewControllers
- (void)viewDidLoad
{
    [super viewDidLoad];
	
    self.title = self.trip.name;
    
    NSLog(@"TripViewController viewDidLoad with trip: %@", self.trip);
    
    [self addRightNavigationBarButtons];
}

#pragma mark - UITableViewDataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}

#pragma mark - Actions
- (void)sync:(UIBarButtonItem *)button
{
    
}

- (void)share:(UIBarButtonItem *)share
{
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UI
- (void)addRightNavigationBarButtons
{
    UIBarButtonItem *syncButton = [[UIBarButtonItem alloc] initWithTitle:@"Sync" style:UIBarButtonItemStylePlain target:self action:@selector(sync:)];
    UIBarButtonItem *shareButton = [[UIBarButtonItem alloc] initWithTitle:@"Share" style:UIBarButtonItemStylePlain target:self action:@selector(share:)];
    NSArray *buttons = [NSArray arrayWithObjects:syncButton, shareButton, nil];
    self.navigationItem.rightBarButtonItems = buttons;
}

@end
