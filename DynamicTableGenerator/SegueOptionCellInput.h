//
//  SegueOptionCellInput.h
//  DynamicTableGenerator
//
//  Created by tpb on 12/20/14.
//  Copyright (c) 2014 Theodore Brown. All rights reserved.
//

#import "BaseOptionCellInput.h"

@interface SegueOptionCellInput : BaseOptionCellInput
-(id) initSegueOptionCellInputForVC:(id) viewController withTitle:(NSString*) cellTitle  inSection:(NSString*) newSectionHeader;

@property (strong, nonatomic) id destinationVC;

@end
