//
//  LocationManager.h
//  ArtJunk
//
//  Created by Brody Nelson on 14/05/12.
//  Copyright (c) 2012 Digital Projects Limited. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface LocationManager : NSObject <CLLocationManagerDelegate>


@property (strong, nonatomic) CLLocationManager *locManager;
@property (strong, nonatomic) CLLocation *currentLocation;


+(LocationManager*)sharedLocationManager;
@end
