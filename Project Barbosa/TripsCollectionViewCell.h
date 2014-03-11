//
//  TripsCollectionViewCell.h
//  Project Barbosa
//
//  Created by Yuriy Dyrenko on 2/19/2014.
//  Copyright (c) 2014 Project Barbosa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TripsCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UILabel *tripName;
@property (weak, nonatomic) IBOutlet UIImageView *tripImage;

@end
