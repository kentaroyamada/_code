//
//  DataViewController.m
//  Top10
//
//  Created by Brody Nelson on 26/01/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//




#import "DataViewController.h"
#import "LocationManager.h"

@interface DataViewController (private)
- (NSString *) calculateDistance;
@end

@implementation DataViewController (private)
-(NSString *) calculateDistance {
    CLLocation * ajLocation = [[CLLocation alloc] initWithLatitude:self.artjunk.coordinate.latitude longitude:self.artjunk.coordinate.longitude];
    
    CLLocationDistance distance = [self.currentLocation distanceFromLocation:ajLocation];
    NSString *str;
    if (distance>1000) {
        distance/=1000;       
        str  = [NSString stringWithFormat:@"%.1fkm away", distance];        
            }
            else {
                str  = [NSString stringWithFormat:@"%.0fm away", distance];
            }
    return str;

}
@end

@implementation DataViewController

@synthesize titleLabel, distanceLabel, ajImage, dataObject, materialLabel, artjunk, currentLocation, locationManager;


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.currentLocation = [[CLLocation alloc] init];
//    //Start detecting location
//    locationManager = [[CLLocationManager alloc] init];
//    locationManager.delegate = self;
//    [locationManager startUpdatingLocation];
    
    self.artjunk = (ArtJunk*)self.dataObject;
    self.titleLabel.text = self.artjunk.ajTitle;
    self.ajImage.image = self.artjunk.ajImage;
    self.currentLocation = [[LocationManager sharedLocationManager] currentLocation];
    
    NSString * distance = [self calculateDistance];
    self.distanceLabel.text = distance;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    [locationManager stopUpdatingLocation];
    self.currentLocation = nil;
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    
       
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
    
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

//#pragma mark Core Location 
//
//- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
//    self.currentLocation = newLocation;
//    NSString * distance = [self calculateDistance];
//    self.distanceLabel.text = distance;
//    
//}
//
//- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
//    if(error.code == kCLErrorDenied) {
//        [locationManager stopUpdatingLocation];
//    } else if(error.code == kCLErrorLocationUnknown) {
//        // retry
//    } else {
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error retrieving location"
//                                                        message:[error description]
//                                                       delegate:nil
//                                              cancelButtonTitle:@"OK"
//                                              otherButtonTitles:nil];
//        [alert show];
//    }
//}


@end
