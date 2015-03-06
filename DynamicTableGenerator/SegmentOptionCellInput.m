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
    return DTVCCellIdentifier_SegmentCell;
}



-(id) initSegmentInputForObject:(id) managedObject forReturnKey:(NSString*) newReturnKey withTitle:(NSString*) cellTitle withSegmentTitles:(NSArray*) segmentTitleArray andSegmentValues:(NSArray*) segmentValueArray andDefaultSelection:(NSUInteger) selectedCell inSection:(NSString*) newSectionHeader {
    self = [super init];

    if (self) {
        self = [self initType:DTVCCellIdentifier_SegmentCell forReturnKey:newReturnKey withTitle:cellTitle inSection:newSectionHeader];
        self.segmentValues = segmentValueArray;
        self.segmentTitles = segmentTitleArray;
        self.observedObject = managedObject;
        self.selectedSegment = selectedCell;
        NSLog(@"Cell segment setWith results %@ default %ld and objdef %@",self.segmentValues,(long)self.selectedSegment,[self.observedObject valueForKey:newReturnKey]);

        [self createDefaultValueForObject:self.observedObject orValue:[self.segmentValues objectAtIndex:self.selectedSegment]];

    }
    return self;
}

#pragma mark - editable table cell delegate methods

-(void) cellSegmentDidChange:(NSIndexPath *)cellIndexPath withObject:(NSObject *)segmentResult {
    NSLog(@"Cell segment did change %@",segmentResult);

    self.selectedSegment = [self.segmentValues indexOfObject:segmentResult];
    [self updateValue:segmentResult];
    [self updateContextWithValue:segmentResult];
    [self saveObjectContext];
}
-(void) cellSegmentDidChange:(NSIndexPath *)cellIndexPath withIndex:(NSNumber *)segmentIndex{
    self.selectedSegment=[segmentIndex integerValue];
    [self updateValue:segmentIndex];
    [self updateContextWithValue:segmentIndex];
    [self saveObjectContext];
}
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
