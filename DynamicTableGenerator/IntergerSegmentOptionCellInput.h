//
//  IntergerSegmentOptionCellInput.h
//  DynamicTableGenerator
//
//  Created by tpb on 11/21/14.
//  Copyright (c) 2014 Theodore Brown. All rights reserved.
//

#import "BaseOptionCellInput.h"

@interface IntergerSegmentOptionCellInput : BaseOptionCellInput
@property (strong, nonatomic) NSArray* segmentTitles;
@property (strong, nonatomic) NSArray* segmentValues;
@property (nonatomic) NSInteger selectedSegment;

-(id) initIntergerSegmentInputForObject:(id) managedObject forReturnKey:(NSString*) newReturnKey withTitle:(NSString*) cellTitle  inSection:(NSString*) newSectionHeader;
-(id) initIntergerSegmentInputForObject:(id) managedObject forReturnKey:(NSString*) newReturnKey withMaxValue:(NSNumber*) maxValue andMinValue:(NSNumber*) minValue withTitle:(NSString*) cellTitle  inSection:(NSString*) newSectionHeader;

-(id) initIntergerSegmentInputForObject:(id) managedObject withIncrement:(NSNumber*) defaultIncrement forReturnKey:(NSString*) newReturnKey withTitle:(NSString*) cellTitle  inSection:(NSString*) newSectionHeader;

@end

