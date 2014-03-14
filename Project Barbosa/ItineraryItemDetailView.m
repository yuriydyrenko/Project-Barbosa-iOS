//
//  ItineraryItemDetailView.m
//  Project Barbosa
//
//  Created by Yuriy Dyrenko on 2014-03-13.
//  Copyright (c) 2014 Project Barbosa. All rights reserved.
//

#import "ItineraryItemDetailView.h"
#import "ItineraryItem.h"

@interface ItineraryItemDetailView ()

@property (nonatomic, weak) IBOutlet UILabel *title;

@end

@implementation ItineraryItemDetailView

- (void)displayNoItineraryItemSelected
{
    NSLog(@"displayNoItineraryItem");
    self.title.text = @"No Itinerary Item Selected";
}

- (void)displayDetailsForItineraryItem:(ItineraryItem *)item
{
    self.title.text = item.title;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
