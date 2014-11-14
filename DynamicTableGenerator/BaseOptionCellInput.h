//
//  BaseOptionCellInput.h
//  TableViewDataCells
//
//  Created by Theodore Brown on 8/9/14.
//  Copyright (c) 2014 Theodore Brown. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TableCellEditableProtocol.h"

extern NSString * const dateCell;
extern NSString * const sliderCell;
extern NSString * const buttonCell;
extern NSString * const actionCell;
extern NSString * const textCell;
extern NSString * const numberCell;
extern NSString * const switchCell;
extern NSString * const segmentCell;

@interface BaseOptionCellInput : NSObject

@property (strong, nonatomic) NSString* sectionHeader;
@property (strong, nonatomic) NSString* identifier;
@property (strong, nonatomic) NSString* title; // title to be listed by the cell
@property (strong, nonatomic) NSString* returnKey; // key to be used to save and look up th value obect

@property (nonatomic) NSInteger cellPosition;

@property (strong, nonatomic) id value;
@property (strong, nonatomic) id defaultValue;
@property (strong, nonatomic) id observedObject;

- (id) initType:(NSString*) optionType forReturnKey:(NSString*) newReturnKey withTitle:(NSString*) titleString inSection:(NSString*) sectionHeaderString;
- (void) setManagedObject:(id) managedObject;

- (void) updateContextWithValue:(NSObject*) newValue;

- (void) setManagedObject:(id) managedObject withDefaultValue:(NSObject*) defaultvalue;
- (void) printDebug;
- (void) debugClassTypes;

- (void) updateValue:(id) newValue;
- (void) saveObjectContext;

@end
