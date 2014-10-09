//
//  ButtonOptionCellInput.m
//  TableViewDataCells
//
//  Created by Theodore Brown on 8/9/14.
//  Copyright (c) 2014 Theodore Brown. All rights reserved.
//

#import "ButtonOptionCellInput.h"

@implementation ButtonOptionCellInput



#pragma mark - editable table cell delegate methods

-(void) cellButtonresultsUpdated:(NSIndexPath *) cellIndexPath withResults:(NSArray *)resultArray{
    
    NSInteger sec = [cellIndexPath section];
    NSInteger row = [cellIndexPath row];
    
    
    //    [self.resultDict setObject:resultArray forKey:[self.optionsArray[sec][1][row] valueForKey:@"return"]];
    //    [[[SharedData getInstance] settings] setObject:resultArray forKey:[self.optionsArray[sec][1][row] valueForKey:@"return"]];
}
@end
