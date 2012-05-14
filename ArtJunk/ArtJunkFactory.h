//
//  ArtJunkFactory.h
//  ArtJunk
//
//  Created by Brody Nelson on 8/05/12.
//  Copyright (c) 2012 Digital Projects Limited. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HttpManager.h"

#define kURLArtJunkGet           @"http://www.brodynelson.com/artjunk/get"
#define kURLArtJunkSave          @"http://www.brodynelson.com/artjunk/submit"
#define kBgQueue dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0) 
#define methodSave               @"submit"


@class ArtJunk;
@class Material;

@protocol ArtJunkFactoryDelegate <NSObject>
@optional
-(void) artJunkDidDownload:(NSMutableArray *)artjunks;
-(void) artJunkDidSave:(BOOL)success;
@end

@interface ArtJunkFactory : NSObject <HttpManagerDelegate> {
@private
    HttpManager *httpManager;
    
    
}

@property (nonatomic, assign) id<ArtJunkFactoryDelegate>delegate;

- (id)initWithDelegate:(id<ArtJunkFactoryDelegate>)delegate;
- (void)download;
- (void)upload:(ArtJunk*)artjunk;


@end
