//
//  TitleExpiryViewController.h
//  ArtJunk
//
//  Created by Brody Nelson on 10/05/12.
//  Copyright (c) 2012 Digital Projects Limited. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ArtJunk.h"
#import "ArtJunkFactory.h"

@interface TitleExpiryViewController : UIViewController <UITextFieldDelegate, ArtJunkFactoryDelegate, CLLocationManagerDelegate> {
    @protected
    ArtJunkFactory * factory;
}

@property (strong, nonatomic) ArtJunk * artjunk;
@property (strong, nonatomic) IBOutlet UISlider *expirySlider;
@property (strong, nonatomic) IBOutlet UITextField *titleTextField;
@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) CLLocation *currentLocation;
- (IBAction)submitArtjunk:(id)sender;
- (IBAction)cancelArtjunk:(id)sender;

@end
