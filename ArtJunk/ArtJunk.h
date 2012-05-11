//
//  ArtJunk.h
//  ArtJunk
//
//  Created by Brody Nelson on 27/02/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

#define keyTitle        @"title"
#define keyDatePosted   @"dateposted"
#define keyPhoto        @"photo"
#define keyLongitude    @"longitude"
#define keyLatitude     @"latitude"
#define keyStatus       @"status"
#define kImagePath      @"http://www.brodynelson.com/artjunk/images/"

@interface ArtJunk : NSObject <MKAnnotation>


@property (nonatomic) CLLocationCoordinate2D coordinate;
@property (strong, nonatomic) NSString * datePosted;
@property (strong, nonatomic) NSString * ajTitle;
@property (strong, nonatomic) NSMutableArray * materials;
@property (strong, nonatomic) UIImage * ajImage;
@property (nonatomic) bool status;


- (id)initWithContentsOfDictionary:(NSDictionary *)dictionary;
- (NSString *)toJSON;
@end
