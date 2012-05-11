//
//  ModelController.h
//  Top10
//
//  Created by Brody Nelson on 26/01/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class DataViewController;

@interface ModelController : NSObject <UIPageViewControllerDataSource>
- (DataViewController *)viewControllerAtIndex:(NSUInteger)index storyboard:(UIStoryboard *)storyboard;
- (NSUInteger)indexOfViewController:(DataViewController *)viewController;
- (id)initWithArray:(NSMutableArray *)theArray;

@end
