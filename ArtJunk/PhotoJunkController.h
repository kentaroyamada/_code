//
//  PhotoJunkController.h
//  ArtJunk
//
//  Created by Brody Nelson on 19/03/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MaterialController.h"

@interface PhotoJunkController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate>


@property (nonatomic, strong) UIImagePickerController *imagePickerController;
@end
