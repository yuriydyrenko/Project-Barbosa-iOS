//
//  TripViewController.h
//  Project Barbosa
//
//  Created by Yuriy Dyrenko on 2/19/2014.
//  Copyright (c) 2014 Project Barbosa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@class Trip;

@interface TripViewController : UIViewController <MKMapViewDelegate, UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) Trip *trip;

@end
