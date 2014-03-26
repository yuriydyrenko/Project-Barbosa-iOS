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
    ItineraryItemLocation *itemLocation = (ItineraryItemLocation *)[(ItineraryItem *)self.trip.itinerary[section] location];
    return itemLocation.name;
}

#pragma mark - UITableView Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ItineraryItem *item = self.trip.itinerary[indexPath.section];
    [self.itineraryItemDetailView displayDetailsForItineraryItem:item];
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
    ItineraryItemLocation *location;
    TripViewMapAnnotation *annotation;
    CLLocationCoordinate2D coordinate;
    CLLocationCoordinate2D *coordinates = calloc(self.trip.itinerary.count, sizeof(CLLocationCoordinate2D));
    
    for(NSInteger ii = 0; ii < self.trip.itinerary.count; ii++)
    {
        item = (ItineraryItem *)self.trip.itinerary[ii];
        location = (ItineraryItemLocation *)item.location;
        coordinate = CLLocationCoordinate2DMake(location.latitude, location.longitude);
        coordinates[ii] = coordinate;
        
        annotation = [[TripViewMapAnnotation alloc] initWithTitle:item.title coordinate:coordinate];
        [self.mapView addAnnotation:annotation];
    }
    
    [self zoomMapViewToFitAnnotations:self.mapView animated:NO];
    
    MKPolyline *tripPath = [MKPolyline polylineWithCoordinates:coordinates count:self.trip.itinerary.count];
    [self.mapView addOverlay:tripPath];
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(TripViewMapAnnotation *)annotation
{
    MKPinAnnotationView *pin = (MKPinAnnotationView *)[self.mapView dequeueReusableAnnotationViewWithIdentifier:mapViewAnnotationIdentifier];
    
    if(pin == nil)
    {
        pin = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:mapViewAnnotationIdentifier];
    }
    
    pin.animatesDrop = NO;
    pin.canShowCallout = YES;
    pin.pinColor = MKPinAnnotationColorRed;
    
    return pin;
}

#define MINIMUM_ZOOM_ARC 0.014 //approximately 1 miles (1 degree of arc ~= 69 miles)
#define ANNOTATION_REGION_PAD_FACTOR 2.5
#define MAX_DEGREES_ARC 360
//http://brianreiter.org/2012/03/02/size-an-mkmapview-to-fit-its-annotations-in-ios-without-futzing-with-coordinate-systems/
- (void)zoomMapViewToFitAnnotations:(MKMapView *)mapView animated:(BOOL)animated
{
    CGPoint point;
    CLLocationCoordinate2D coordinate;
    NSArray *annotations = mapView.annotations;
    NSInteger count = [mapView.annotations count];
    if ( count == 0) { return; } //bail if no annotations
     
    //convert NSArray of id <MKAnnotation> into an MKCoordinateRegion that can be used to set the map size
    //can't use NSArray with MKMapPoint because MKMapPoint is not an id
    MKMapPoint points[count]; //C array of MKMapPoint struct
    for( int i=0; i<count; i++ ) //load points C array by converting coordinates to points
    {
        coordinate = [(id <MKAnnotation>)[annotations objectAtIndex:i] coordinate];
        points[i] = MKMapPointForCoordinate(coordinate);
    }
    //create MKMapRect from array of MKMapPoint
    MKMapRect mapRect = [[MKPolygon polygonWithPoints:points count:count] boundingMapRect];
    //convert MKCoordinateRegion from MKMapRect
    MKCoordinateRegion region = MKCoordinateRegionForMapRect(mapRect);
     
    //add padding so pins aren't scrunched on the edges
    region.span.latitudeDelta  *= ANNOTATION_REGION_PAD_FACTOR;
    region.span.longitudeDelta *= ANNOTATION_REGION_PAD_FACTOR;
    //but padding can't be bigger than the world
    if( region.span.latitudeDelta > MAX_DEGREES_ARC ) { region.span.latitudeDelta  = MAX_DEGREES_ARC; }
    if( region.span.longitudeDelta > MAX_DEGREES_ARC ){ region.span.longitudeDelta = MAX_DEGREES_ARC; }
     
    //and don't zoom in stupid-close on small samples
    if( region.span.latitudeDelta  < MINIMUM_ZOOM_ARC ) { region.span.latitudeDelta  = MINIMUM_ZOOM_ARC; }
    if( region.span.longitudeDelta < MINIMUM_ZOOM_ARC ) { region.span.longitudeDelta = MINIMUM_ZOOM_ARC; }
    //and if there is a sample of 1 we want the max zoom-in instead of max zoom-out
    if( count == 1 )
    { 
        region.span.latitudeDelta = MINIMUM_ZOOM_ARC;
        region.span.longitudeDelta = MINIMUM_ZOOM_ARC;
    }
    
    
    point = [mapView convertCoordinate:region.center toPointToView:mapView];
    point.x += 30;
    point.y += 20;
    region.center = [mapView convertPoint:point toCoordinateFromView:mapView];
    
    [mapView setRegion:region animated:animated];
}

- (void)moveCenterByOffset:(CGPoint)offset from:(CLLocationCoordinate2D)coordinate
{
    CGPoint point = [self.mapView convertCoordinate:coordinate toPointToView:self.mapView];
    point.x += offset.x;
    point.y += offset.y;
    CLLocationCoordinate2D center = [self.mapView convertPoint:point toCoordinateFromView:self.mapView];
    [self.mapView setCenterCoordinate:center animated:NO];
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

#pragma mark - NSObject
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
