//
//  WebLinkCell.h
//  DynamicTableGenerator
//
//  Created by tpb on 2/3/15.
//  Copyright (c) 2015 Theodore Brown. All rights reserved.
//

#import "BaseCell.h"

/**
 *  Simple Cell to open URL when cell is pressed
 */
@interface WebLinkCell : BaseCell
@property (nonatomic, strong) IBOutlet UILabel *authorLabel;
@property (nonatomic, strong) IBOutlet UILabel *assetLabel;
@property (nonatomic, strong) IBOutlet UILabel *descriptionLabel;
@property (nonatomic, strong) NSURL *linkURL;

@property (nonatomic, strong) IBOutlet UIButton *cellButton;
- (IBAction)buttonPressed:(UIControl *)sender;

@end
