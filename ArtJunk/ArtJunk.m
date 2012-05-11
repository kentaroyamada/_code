//
//  ArtJunk.m
//  ArtJunk
//
//  Created by Brody Nelson on 27/02/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ArtJunk.h"

@implementation ArtJunk 

@synthesize ajTitle,coordinate,ajImage,datePosted,materials,status;


//- (id)initWithDescription:(NSString *)description coordinate:(CLLocationCoordinate2D)coordinate {
//    if ((self = [super init])) {
//        _description = [description copy];
//        _coordinate = coordinate;
//        NSDate * date = [NSDate date]; 
//       
//        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//        [dateFormatter setTimeStyle:NSDateFormatterNoStyle];
//        [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
//
//        NSLocale *locale = [NSLocale currentLocale];
//        [dateFormatter setLocale:locale];
//        NSLog(@"Date for locale %@: %@",
//                             [[dateFormatter locale] localeIdentifier], [dateFormatter stringFromDate:date]);
//
//        _datePosted = [dateFormatter stringFromDate:date];
//        
//        _materials = [[NSMutableArray alloc] init];
//                       
//                       
//                       
//    }
//    return self;
//}
//
//- (NSString *)title {
//    return _description;
//}

- (id)init {
    self = [super init];
    if (self) {
        
    }
    
    return self;
}

- (id)initWithContentsOfDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        self.ajTitle = [dictionary objectForKey:keyTitle];
        self.datePosted =[dictionary objectForKey:keyDatePosted];
        
        self.coordinate = CLLocationCoordinate2DMake([[dictionary objectForKey:keyLatitude] doubleValue],[[dictionary objectForKey:keyLongitude] doubleValue]) ;
        self.status = [[dictionary objectForKey:keyStatus] boolValue];
        
        NSString * imgPath = [NSString stringWithFormat:@"%@%@",kImagePath,[dictionary objectForKey:keyPhoto]];
        self.ajImage = [UIImage imageWithData: [NSData dataWithContentsOfURL: [NSURL URLWithString:imgPath]]];
        
        
    }
    return self;
}
    
@end
