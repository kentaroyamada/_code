//
//  TitleExpiryViewController.m
//  ArtJunk
//
//  Created by Brody Nelson on 10/05/12.
//  Copyright (c) 2012 Digital Projects Limited. All rights reserved.
//

#import "TitleExpiryViewController.h"

@implementation TitleExpiryViewController
@synthesize expirySlider;
@synthesize titleTextField;
@synthesize artjunk;
@synthesize locationManager;
@synthesize currentLocation;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    [locationManager startUpdatingLocation];

    factory = [[ArtJunkFactory alloc] initWithDelegate:self];
    
    
}

- (void)viewDidUnload
{
    [locationManager stopUpdatingLocation];
    [self setExpirySlider:nil];
    [self setTitleTextField:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - TextField delegate


-(BOOL)textFieldShouldReturn:(UITextField*)textField;
{
    [textField resignFirstResponder];
    return NO;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    self.artjunk.ajTitle = textField.text;
    return YES;
}

#pragma mark Core Location 

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
    currentLocation = newLocation;
    
    artjunk.coordinate = newLocation.coordinate;
    
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    if(error.code == kCLErrorDenied) {
        [locationManager stopUpdatingLocation];
    } else if(error.code == kCLErrorLocationUnknown) {
        // retry
    } else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error retrieving location"
                                                        message:[error description]
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }
}



#pragma mark ArtJunkFactory

-(void) artJunkDidSave:(BOOL)success {
    
    

    
    if (success) {
        //notify user save successful 
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"ArtJunk Uploaded"
                                                        message:
                              @"The ArtJunk was saved successfully." 
                                                       delegate:nil
                                              cancelButtonTitle:NSLocalizedString(@"Ok", @"Ok") 
                                            otherButtonTitles:nil, nil];
        [alert show];
        [self.navigationController popToRootViewControllerAnimated:YES];
    
    }
    else { //epic fail
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"ArtJunk Failed to Upload"
                                                        message:
                              @"Whoops something went wrong. Try again later" 
                                                       delegate:nil
                                              cancelButtonTitle:NSLocalizedString(@"Ok", @"Ok") 
                                              otherButtonTitles:nil, nil];
        [alert show];

    }
}


- (IBAction)submitArtjunk:(id)sender {
    
    [factory upload:self.artjunk];

    
}

- (IBAction)cancelArtjunk:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}
@end
