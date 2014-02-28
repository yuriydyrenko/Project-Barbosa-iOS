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

@interface MainViewController ()

@property (nonatomic, strong) NSMutableArray *trips;
@property (nonatomic, weak) IBOutlet TripsCollectionView *tripsCollectionView;

@end

@implementation MainViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"MainViewController";
    
    [self setupCollectionViews];
    
    [PBHTTPSessionManager startedRequest];
    PBHTTPSessionManager *manager = [PBHTTPSessionManager manager];
    [manager GET:@"trips" parameters:nil success:^(NSURLSessionDataTask *task, id responseObject)
    {
        if(responseObject != nil)
        {
            Trip *trip = nil;
            NSMutableArray *trips = [NSMutableArray array];
            NSError *error = nil;
            
            for(id tripDictionary in responseObject)
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
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    cell.backgroundColor = [UIColor redColor];
    return cell;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 10;
}

#pragma mark - UICollectionsViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didHighlightItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"selected");
}

#pragma mark - Storyboard
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"pushTripViewController"])
    {
        TripViewController *tripViewController = (TripViewController *)segue.destinationViewController;
        tripViewController.trip = self.trips[0];
    }
}

#pragma mark - UI
- (void)setupCollectionViews
{
    ((UICollectionViewFlowLayout *)self.tripsCollectionView.collectionViewLayout).scrollDirection = UICollectionViewScrollDirectionHorizontal;
    ((UICollectionViewFlowLayout *)self.tripsCollectionView.collectionViewLayout).minimumLineSpacing = 10.0f;
    [self.tripsCollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:cellIdentifier];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
