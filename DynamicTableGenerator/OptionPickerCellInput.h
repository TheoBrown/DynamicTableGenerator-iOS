//
//  OptionPickerCellInput.h
//  DynamicTableGenerator
//
//  Created by Theodore Brown on 3/3/15.
//  Copyright (c) 2015 Theodore Brown. All rights reserved.
//

#import "BaseOptionCellInput.h"
#import "DynamicTableViewCellOptionsPickerViewController.h"

@interface OptionPickerCellInput : BaseOptionCellInput
-(id) initOptionInputForObject:(id) managedObject forReturnKey:(NSString*)newReturnKey withTitle:(NSString*) cellTitle withOptions:(NSArray*) optionsArray inSection:(NSString*) newSectionHeader;

-(id) initOptionInputForObject:(id) managedObject forReturnKey:(NSString*)newReturnKey withTitle:(NSString*) cellTitle withOptions:(NSArray*) optionsArray withDefault:(NSNumber*) defaultSelection  inSection:(NSString*) newSectionHeader;

@property (strong, nonatomic) NSArray* optionsArray;
@end
