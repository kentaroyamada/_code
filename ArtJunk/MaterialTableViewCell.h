//
//  MaterialTableViewCell.h
//  ArtJunk
//
//  Created by Brody Nelson on 19/03/12.
//  Copyright (c) 2012 Digital Projects Limited. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MaterialTableViewCell : UITableViewCell
@property (nonatomic, strong) IBOutlet UIImageView  * thumb;
@property (nonatomic, strong) IBOutlet UILabel * title;
@property (nonatomic, strong) IBOutlet UILabel * subtitle;
           


@end
