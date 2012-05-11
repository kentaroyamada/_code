//
//  MaterialController.m
//  ArtJunk
//
//  Created by Brody Nelson on 19/03/12.
//  Copyright (c) 2012 Digital Projects Limited. All rights reserved.
//

#import "MaterialController.h"
#import "TitleExpiryViewController.h"

@implementation MaterialController

@synthesize photo = _photo;
@synthesize junkImageView = _junkImageView;
@synthesize materials = _materials;
@synthesize artjunk = _artjunk;

#pragma mark - UIStoryBoardSegue Method

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"titleExpirySegue"]) {
        // Set the artjunk for the modal thats about to present

		TitleExpiryViewController *titleExpiryViewController = segue.destinationViewController;
		titleExpiryViewController.artjunk = _artjunk;
    } 
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
//        self.navigationItem.title = NSLocalizedString(@"Accounts", @"Accounts");
//        
//        self.navigationController.navigationBar.tintColor = [UIColor LMNavigationGreen];
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
    _artjunk = [[ArtJunk alloc] init];
    _artjunk.ajImage = _photo;
    
    
    _materials = [[NSMutableArray alloc] initWithCapacity:5];
    
    Material  *material = [[Material alloc] init];
	material.name = @"WOOD";
	material.description = @"Ken likes small boys";
	material.thumb = [UIImage imageNamed:@"thumb1.png"];
	[_materials addObject:material];
    
    material = [[Material alloc] init];
    material.name = @"METAL";
	material.description = @"Second Line of Text";
	material.thumb = [UIImage imageNamed:@"thumb1.png"];
	[_materials addObject:material];
    
    material = [[Material alloc] init];
    material.name = @"CONCRETE";
	material.description = @"Second Line of Text";
	material.thumb = [UIImage imageNamed:@"thumb1.png"];
	[_materials addObject:material];

    material = [[Material alloc] init];
    material.name = @"PLASTIC";
	material.description = @"Second Line of Text";
	material.thumb = [UIImage imageNamed:@"thumb1.png"];
	[_materials addObject:material];
    
    material = [[Material alloc] init];
    material.name = @"PAPER";
	material.description = @"Second Line of Text";
	material.thumb = [UIImage imageNamed:@"thumb1.png"];
	[_materials addObject:material];
    
    _junkImageView.image = _photo;
    
    }

- (void)viewDidUnload
{
    [self setJunkImageView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
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
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    // Return the number of rows in the section.
    return [self.materials count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MaterialTableViewCell *cell = (MaterialTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"MaterialTableViewCell"];
    
    Material  *material = [self.materials objectAtIndex:indexPath.row];
	cell.title.text = material.name;
	cell.subtitle.text = material.description;
	cell.thumb.image = material.thumb;

    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

@end
