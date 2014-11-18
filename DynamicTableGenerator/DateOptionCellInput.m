//
//  DateOptionCellInput.m
//  TableViewDataCells
//
//  Created by Theodore Brown on 8/9/14.
//  Copyright (c) 2014 Theodore Brown. All rights reserved.
//

#import "DateOptionCellInput.h"

@implementation DateOptionCellInput

-(NSString*) cellType {
    return DTVCCellIdentifier_DateCell;
}

-(id) initDateInputForObject:(id) managedObject forReturnKey:(NSString*)newReturnKey withDefault:(NSDate*) defaultDate withTitle:(NSString*) cellTitle  inSection:(NSString*) newSectionHeader {
    self = [super init];
    NSLog(@"date created with object %@" , [managedObject description]);

    if (self) {
//          @{@"Identifier":@"DateCellID",
//            @"title":@"Select End Date",
//            @"return":@"endDate",
//            @"settings":@{@"defaultValue":self.endDate}}
        self = [self initType:DTVCCellIdentifier_DateCell forReturnKey:newReturnKey withTitle:cellTitle inSection:newSectionHeader];
        [self createDefaultValueForObject:managedObject orValue:defaultDate];

    }
    return self;
}



//- (void) createDefaultValueForObject:(id) managedObject orValue:(NSObject*) backupValue {
//    NSObject* newDefault = [managedObject valueForKey:self.returnKey] ?:backupValue;
//    [self setManagedObject:managedObject withDefaultValue:newDefault];
//}
//
//- (void) createDefaultValueForObject:(id)managedObject orValue:(id) backupValue {
//    NSObject* newDefault = [managedObject valueForKey:self.returnKey] ?:backupValue;
//    [self setManagedObject:managedObject withDefaultValue:newDefault];
//    
//}
#pragma mark - editable table cell delegate methods
- (void) cellDateDidChange: (NSIndexPath *) cellIndexPath :(NSDate*) newValue
{
    NSLog(@"%@ date set to %@", self.title, [newValue description]);
    
//    NSInteger sec = [cellIndexPath section];
//    NSInteger row = [cellIndexPath row];
    [self updateValue:newValue];
    [self updateContextWithValue:newValue];

    NSLog(@"%@ date set object is  %@", self.title, [self.observedObject description]);

    //    [self.resultDict setObject:value forKey:[self.optionsArray[sec][1][row] valueForKey:@"return"]];
    //    NSLog(@"Results at MainTable: %@", [self.resultDict description]);
}

@end
