//
//  SwitchOptionCellInput.h
//  DynamicTableGenerator
//
//  Created by tpb on 11/14/14.
//  Copyright (c) 2014 Theodore Brown. All rights reserved.
//

#import "BaseOptionCellInput.h"

/**
 Simple Cell that shows a UISwitch to set a bool
 */
@interface SwitchOptionCellInput : BaseOptionCellInput


-(id) initSwitchInputForObject:(id) managedObject forReturnKey:(NSString*)newReturnKey withTitle:(NSString*) cellTitle withDefault:(BOOL) defaultBool  inSection:(NSString*) newSectionHeader;


-(BOOL) getDisplayValue;
@end
