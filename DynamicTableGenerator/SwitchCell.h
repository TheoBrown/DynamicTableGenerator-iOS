//
//  SwitchCell.h
//  DynamicTableGenerator
//
//  Created by tpb on 11/14/14.
//  Copyright (c) 2014 Theodore Brown. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BaseCell.h"

@interface SwitchCell : BaseCell

@property (nonatomic, strong) IBOutlet UISwitch *cellSwitch;

-(IBAction)switchDidChange:(id)sender;

@end
