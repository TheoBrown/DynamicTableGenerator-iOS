//
//  BaseOptionCellInput.h
//  TableViewDataCells
//
//  Created by Theodore Brown on 8/9/14.
//  Copyright (c) 2014 Theodore Brown. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseCell.h"

#import "TableCellEditableProtocol.h"
#import "DynamicTableViewConstants.h"


/**
 *  An Object/Controller that is used to initialize each corresponding `BaseCell` 
 * This and its subclasses are stored in an array and passed to `DynamicTableCellManager` to create the TableViewCells
 */
@interface BaseOptionCellInput : NSObject <TableCellEditable>

//table table view cell attributes
@property (strong, nonatomic) NSString* sectionHeader;
@property (strong, nonatomic) NSString* identifier;
@property (strong, nonatomic) NSString* title; // title to be listed by the cell

//data manaagment
@property (strong, nonatomic) NSString* returnKey; // key to be used to save and look up th value obect
@property (strong, nonatomic) id value;
@property (strong, nonatomic) id defaultValue;
@property (strong, nonatomic) id observedObject;

@property (nonatomic) NSInteger cellPosition; //not used

//DTVC setup
@property (nonatomic,strong) NSNumber * cellInputFormatType;
- (void) defineCellInputFormatType:(NSNumber*) newCellInputFormatType;

- (id) initType:(NSString*) optionType forReturnKey:(NSString*) newReturnKey withTitle:(NSString*) titleString inSection:(NSString*) sectionHeaderString;
-(id) initInputType:(NSString*) optionType forObject:(id) managedObject forReturnKey:(NSString*)newReturnKey withTitle:(NSString*) cellTitle  inSection:(NSString*) newSectionHeader;
-(id) initInputClassforObject:(id) managedObject forReturnKey:(NSString*)newReturnKey withTitle:(NSString*) cellTitle  inSection:(NSString*) newSectionHeader;

//save CoreData
- (void) setManagedObject:(id) managedObject;
- (void) setManagedObject:(id) managedObject withDefaultValue:(NSObject*) defaultvalue;
- (void) createDefaultValueForObject:(id)managedObject orValue:(id) backupValue;
//save NSObject
- (void) updateValue:(id) newValue;
- (void) updateContextWithValue:(NSObject*) newValue;
- (void) saveObjectContext;

//debug
- (void) printDebug;
- (void) debugClassTypes;

//UI info
-(NSObject*) getDisplayValue;
-(NSString*) cellType;// each option input type returns its own unique id (== cell Identifier from table VC)
@end
