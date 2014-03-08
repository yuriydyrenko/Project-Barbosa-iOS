//
//  ViewController.m
//  Project Barbosa
//
//  Created by Yuriy Dyrenko on 2/11/2014.
//  Copyright (c) 2014 Project Barbosa. All rights reserved.
//

#import "MainViewController.h"
#import "PBHTTPSessionManager.h"
#import "AFNetworking.h"
#import "TripsCollectionView.h"
#import "TripsCollectionViewCell.h"
#import "Trip.h"
#import "TripViewController.h"

static NSString *cellIdentifier = @"TripsCollectionViewCell";
static NSString *tripViewControllerSegue = @"pushTripViewController";

@interface MainViewController ()

@property (nonatomic, strong) NSMutableArray *trips;
@property (nonatomic, weak) IBOutlet TripsCollectionView *tripsCollectionView;
@property (nonatomic, strong) Trip *selectedTrip;

@end

@implementation MainViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"MainViewController";
    
    [self setupCollectionViews];
    
    [PBHTTPSessionManager startedRequest];
    PBHTTPSessionManager *manager = [PBHTTPSessionManager manager];
    [manager GET:@"http://project-barbosa.herokuapp.com/trips" parameters:nil success:^(NSURLSessionDataTask *task, id responseObject)
    {
        if(responseObject != nil)
        {
            Trip *trip = nil;
            NSMutableArray *trips = [NSMutableArray array];
            NSError *error = nil;
            
            for(id tripDictionary in responseObject[@"trips"])
            {
                trip = [[Trip alloc] initWithDictionary:tripDictionary error:&error];
                
                if(!error)
                {
                    [trips addObject:trip];
                }
                else
                {
                    NSLog(@"JSON Trip Parse Error: %@", error);
                }
            }
            
            self.trips = trips;
            
            [self.tripsCollectionView reloadData];
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

#pragma mark - UICollectionsViewDataSource
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    TripsCollectionViewCell *cell = (TripsCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    Trip *trip = self.trips[indexPath.row];
    
    cell.tripName.text = trip.name;
    [cell.tripImage setImage: [trip getMapImage]];
    
    return cell;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.trips count];
}

#pragma mark - UICollectionsViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didHighlightItemAtIndexPath:(NSIndexPath *)indexPath
{
    self.selectedTrip = self.trips[indexPath.row];
}

#pragma mark - Storyboard
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:tripViewControllerSegue])
    {
        TripViewController *tripViewController = (TripViewController *)segue.destinationViewController;
        tripViewController.trip = self.selectedTrip;
    }
}

#pragma mark - UI
- (void)setupCollectionViews
{

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
