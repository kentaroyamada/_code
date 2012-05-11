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

-(NSString*)toJSON {
    
    NSError * error;
    
    NSMutableDictionary *aj = [[NSMutableDictionary alloc] init];
    [aj setObject:self.ajTitle forKey:@"title"];
    
    //    [aj setObject:self.accountName forKey:keyAccountName];
    //    [aj setObject:self.providerId forKey:keyAccountProviderId];
    //        //build an info object and convert to json
    //    NSDictionary* aj = [NSDictionary dictionaryWithObjectsAndKeys:
    //                          self.ajTitle, @"title", self.coordinate.latitude, @"latitude",
    //                          self.coordinate.longitude, @"longitude",
    //                        nil];
    //    
    //convert object to data
    
    NSData* jsonData = [NSJSONSerialization dataWithJSONObject:aj 
                                                       options:NSJSONWritingPrettyPrinted error:&error];
    
    
    NSString * json = [[NSString alloc] initWithData:jsonData                                        
                                            encoding:NSUTF8StringEncoding];
    NSLog(@"JSON:%@",json);
    return json;
    
}

@end
