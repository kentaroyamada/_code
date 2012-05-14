//
//  BrowseViewController.h
//  ArtJunk
//
//  Created by Brody Nelson on 8/05/12.
//  Copyright (c) 2012 Digital Projects Limited. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ArtJunk.h"
#import "ArtJunkFactory.h"
#import "ModelController.h"
#import "MBProgressHUD.h"

@interface BrowseViewController : UIViewController <ArtJunkFactoryDelegate,ASIHTTPRequestDelegate, UIPageViewControllerDelegate,CLLocationManagerDelegate,MBProgressHUDDelegate> {

@protected
    ArtJunkFactory * factory;
    MBProgressHUD * progressHUD;
}
@property (strong, nonatomic) UIPageViewController *pageViewController;
@property (nonatomic, retain) NSMutableArray * artjunks;
@property  (strong, nonatomic) ModelController *modelController;
@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) CLLocation *currentLocation;

-(void)downloadArtjunks;

@end
