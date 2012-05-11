//
//  DataViewController.m
//  Top10
//
//  Created by Brody Nelson on 26/01/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//




#import "DataViewController.h"


@implementation DataViewController

@synthesize titleLabel, distanceLabel, ajImage, dataObject, materialLabel, artjunk;


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
 
    self.artjunk = (ArtJunk*)self.dataObject;
    self.titleLabel.text = self.artjunk.ajTitle;
    self.ajImage.image = self.artjunk.ajImage;
       
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end
