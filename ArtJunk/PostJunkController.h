//
//  PostJunkController.h
//  ArtJunk
//
//  Created by Brody Nelson on 27/02/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/Mapkit.h>
#import <CoreLocation/CoreLocation.h>
#import "ArtJunk.h"
#import "MBProgressHUD.h"
#import "ArtJunkFactory.h"

@interface PostJunkController : UIViewController <MBProgressHUDDelegate, CLLocationManagerDelegate, MKMapViewDelegate, ArtJunkFactoryDelegate>
{
@protected
    ArtJunkFactory * factory;
}
@property (strong, nonatomic) IBOutlet UITextField *titleTextField;
@property (strong, nonatomic) IBOutlet MKMapView *mapView;
@property (strong, nonatomic) IBOutlet UIButton *postButton;
@property (strong, nonatomic) UIImage * photo;
@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) CLLocation *currentLocation;
@property (strong,nonatomic) ArtJunk * artJunk;
- (IBAction)postArtJunk:(id)sender;

@end
