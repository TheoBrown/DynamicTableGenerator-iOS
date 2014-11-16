//
//  SwitchOptionCellInput.h
//  DynamicTableGenerator
//
//  Created by tpb on 11/14/14.
//  Copyright (c) 2014 Theodore Brown. All rights reserved.
//

#import "BaseOptionCellInput.h"

@interface SwitchOptionCellInput : BaseOptionCellInput <TableCellEditable>


-(id) initSwitchInputForObject:(id) managedObject forReturnKey:(NSString*) newReturnKey withTitle:(NSString*) cellTitle  inSection:(NSString*) newSectionHeader;
-(id) initSwitchInputForObject:(id) managedObject forReturnKey:(NSString*)newReturnKey withTitle:(NSString*) cellTitle withDefault:(BOOL) defaultBool  inSection:(NSString*) newSectionHeader;


-(BOOL) getDisplayValue;
@end
