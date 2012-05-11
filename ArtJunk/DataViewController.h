//
//  DataViewController.h
//  Top10
//
//  Created by Brody Nelson on 26/01/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ArtJunk.h"

@interface DataViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIImageView *ajImage;

@property (nonatomic, retain) IBOutlet UILabel * titleLabel;
@property (nonatomic, retain) IBOutlet UILabel * distanceLabel;
@property (nonatomic, retain) IBOutlet UILabel * materialLabel;

@property (strong, nonatomic) id dataObject;
@property (strong, nonatomic) ArtJunk * artjunk;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView * av;
@end
