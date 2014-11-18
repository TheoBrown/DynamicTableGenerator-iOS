//
//  SegmentOptionCellInput.m
//  TableViewDataCells
//
//  Created by Theodore Brown on 8/9/14.
//  Copyright (c) 2014 Theodore Brown. All rights reserved.
//

#import "SegmentOptionCellInput.h"

@implementation SegmentOptionCellInput
@synthesize segmentTitles, segmentValues, selectedSegment;

-(NSString*) cellType {
    return DTVCCellType_SegmentCell;
}

-(id) initSegmentInputForObject:(id) managedObject forReturnKey:(NSString*) newReturnKey withTitle:(NSString*) cellTitle  inSection:(NSString*) newSectionHeader {
    self = [super init];
    if (self) {
        self = [self initType:DTVCCellIdentifier_SegmentCell forReturnKey:newReturnKey withTitle:cellTitle inSection:newSectionHeader];
        [self setManagedObject:managedObject];
    }
    return self;
}

-(id) initSegmentInputForObject:(id) managedObject forReturnKey:(NSString*) newReturnKey withTitle:(NSString*) cellTitle withSegmentTitles:(NSArray*) segmentTitleArray andSegmentValues:(NSArray*) segmentValueArray andDefaultSelection:(NSInteger) selectedCell inSection:(NSString*) newSectionHeader {
    if (!self) {
        self = [self initType:DTVCCellIdentifier_SegmentCell forReturnKey:newReturnKey withTitle:cellTitle inSection:newSectionHeader];
        self.segmentValues = segmentValueArray;
        self.segmentTitles = segmentTitleArray;
        self.observedObject = managedObject;
        self.selectedSegment = selectedCell;

    }
    return self;
}

#pragma mark - editable table cell delegate methods
- (void) cellDateSegmentDidChange: (NSIndexPath *) cellIndexPath startDate:(NSDate*) startDate endDate:(NSDate*)endDate{
    NSLog(@"Dates did change from %@ to %@",[startDate description], [endDate description]);
    NSInteger sec = [cellIndexPath section];
    NSInteger row = [cellIndexPath row];
    NSIndexPath *startindexPath = [NSIndexPath indexPathForRow:(row-2) inSection:sec];
    NSIndexPath *endindexPath = [NSIndexPath indexPathForRow:(row-1) inSection:sec];
    NSLog(@"Seting date display from Switch");
//    CellWithDate *startDateCell = (CellWithDate *)[self.tableView cellForRowAtIndexPath:startindexPath];
//    CellWithDate *endDateCell = (CellWithDate *)[self.tableView cellForRowAtIndexPath:endindexPath];
//    [startDateCell.dateButon setTitle:[startDateCell stringFromDate:startDate] forState:UIControlStateNormal];
//    [startDateCell.dateButon setTitle:[endDateCell stringFromDate:endDate] forState:UIControlStateNormal];
    NSLog(@"Start and End Date set");
    
    //    [self.resultDict setObject:startDate forKey:[self.optionsArray[sec][1][row] valueForKey:@"return"][0]];
    //    [self.resultDict setObject:endDate forKey:[self.optionsArray[sec][1][row] valueForKey:@"return"][1]];
    //    [[[SharedData getInstance] settings] setObject:startDate forKey:[self.optionsArray[sec][1][row] valueForKey:@"return"][0]];
    //    [[[SharedData getInstance] settings] setObject:endDate forKey:[self.optionsArray[sec][1][row] valueForKey:@"return"][1]];
}
@end
