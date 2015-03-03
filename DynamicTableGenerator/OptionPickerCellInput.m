//
//  OptionPickerCellInput.m
//  DynamicTableGenerator
//
//  Created by Theodore Brown on 3/3/15.
//  Copyright (c) 2015 Theodore Brown. All rights reserved.
//

#import "OptionPickerCellInput.h"

@implementation OptionPickerCellInput
-(NSString*) cellType {
    return DTVCCellIdentifier_OptionPickerCell;
}

-(id) initOptionInputForObject:(id) managedObject forReturnKey:(NSString*)newReturnKey withTitle:(NSString*) cellTitle withOptions:(NSArray*) optionsArray inSection:(NSString*) newSectionHeader {
    self = [super init];
    
    if (self) {
        
        self = [self initType:[self cellType] forReturnKey:newReturnKey withTitle:cellTitle inSection:newSectionHeader];
        
        [self createDefaultValueForObject:managedObject orValue:optionsArray];
        self.optionsArray = optionsArray;
    }
    return self;
}


#pragma mark - editable table cell delegate methods

-(void) cellButtonresultsUpdated:(NSIndexPath *) cellIndexPath withResults:(NSArray *)resultArray{
    
    [self updateValue:resultArray];
    [self updateContextWithValue:resultArray];
    
    //    [self.resultDict setObject:resultArray forKey:[self.optionsArray[sec][1][row] valueForKey:@"return"]];
    //    [[[SharedData getInstance] settings] setObject:resultArray forKey:[self.optionsArray[sec][1][row] valueForKey:@"return"]];
}
@end
