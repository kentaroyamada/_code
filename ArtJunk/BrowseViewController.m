//
//  BrowseViewController.m
//  ArtJunk
//
//  Created by Brody Nelson on 8/05/12.
//  Copyright (c) 2012 Digital Projects Limited. All rights reserved.
//

#import "BrowseViewController.h"
#import "DataViewController.h"

@interface BrowseViewController ( private )

-(void)initPageView;

@end

@implementation BrowseViewController ( private )

-(void) initPageView {
    self.pageViewController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStylePageCurl navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    self.pageViewController.delegate = self;
    
    DataViewController *startingViewController = [self.modelController viewControllerAtIndex:0 storyboard:self.storyboard];
    NSArray *viewControllers = [NSArray arrayWithObject:startingViewController];
    [self.pageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:NULL];
    
    self.pageViewController.dataSource = self.modelController;
    
    [self addChildViewController:self.pageViewController];
    [self.view addSubview:self.pageViewController.view];
    
    // Set the page view controller's bounds using an inset rect so that self's view is visible around the edges of the pages.
    CGRect pageViewRect = self.view.bounds;
    self.pageViewController.view.frame = pageViewRect;
    
    [self.pageViewController didMoveToParentViewController:self];    
    
    // Add the page view controller's gesture recognizers to the book view controller's view so that the gestures are started more easily.
    self.view.gestureRecognizers = self.pageViewController.gestureRecognizers;

}

@end
@implementation BrowseViewController
@synthesize pageViewController,artjunks;
@synthesize modelController = _modelController;
@synthesize currentLocation, locationManager;

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

- (void)viewDidLoad
{
    [super viewDidLoad];

    //Init aj array
    self.artjunks = [[NSMutableArray alloc] init];
    

    //Start detecting location
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    [locationManager startUpdatingLocation];

    // Initialize the progress status with a "connecting" status
    progressHUD = [[MBProgressHUD alloc] initWithView:self.view];
    progressHUD.delegate = self;
    progressHUD.dimBackground = NO;
    progressHUD.labelText = @"Searching for nearby Artjunk";
    
    [self.view addSubview:progressHUD];
    [progressHUD show:YES];
    [self downloadArtjunks];
       
}

- (void) viewWillAppear:(BOOL)animated {
    
    

    
    
}
- (void)viewDidUnload
{
    [locationManager stopUpdatingLocation];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


- (ModelController *)modelController
{
    /*
     Return the model controller object, creating it if necessary.
     In more complex implementations, the model controller may be passed to the view controller.
     */
    if (!_modelController) {
        //change to array
        _modelController = [[ModelController alloc] initWithArray:self.artjunks];
    }
    return _modelController;
}

#pragma mark - UIPageViewController delegate methods


- (UIPageViewControllerSpineLocation)pageViewController:(UIPageViewController *)pageViewController spineLocationForInterfaceOrientation:(UIInterfaceOrientation)orientation
{
    // Set the spine position to "min" and the page view controller's view controllers array to contain just one view controller. Setting the spine position to 'UIPageViewControllerSpineLocationMid' in landscape orientation sets the doubleSided property to YES, so set it to NO here.
    UIViewController *currentViewController = [self.pageViewController.viewControllers objectAtIndex:0];
    NSArray *viewControllers = [NSArray arrayWithObject:currentViewController];
    [self.pageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:NULL];
    
    self.pageViewController.doubleSided = NO;
    return UIPageViewControllerSpineLocationMin;
}



-(void) downloadArtjunks {
    
    NSNumber * longitude = [NSNumber numberWithDouble:self.currentLocation.coordinate.longitude];
    NSNumber * latitude = [NSNumber numberWithDouble:self.currentLocation.coordinate.latitude];
    
    NSURL *url = [NSURL URLWithString:@"http://www.brodynelson.com/artjunk/get/index.php"];
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    [request setPostValue:longitude forKey:@"longitude"];
    [request setPostValue:latitude forKey:@"latitude"];
    [request setDelegate:self];
    [request startAsynchronous];
    


}


- (void)requestFinished:(ASIHTTPRequest *)request
{    
    NSError * error;
    
    if (request.responseStatusCode == 200) {
        NSDictionary* json = [NSJSONSerialization 
                              JSONObjectWithData:[request responseData] //1
                              
                              options:kNilOptions 
                              error:&error];
        
        // Parse JSON, create artjunk objects, return array of aj
        for (NSDictionary * artjunkDic in json) {
            ArtJunk * anArtJunk = [[ArtJunk alloc] initWithContentsOfDictionary:artjunkDic];
            [self.artjunks addObject:anArtJunk];
        }
    }
    [self initPageView];
    [progressHUD hide:YES];
 
}

- (void)requestFailed:(ASIHTTPRequest *)request
{    
    NSError *error = [request error];
    NSLog(@"Error:%@",error);
}


#pragma mark Core Location 

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
    currentLocation = newLocation;
        
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

@end
