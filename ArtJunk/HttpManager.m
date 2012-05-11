//
//  HttpManager.m
//  ArtJunk
//
//  Created by Brody Nelson on 8/05/12.
//  Copyright (c) 2012 Digital Projects Limited. All rights reserved.
//

#import "HttpManager.h"

@interface HttpManager (private)

- (void)httpRequestWithMethod:(NSString *)name params:(NSString *)json post:(BOOL)isPost;

@end

@implementation HttpManager (private)

- (void)httpRequestWithMethod:(NSString *)name params:(NSString *)json post:(BOOL)isPost {
    self.method = name;
    self.params = json;
    
    // Create the URL
    NSString *urlString = [[NSString alloc] initWithFormat:@"%@%@", httpRequestBaseUrl, self.method];
    NSURL *url = [[NSURL alloc] initWithString:urlString];
    
    // Create the request
    __block ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    [ASIHTTPRequest setShouldThrottleBandwidthForWWAN:YES];
    
    
    
    // Set it to post json data with a user authenticationId in the header
    if (isPost) {
        [request setRequestMethod:@"POST"];
    }
    
    [request addRequestHeader:@"Content-Type" value:@"application/json"];
    
    // Some of the requests are quite large so set the time out to 60 seconds and try a couple of times
    request.timeOutSeconds = 200;
    //[request setNumberOfTimesToRetryOnTimeout:2];
    
    
    
    if (self.params != nil) {
        NSMutableData *jsonData = [[self.params dataUsingEncoding:NSUTF8StringEncoding] mutableCopy];
        
        // Set the data to be sent
        [request setPostBody:jsonData];
    }
    
    // Actually, whether the request completes or fails, pass through to the same routine as the status code
    // will determine how the resulting request is handled
    [request setCompletionBlock:^{ 
        if (self.delegate && [self.delegate respondsToSelector:@selector(httpRequestWithMethod:completed:)]) {
            //            NSLog(@"LMHttpManager %@", NSStringFromSelector(_cmd));
            NSLog(@"Response String%@", [request responseString]);
            
            
            
            [self.delegate httpRequestWithMethod:self.method completed:request];
        }
    }];
    
    [request setFailedBlock:^{
        if (self.delegate && [self.delegate respondsToSelector:@selector(httpRequestWithMethod:completed:)]) {
            [self.delegate httpRequestWithMethod:self.method completed:request];
        }
    }];
    
    [request startAsynchronous];
    
}

@end


@implementation HttpManager

@synthesize delegate, method, params;



- (id)initWithDelegate:(id<HttpManagerDelegate>)aDelegate {
    self = [super init];
    if (self) {
        self.delegate = aDelegate;
        [ASIHTTPRequest setSessionCookies:nil];
    }
    return self;
}

- (void)httpGetWithMethod:(NSString *)name {
    [self httpRequestWithMethod:name params:nil post:NO];
}

- (void)httpPostWithMethod:(NSString *)name {
    [self httpRequestWithMethod:name params:nil post:YES];
}

- (void)httpPostWithMethod:(NSString *)name params:(NSString *)json{
    NSLog(@"LMHttpManager:%@ JSON Sent:%@", NSStringFromSelector(_cmd),json);
    
    [self httpRequestWithMethod:name params:json post:YES];
}


@end
