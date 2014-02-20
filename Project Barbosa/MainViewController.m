//
//  ViewController.m
//  Project Barbosa
//
//  Created by Yuriy Dyrenko on 2/11/2014.
//  Copyright (c) 2014 Project Barbosa. All rights reserved.
//

#import "MainViewController.h"
#import "TripsCollectionView.h"
#import "TripsCollectionViewCell.h"
#import "Trip.h"
#import "TripViewController.h"

static NSString *cellIdentifier = @"TripsCollectionViewCell";

@interface MainViewController ()

@property (nonatomic, strong) NSMutableArray *userTrips;
@property (nonatomic, weak) IBOutlet TripsCollectionView *userTripsCollectionView;

@end

@implementation MainViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"MainViewController";
	
    Trip *sampleTrip = [[Trip alloc] initWithID:@"1" name:@"Sample Trip"];
    _userTrips = [[NSMutableArray alloc] initWithObjects:sampleTrip, nil];
    
    [self setupCollectionViews];
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
        tripViewController.trip = self.userTrips[0];
    }
}

#pragma mark - UI
- (void)setupCollectionViews
{
    ((UICollectionViewFlowLayout *)self.userTripsCollectionView.collectionViewLayout).scrollDirection = UICollectionViewScrollDirectionHorizontal;
    ((UICollectionViewFlowLayout *)self.userTripsCollectionView.collectionViewLayout).minimumLineSpacing = 10.0f;
    [self.userTripsCollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:cellIdentifier];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
