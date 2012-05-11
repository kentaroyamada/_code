//
//  PostJunkController.m
//  ArtJunk
//
//  Created by Brody Nelson on 27/02/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#define METERS_PER_MILE 1609.344

#import "PostJunkController.h"
#import "ASIFormDataRequest.h"


@implementation PostJunkController
@synthesize titleTextField = _titleTextField;
@synthesize mapView = _mapView;
@synthesize postButton;
@synthesize photo = _photo;
@synthesize locationManager;
@synthesize currentLocation = _currentLocation;
@synthesize artJunk = _artJunk;


//- (BOOL)textFieldShouldReturn:(UITextField *)textField {
//    [textField resignFirstResponder];
//    _artJunk.title = descriptionTextField.text;
//    return NO;
//}

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
    
    
    _artJunk = [[ArtJunk alloc] init];
    NSString * titleStr = _titleTextField.text;
    _artJunk.ajTitle = titleStr;
    _artJunk.coordinate = _currentLocation.coordinate;

   [_mapView addAnnotation:_artJunk];       
    
    
}




- (void)viewDidUnload
{
    [locationManager stopUpdatingLocation];
    [self setTitleTextField:nil];
    [self setMapView:nil];
    [self setPostButton:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark Core Location 

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
    _currentLocation = newLocation;
    
    _artJunk.coordinate = newLocation.coordinate;
    
     
    
    // 2
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(_currentLocation.coordinate, 0.5*METERS_PER_MILE, 0.5*METERS_PER_MILE);
    // 3
    MKCoordinateRegion adjustedRegion = [_mapView regionThatFits:viewRegion];                
    // 4
    [_mapView setRegion:adjustedRegion animated:YES];
    
    
    if(newLocation.horizontalAccuracy <= 100.0f) { [locationManager stopUpdatingLocation]; }
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

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation {

    static NSString *identifier = @"ArtJunk";   
    if ([annotation isKindOfClass:[ArtJunk class]]) {
        
        
        MKPinAnnotationView *annotationView = (MKPinAnnotationView *) [_mapView dequeueReusableAnnotationViewWithIdentifier:identifier];
        if (annotationView == nil) {
            annotationView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identifier];
        } else {
            annotationView.annotation = annotation;
        }
        
    
        annotationView.pinColor = MKPinAnnotationColorPurple;
        annotationView.enabled = YES;
        annotationView.canShowCallout = YES;
        UIImageView * iv = [[UIImageView alloc] initWithImage:_photo];
        annotationView.leftCalloutAccessoryView = iv;
        return annotationView;
       
}
    return nil;
}

-(void) sendRequest {
    
    
    [factory upload:_artJunk];
    
    NSURL *url = [NSURL URLWithString:@"http://www.brodynelson.com/artjunk/"];
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    [request setPostValue:_artJunk.title forKey:@"description"];
    [request setPostValue:_artJunk.datePosted forKey:@"datePosted"];
    [request setDelegate:self];
    [request startAsynchronous];
    

    
}
- (IBAction)postArtJunk:(id)sender {
    
    MBProgressHUD * HUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
	
    HUD.delegate = self;
    HUD.labelText = @"Loading";
    HUD.detailsLabelText = @"sending data";
	HUD.square = YES;
	
    [HUD showWhileExecuting:@selector(sendRequest) onTarget:self withObject:nil animated:YES];
    

    
}
    
@end
