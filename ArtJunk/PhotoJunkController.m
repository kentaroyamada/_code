//
//  PhotoJunkController.m
//  ArtJunk
//
//  Created by Brody Nelson on 19/03/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "PhotoJunkController.h"

@implementation PhotoJunkController

@synthesize photoButton = _photoButton;
@synthesize imagePickerController = _imagePickerController;

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
    _imagePickerController = [[UIImagePickerController alloc] init];
    _imagePickerController.delegate = self;
    
       
}


- (void)viewDidUnload
{
    [self setPhotoButton:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
    
    [self dismissModalViewControllerAnimated:NO];
    MaterialController *mc = [self.storyboard instantiateViewControllerWithIdentifier:@"MaterialController"];
    
	mc.photo = [info valueForKey:UIImagePickerControllerOriginalImage];
    [self.navigationController pushViewController:mc animated:YES];
    
    
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self setModalTransitionStyle:UIModalTransitionStyleFlipHorizontal];
    [self dismissModalViewControllerAnimated:YES];
    
}



- (IBAction)takePhoto:(id)sender {
    
    _imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
    [self setModalTransitionStyle:UIModalTransitionStyleFlipHorizontal];
    [self presentModalViewController:_imagePickerController animated:NO];

}
@end
