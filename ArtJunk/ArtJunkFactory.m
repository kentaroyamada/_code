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
- (void)artJunkDidSaveWithRequest:(ASIHTTPRequest *)request;

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




- (void)artJunkDidSaveWithRequest:(ASIFormDataRequest *)request  {
    
    
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
    
    [httpManager httpPostWithMethod:methodSave params:[artjunk toJSON]];
    
    
}





#pragma mark - LMHttpManager delegate

- (void)httpRequestWithMethod:(NSString *)name completed:(ASIFormDataRequest *)request {
    
    // If the method completed
    if ([name isEqualToString:methodSave]) {
        [self artJunkDidSaveWithRequest:request];
    }
}
@end

