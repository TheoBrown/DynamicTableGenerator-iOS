//
//  ButtonOptionCellInput.h
//  TableViewDataCells
//
//  Created by Theodore Brown on 8/9/14.
//  Copyright (c) 2014 Theodore Brown. All rights reserved.
//

#import "BaseOptionCellInput.h"
#import "DynamicTableViewCellOptionsPickerViewController.h"
//#import "CellWithButton.h"

@interface ButtonOptionCellInput : BaseOptionCellInput

-(id) initOptionInputForObject:(id) managedObject forReturnKey:(NSString*)newReturnKey withTitle:(NSString*) cellTitle withOptions:(NSArray*) optionsArray inSection:(NSString*) newSectionHeader;

-(id) initOptionInputForObject:(id) managedObject forReturnKey:(NSString*)newReturnKey withTitle:(NSString*) cellTitle withOptions:(NSArray*) optionsArray withDefault:(NSNumber*) defaultSelection  inSection:(NSString*) newSectionHeader;

@property (strong, nonatomic) NSArray* optionsArray;

@end
