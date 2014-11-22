//
//  IntergerSegmentOptionCellInput.m
//  DynamicTableGenerator
//
//  Created by tpb on 11/21/14.
//  Copyright (c) 2014 Theodore Brown. All rights reserved.
//

#import "IntergerSegmentOptionCellInput.h"

@implementation IntergerSegmentOptionCellInput
@synthesize segmentTitles, segmentValues, selectedSegment;

-(NSString*) cellType {
    return DTVCCellIdentifier_SegmentCell;
}

-(id) initIntergerSegmentInputForObject:(id)managedObject forReturnKey:(NSString *)newReturnKey withTitle:(NSString *)cellTitle inSection:(NSString *)newSectionHeader {
    if (!self) {
        self = [self initType:DTVCCellIdentifier_SegmentCell forReturnKey:newReturnKey withTitle:cellTitle inSection:newSectionHeader];

        self.observedObject = managedObject;
        
    }
    return self;
}

-(id) initIntergerSegmentInputForObject:(id)managedObject withIncrement:(NSNumber *)defaultIncrement forReturnKey:(NSString *)newReturnKey withTitle:(NSString *)cellTitle inSection:(NSString *)newSectionHeader{
    if (!self) {
        self = [self initType:DTVCCellIdentifier_SegmentCell forReturnKey:newReturnKey withTitle:cellTitle inSection:newSectionHeader];

        self.observedObject = managedObject;
        
    }
    return self;
}

-(id) initIntergerSegmentInputForObject:(id)managedObject forReturnKey:(NSString *)newReturnKey withMaxValue:(NSNumber *)maxValue andMinValue:(NSNumber *)minValue withTitle:(NSString *)cellTitle inSection:(NSString *)newSectionHeader{
    if (!self) {
        self = [self initType:DTVCCellIdentifier_SegmentCell forReturnKey:newReturnKey withTitle:cellTitle inSection:newSectionHeader];
//        self.segmentValues = segmentValueArray;
//        self.segmentTitles = segmentTitleArray;
        
    }
    return self;
}





@end
