//
//  LocationManager.m
//  ArtJunk
//
//  Created by Brody Nelson on 14/05/12.
//  Copyright (c) 2012 Digital Projects Limited. All rights reserved.
//

#import "LocationManager.h"

@implementation LocationManager
@synthesize currentLocation,locManager;
static LocationManager * _sharedLocationManager = nil;                      

+(LocationManager*)sharedLocationManager {
    @synchronized([LocationManager class])                             
    {
        if(!_sharedLocationManager)                                    
            [[self alloc] init]; 
        return _sharedLocationManager;                    
    }
    return nil; 
}

+(id)alloc 
{
    @synchronized ([LocationManager class])                            
    {
        NSAssert(_sharedLocationManager == nil,
                 @"Attempted to allocated a second instance of the Location Manager singleton"); 
        _sharedLocationManager = [super alloc];
        return _sharedLocationManager;                                 
    }
    return nil;  
}

-(id)init {                                                         
    self = [super init];
    if (self != nil) {
        // Location Manager initialized
        self.currentLocation = [[CLLocation alloc] init];
        //Start detecting location
        locManager = [[CLLocationManager alloc] init];
        locManager.delegate = self;
        [locManager startUpdatingLocation];
     
        
    }
    return self;
}

#pragma mark Core Location 

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
    self.currentLocation = newLocation;
        
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    if(error.code == kCLErrorDenied) {
        [locManager stopUpdatingLocation];
    } else if(error.code == kCLErrorLocationUnknown) {
        // retry
    } else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error retrieving location"
                                                        message:[error description]
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }
}


@end
