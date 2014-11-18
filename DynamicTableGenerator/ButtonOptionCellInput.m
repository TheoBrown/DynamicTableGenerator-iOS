//
//  ButtonOptionCellInput.m
//  TableViewDataCells
//
//  Created by Theodore Brown on 8/9/14.
//  Copyright (c) 2014 Theodore Brown. All rights reserved.
//

#import "ButtonOptionCellInput.h"

@implementation ButtonOptionCellInput

-(NSString*) cellType {
    return DTVCCellIdentifier_ButtonCell;
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
