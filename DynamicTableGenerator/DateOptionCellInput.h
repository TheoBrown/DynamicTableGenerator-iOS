//
//  DateOptionCellInput.h
//  TableViewDataCells
//
//  Created by Theodore Brown on 8/9/14.
//  Copyright (c) 2014 Theodore Brown. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseOptionCellInput.h"

//#import "CellWithDate.h"

@interface DateOptionCellInput : BaseOptionCellInput <TableCellEditable>

-(id) initDateInputForObject:(id) managedObject forReturnKey:(NSString*)newReturnKey withTitle:(NSString*) cellTitle  inSection:(NSString*) newSectionHeader;
-(id) initDateInputForObject:(id) managedObject forReturnKey:(NSString*)newReturnKey withDefault:(NSDate*) defaultDate withTitle:(NSString*) cellTitle  inSection:(NSString*) newSectionHeader;

- (void) setDateCellType:(NSString*) dateTypeString;

@property (strong, nonatomic) NSString *dateCellTypeString;

@end
