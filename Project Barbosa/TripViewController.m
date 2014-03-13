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
#import "TripViewMapView.h"
#import "ItineraryItemDetailView.h"
#import "TripViewMapAnnotation.h"

static NSString *itineraryItemCellIdentifier = @"ItineraryItemCell";
static NSString *mapViewAnnotationIdentifier = @"TripViewMapAnnotation";

@interface TripViewController ()

@property (nonatomic, weak) IBOutlet MKMapView *mapView;
@property (nonatomic, weak) IBOutlet UITableView *itineraryItemsTableView;
@property (nonatomic, weak) IBOutlet ItineraryItemDetailView *itineraryItemDetailView;

@end

@implementation TripViewController

#pragma mark - UIViewControllers
- (void)viewDidLoad
{
    [super viewDidLoad];
	
    self.title = self.trip.name;
    self.itineraryItemsTableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    [self addRightNavigationBarButtons];
    [self drawTripPath];
    [self.itineraryItemDetailView displayNoItineraryItemSelected];
}

#pragma mark - UITableViewDataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ItineraryItemTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:itineraryItemCellIdentifier];
    ItineraryItem *itineraryItem = self.trip.itinerary[indexPath.section];
    
    if(cell == nil)
    {
        cell = [[ItineraryItemTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:itineraryItemCellIdentifier];
    }
    
    cell.title.text = itineraryItem.title;
    cell.details.text = itineraryItem.details;
    
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.trip.itinerary.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSDictionary *itemLocation = (NSDictionary *)[(ItineraryItem *)self.trip.itinerary[section] location];
    return itemLocation[@"name"];
}

#pragma mark - UITableView Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ItineraryItem *item = self.trip.itinerary[indexPath.section];
    [self.itineraryItemDetailView displayDetailsForItineraryItem:item];
}

#pragma mark - Actions
- (void)sync:(UIBarButtonItem *)button
{
    
}

- (void)share:(UIBarButtonItem *)share
{
    
}

#pragma mark - MapView
- (MKOverlayView *)mapView:(MKMapView *)mapView viewForOverlay:(id<MKOverlay>)overlay
{
    MKPolylineView *overlayView = [[MKPolylineView alloc] initWithPolyline:(MKPolyline *)overlay];
    overlayView.fillColor = [UIColor blackColor];
    overlayView.strokeColor = [UIColor blackColor];
    overlayView.lineWidth = 4;
    
    return overlayView;
}

- (void)drawTripPath
{
    if(self.trip.itinerary.count == 0)
        return;
    
    ItineraryItem *item;
    NSDictionary *location;
    TripViewMapAnnotation *annotation;
    CLLocationCoordinate2D coordinate;
    CLLocationCoordinate2D *coordinates = calloc(self.trip.itinerary.count, sizeof(CLLocationCoordinate2D));
    
    for(NSInteger ii = 0; ii < self.trip.itinerary.count; ii++)
    {
        item = (ItineraryItem *)self.trip.itinerary[ii];
        location = (NSDictionary *)item.location;
        coordinate = CLLocationCoordinate2DMake([[location objectForKey:@"latitude"] floatValue], [[location objectForKey:@"longitude"] floatValue]);
        coordinates[ii] = coordinate;
        
        annotation = [[TripViewMapAnnotation alloc] initWithTitle:item.title coordinate:coordinate];
        [self.mapView addAnnotation:annotation];
    }
    
    [self centerMapForCoordinate:coordinates[0]];
    
    MKPolyline *tripPath = [MKPolyline polylineWithCoordinates:coordinates count:self.trip.itinerary.count];
    [self.mapView addOverlay:tripPath];
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(TripViewMapAnnotation *)annotation
{
    MKPinAnnotationView *pin = (MKPinAnnotationView *)[self.mapView dequeueReusableAnnotationViewWithIdentifier:mapViewAnnotationIdentifier];
    
    if(pin == nil)
    {
        pin =[[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:mapViewAnnotationIdentifier];
    }
    
    pin.animatesDrop = NO;
    pin.canShowCallout = YES;
    pin.pinColor = MKPinAnnotationColorRed;
    
    return pin;
}

- (void)centerMapForCoordinate:(CLLocationCoordinate2D)coordinate
{
    MKCoordinateSpan span;
    MKCoordinateRegion region;
    
    span.latitudeDelta = 0.05f;
    span.longitudeDelta = 0.05f;
    
    region.center = coordinate;
    region.span = span;
    
    [self.mapView setRegion:region];
}

#pragma mark - UI
- (void)addRightNavigationBarButtons
{
    UIBarButtonItem *syncButton = [[UIBarButtonItem alloc] initWithTitle:@"Sync" style:UIBarButtonItemStylePlain target:self action:@selector(sync:)];
    UIBarButtonItem *shareButton = [[UIBarButtonItem alloc] initWithTitle:@"Share" style:UIBarButtonItemStylePlain target:self action:@selector(share:)];
    NSArray *buttons = [NSArray arrayWithObjects:syncButton, shareButton, nil];
    self.navigationItem.rightBarButtonItems = buttons;
}

#pragma mark - NSObject
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
