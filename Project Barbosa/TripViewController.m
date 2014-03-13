//
//  TripViewController.m
//  Project Barbosa
//
//  Created by Yuriy Dyrenko on 2/19/2014.
//  Copyright (c) 2014 Project Barbosa. All rights reserved.
//

#import "TripViewController.h"
#import "Trip.h"
#import "ItineraryItem.h"
#import "ItineraryItemTableViewCell.h"

static NSString *itineraryItemCellIdentifier = @"ItineraryItemCell";

@interface TripViewController ()

@property (nonatomic, strong) MKMapView *mapView;
@property (nonatomic, weak) IBOutlet UITableView *itineraryItemsTableView;

@end

@implementation TripViewController

#pragma mark - UIViewControllers
- (void)viewDidLoad
{
    [super viewDidLoad];
	
    self.title = self.trip.name;
    self.itineraryItemsTableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    [self addRightNavigationBarButtons];
}

#pragma mark - UITableViewDataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:itineraryItemCellIdentifier];
    ItineraryItem *itineraryItem = self.trip.itinerary[indexPath.row];
    
    if(cell == nil)
    {
        cell = [[ItineraryItemTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:itineraryItemCellIdentifier];
    }
    
    cell.textLabel.text = itineraryItem.title;
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.trip.itinerary count];
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
