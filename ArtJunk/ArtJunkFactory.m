//
//  ArtJunkFactory.m
//  ArtJunk
//
//  Created by Brody Nelson on 8/05/12.
//  Copyright (c) 2012 Digital Projects Limited. All rights reserved.
//

#import "ArtJunkFactory.h"
#import "ASIFormDataRequest.h"
#import "ArtJunk+NSDictionary.h"
#import "AppDelegate.h"





@interface ArtJunkFactory (private)


- (void)artJunkDidDownloadWithRequest:(NSData *)data;
- (void)artJunkDidSaveWithRequest:(NSData *)data;

@end

@implementation ArtJunkFactory (private)


- (void)artJunkDidDownloadWithRequest:(NSData *)responseData {
            //parse out the json data
        NSError* error;
        NSDictionary* json = [NSJSONSerialization 
                              JSONObjectWithData:responseData //1
                              
                              options:kNilOptions 
                              error:&error];
// Parse JSON, create artjunk objects, return array of aj
    NSMutableArray * artjunks = [[NSMutableArray alloc] init];
    for (NSDictionary * artjunkDic in json) {
        ArtJunk * anArtJunk = [[ArtJunk alloc] initWithContentsOfDictionary:artjunkDic];
        [artjunks addObject:anArtJunk];
    }

            
            NSLog(@"artjunk: %@", artjunks);
    
    // Respond back to delegate in main thread as UI changes will occur
    dispatch_async(dispatch_get_main_queue(), ^{
        
        // Return the list of artjunks or nil if none were received
        if (self.delegate && [self.delegate respondsToSelector:@selector(artJunkDidDownload:)]) {
            [self.delegate artJunkDidDownload:artjunks];
        }
    });
}




- (void)artJunkDidSaveWithRequest:(NSData *)responseData {
     
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        // Return the list of artjunks or nil if none were received
        if (self.delegate && [self.delegate respondsToSelector:@selector(artJunkDidSave:)]) {
            [self.delegate artJunkDidSave:true];
        }
    });
    
}


@end



@implementation ArtJunkFactory
@synthesize delegate;

- (id)init {
    self = [super init];
    if (self) {
                
    }
    return self;
}

- (id)initWithDelegate:(id<ArtJunkFactoryDelegate>)aDelegate {
    self = [self init];
    if (self) {
        self.delegate = aDelegate;
    }
    return self;
}


- (NSMutableArray *)artjunks {
    
    return self.artjunks;
}



- (void)clear {

}





- (void)download {
    // Request  from server
    
    NSURL * url = [NSURL URLWithString:kURLArtJunkGet];
    NSLog(@"url:%@",url);
    dispatch_async(kBgQueue, ^{
        NSData* data = [NSData dataWithContentsOfURL: 
                        url];
        
        [self performSelectorOnMainThread:@selector(artJunkDidDownloadWithRequest:) 
                               withObject:data waitUntilDone:YES];
    });
    
    }


- (void)upload:(ArtJunk *)artjunk {
    NSURL *url = [NSURL URLWithString:kURLArtJunkSave];
    NSNumber * status = [NSNumber numberWithBool:artjunk.status];

    NSNumber * longitude = [NSNumber numberWithDouble:artjunk.coordinate.longitude];
    NSNumber * latitude = [NSNumber numberWithDouble:artjunk.coordinate.latitude];
    
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    NSLog(@"title:%@",artjunk.ajTitle);
    //artjunk.ajTitle
    [request setPostValue:@"fuuuuuhhhhh" forKey:@"title"];
    [request setPostValue:longitude forKey:@"longitude"];
    [request setPostValue:latitude forKey:@"latitude"];
    [request setPostValue:status forKey:@"status"];
    [request setDelegate:self];
    [request setDidFinishSelector:@selector(requestFinished:)];
    [request setDidFailSelector:@selector(requestFailed:)];
    [request startAsynchronous];    
    


    
}




- (BOOL)save {
    return true;
}

#pragma mark - ASIHttpRequestDelegate

- (void)requestFinished:(ASIHTTPRequest *)request {
    NSLog(@"%@",[request responseString]);
  //  NSLog(@"%@",[request responseStatusCode]);
    NSLog(@"%@",[request responseData]);
    [self artJunkDidSaveWithRequest:[request responseData]];

    
}
- (void)requestFailed:(ASIHTTPRequest *)request {
    NSLog(@"%@",[request responseString]);    
}


@end

