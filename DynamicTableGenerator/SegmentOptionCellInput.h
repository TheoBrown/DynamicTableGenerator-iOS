//
//  SegmentOptionCellInput.h
//  TableViewDataCells
//
//  Created by Theodore Brown on 8/9/14.
//  Copyright (c) 2014 Theodore Brown. All rights reserved.
//

#import "BaseOptionCellInput.h"


/**
 *  UISegmentedControl cell - for selecting one option out of an array
 */
@interface SegmentOptionCellInput : BaseOptionCellInput

@property (strong, nonatomic) NSArray* segmentTitles;
@property (strong, nonatomic) NSArray* segmentValues;
@property (nonatomic) NSUInteger selectedSegment;

-(id) initSegmentInputForObject:(id) managedObject forReturnKey:(NSString*) newReturnKey withTitle:(NSString*) cellTitle withSegmentTitles:(NSArray*) segmentTitleArray andSegmentValues:(NSArray*) segmentValueArray andDefaultSelection:(NSUInteger) selectedCell inSection:(NSString*) newSectionHeader;

@end
