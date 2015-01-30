//
//  SimpleActionSheetOptionCellInput.m
//  DynamicTableGenerator
//
//  Created by tpb on 1/27/15.
//  Copyright (c) 2015 Theodore Brown. All rights reserved.
//

#import "SimpleActionSheetOptionCellInput.h"

@implementation SimpleActionSheetOptionCellInput

-(NSString*) cellType {
    return DTVCCellIdentifier_SimpleActionCell;
}

-(id) initSimpleActionSheetInputForObject:(id) managedObject forReturnKey:(NSString*)newReturnKey withOptions:(NSArray*) optionsArray withTitle:(NSString*) cellTitle  inSection:(NSString*) newSectionHeader{
    self = [super init];
    NSLog(@"action shee created with object %@" , [managedObject description]);
    if (self) {
        self = [self initType:DTVCCellIdentifier_SimpleActionCell forReturnKey:newReturnKey withTitle:cellTitle inSection:newSectionHeader];
        self.optionsArray=optionsArray;
        [self defineCellInputFormatType:[NSNumber numberWithInt:DTVCInputType_SimpleActionSheetCell_String]];
        [self createDefaultValueForObject:managedObject orValue:self.optionsArray[0]];

    }
    return self;
}
-(id) initSimpleActionSheetInputForObject:(id) managedObject forReturnKey:(NSString*)newReturnKey withDefault:(NSString*) defaultValue withOptions:(NSArray*) optionsArray withTitle:(NSString*) cellTitle  inSection:(NSString*) newSectionHeader{
    self = [super init];
    NSLog(@"action shee created with object %@" , [managedObject description]);
    if (self) {
        self = [self initType:DTVCCellIdentifier_SimpleActionCell forReturnKey:newReturnKey withTitle:cellTitle inSection:newSectionHeader];
        self.optionsArray=optionsArray;
        [self defineCellInputFormatType:[NSNumber numberWithInt:DTVCInputType_SimpleActionSheetCell_String]];
        [self createDefaultValueForObject:managedObject orValue:defaultValue];
        
    }
    return self;
}
-(id) initSimpleActionSheetInputForObject:(id) managedObject forReturnKey:(NSString*)newReturnKey withOptions:(NSArray*) optionsArray resultMap:(NSDictionary*) resultMap withTitle:(NSString*) cellTitle  inSection:(NSString*) newSectionHeader{
    self = [super init];
    NSLog(@"action shee created with object %@" , [managedObject description]);
    
    if (self) {
        self = [self initType:DTVCCellIdentifier_SimpleActionCell forReturnKey:newReturnKey withTitle:cellTitle inSection:newSectionHeader];
        self.optionsArray=optionsArray;
        self.resultsMap=resultMap;
        [self defineCellInputFormatType:[NSNumber numberWithInt:DTVCInputType_SimpleActionSheetCell_DictMap]];
    }
    return self;
}

#pragma mark - editable table cell delegate methods

-(void) cellSimpleActionSheetDidChange:(NSIndexPath *) cellIndexPath withIndex:(NSInteger)optionIndex{
    NSObject *newValue = [NSNumber numberWithInteger:optionIndex];
    [self updateValue:newValue];
    [self saveObjectContext];
}
-(void) cellSimpleActionSheetDidChange:(NSIndexPath *) cellIndexPath withString:(NSString*)optionString{
    NSLog(@"action sheet call to update value %@ %@",self.title,optionString);
    [self updateValue:optionString];
    [self updateContextWithValue:optionString];

    [self saveObjectContext];
}
-(void) cellSimpleActionSheetDidChange:(NSIndexPath *) cellIndexPath withObject:(NSObject*)optionObject{
    [self updateValue:optionObject];
    [self updateContextWithValue:optionObject];
    [self saveObjectContext];
}
@end
