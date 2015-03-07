//
//  StepperOptionCellInput.h
//  DynamicTableGenerator
//
//  Created by tpb on 12/17/14.
//  Copyright (c) 2014 Theodore Brown. All rights reserved.
//

#import "BaseOptionCellInput.h"

/**
 *  UIStepper Cell
 */
@interface StepperOptionCellInput : BaseOptionCellInput

@property (strong, nonatomic) NSNumber *minStepperValue;
@property (strong, nonatomic) NSNumber *maxStepperValue;

-(id) initStepperInputForObject:(id) managedObject forReturnKey:(NSString*)newReturnKey withTitle:(NSString*) cellTitle withDefault:(NSNumber*) defaultNumber withMaxValue:(NSNumber*) maxValue andMinValue:(NSNumber*) minValue inSection:(NSString*) newSectionHeader;
@end
