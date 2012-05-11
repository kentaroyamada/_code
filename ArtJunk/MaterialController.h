//
//  MaterialController.h
//  ArtJunk
//
//  Created by Brody Nelson on 19/03/12.
//  Copyright (c) 2012 Digital Projects Limited. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MaterialTableViewCell.h"
#import "Material.h"
#import "ArtJunk.h"

@interface MaterialController : UIViewController <UITableViewDataSource, UITableViewDelegate> 
@property (nonatomic, strong) NSMutableArray * materials;
@property (nonatomic, strong) UIImage * photo;
@property (strong, nonatomic) IBOutlet UIImageView *junkImageView;
@property (strong, nonatomic) ArtJunk * artjunk;
@end
