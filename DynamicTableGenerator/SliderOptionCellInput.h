//
//  SliderOptionCellInput.h
//  TableViewDataCells
//
//  Created by Theodore Brown on 8/9/14.
//  Copyright (c) 2014 Theodore Brown. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseOptionCellInput.h"

//#import "CellWithSlider.h"

/**
 *  UISlider cell - for setting floats/ints within a range
 */
@interface SliderOptionCellInput : BaseOptionCellInput
@property (strong, nonatomic) NSNumber *minSliderValue;
@property (strong, nonatomic) NSNumber *maxSliderValue;

-(id) initFloatSliderInputForObject:(id) managedObject forReturnKey:(NSString*)newReturnKey withTitle:(NSString*) cellTitle withDefault:(NSNumber*) defaultFloat withMaxValue:(NSNumber*) maxValue andMinValue:(NSNumber*) minValue inSection:(NSString*) newSectionHeader;
@end
