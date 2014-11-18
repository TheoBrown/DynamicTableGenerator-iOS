//
//  SegmentOptionCellInput.h
//  TableViewDataCells
//
//  Created by Theodore Brown on 8/9/14.
//  Copyright (c) 2014 Theodore Brown. All rights reserved.
//

#import "BaseOptionCellInput.h"



@interface SegmentOptionCellInput : BaseOptionCellInput

@property (strong, nonatomic) NSArray* segmentTitles;
@property (strong, nonatomic) NSArray* segmentValues;
@property (nonatomic) NSInteger selectedSegment;

-(id) initSegmentInputForObject:(id) managedObject forReturnKey:(NSString*) newReturnKey withTitle:(NSString*) cellTitle withSegmentTitles:(NSArray*) segmentTitleArray andSegmentValues:(NSArray*) segmentValueArray andDefaultSelection:(NSInteger) selectedCell inSection:(NSString*) newSectionHeader;

@end
