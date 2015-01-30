//
//  SimpleActionSheetOptionCellInput.h
//  DynamicTableGenerator
//
//  Created by tpb on 1/27/15.
//  Copyright (c) 2015 Theodore Brown. All rights reserved.
//

#import "BaseOptionCellInput.h"

@interface SimpleActionSheetOptionCellInput : BaseOptionCellInput

-(id) initSimpleActionSheetInputForObject:(id) managedObject forReturnKey:(NSString*)newReturnKey withOptions:(NSArray*) optionsArray withTitle:(NSString*) cellTitle  inSection:(NSString*) newSectionHeader;
-(id) initSimpleActionSheetInputForObject:(id) managedObject forReturnKey:(NSString*)newReturnKey withDefault:(NSString*) defaultValue withOptions:(NSArray*) optionsArray withTitle:(NSString*) cellTitle  inSection:(NSString*) newSectionHeader;
-(id) initSimpleActionSheetInputForObject:(id) managedObject forReturnKey:(NSString*)newReturnKey withOptions:(NSArray*) optionsArray resultMap:(NSDictionary*) resultMap withTitle:(NSString*) cellTitle  inSection:(NSString*) newSectionHeader;


@property (nonatomic, retain) NSString *actionSheetTitle; //displayed label for action sheet
@property (strong, nonatomic) NSArray* optionsArray; //an array of strings that will be displayed in the action sheet
@property (strong, nonatomic) NSDictionary* resultsMap;

@end
