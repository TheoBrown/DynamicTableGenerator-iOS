//
//  SegueCell.h
//  DynamicTableGenerator
//
//  Created by tpb on 12/20/14.
//  Copyright (c) 2014 Theodore Brown. All rights reserved.
//

#import "BaseCell.h"

@interface SegueCell : BaseCell
@property (strong, nonatomic) id destinationVC;

@property (nonatomic, strong) IBOutlet UIButton *cellButton;
- (IBAction)buttonPressed:(UIControl *)sender;

@end


