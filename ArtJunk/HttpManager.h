//
//  HttpManager.h
//  ArtJunk
//
//  Created by Brody Nelson on 8/05/12.
//  Copyright (c) 2012 Digital Projects Limited. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASIFormDataRequest.h"

#define httpRequestBaseUrl @"http://www.brodynelson.com/"

typedef enum LMHttpResponseCode {
    LMHttpResponseOkay = 200,
    LMHttpResponseRedirect = 307,
    LMHttpResponseFailed = 403,
    LMHttpResonseTimedOut = 408
} LMHttpResponseCode;

@protocol HttpManagerDelegate <NSObject>
@optional
- (void)httpRequestWithMethod:(NSString *)name completed:(ASIFormDataRequest *)request;

@end

@interface HttpManager : NSObject <ASIHTTPRequestDelegate>

@property (nonatomic, assign) id<HttpManagerDelegate> delegate;
@property (nonatomic, copy) NSString *method;
@property (nonatomic, copy) NSString *params;

- (id)initWithDelegate:(id<HttpManagerDelegate>) delegate;
- (void)httpGetWithMethod:(NSString *)name;
- (void)httpPostWithMethod:(NSString *)name;
- (void)httpPostWithMethod:(NSString *)name params:(NSString *)json;


@end
