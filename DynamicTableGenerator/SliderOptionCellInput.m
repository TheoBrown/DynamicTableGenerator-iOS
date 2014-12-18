//
//  SliderOptionCellInput.m
//  TableViewDataCells
//
//  Created by Theodore Brown on 8/9/14.
//  Copyright (c) 2014 Theodore Brown. All rights reserved.
//

#import "SliderOptionCellInput.h"

@implementation SliderOptionCellInput

-(NSString*) cellType {
    return DTVCCellIdentifier_SliderCell;
}

-(id) initFloatSliderInputForObject:(id) managedObject forReturnKey:(NSString*)newReturnKey withTitle:(NSString*) cellTitle withDefault:(NSNumber*) defaultFloat withMaxValue:(NSNumber*) maxValue andMinValue:(NSNumber*) minValue inSection:(NSString*) newSectionHeader {
    
    self = [super init];
    
    NSLog(@"slider created with object %@" , [managedObject description]);
    
    if (self) {
//        NSDictionary* settingsDictionary = @{@"Identifier":@"SliderCellID",
//                                             @"return":@"yMinValue",
//                                             @"settings":@{@"minValue":@-50.0f,
//                                                           @"maxValue":@50.0f,
//                                                           @"defaultValue":@(self.yMinValue ?:0.0f)}}
        
        self = [self initType:DTVCCellIdentifier_SliderCell forReturnKey:newReturnKey withTitle:cellTitle inSection:newSectionHeader];

        self.minSliderValue = minValue;
        self.maxSliderValue = maxValue;
        [self createDefaultValueForObject:managedObject orValue:defaultFloat];
    }
    return self;
}

//- (void) createDefaultValueForObject:(NSObject*)managedObject orValue:(NSObject*) backupValue {
//    NSObject* newDefault = [managedObject valueForKey:self.returnKey] ?:backupValue;
//    [self setManagedObject:managedObject withDefaultValue:newDefault];
//
//}
//- (void) createDefaultValueForObject:(id)managedObject orValue:(id) backupValue {
//    NSObject* newDefault = [managedObject valueForKey:self.returnKey] ?:backupValue;
//    [self setManagedObject:managedObject withDefaultValue:newDefault];
//    
//}
#pragma mark - editable table cell delegate methods


-(void) cellSliderDidChange:(NSIndexPath *) cellIndexPath :(NSNumber*) value{
    [self updateValue:value];
    [self updateContextWithValue:value];
}

//-(void) cellSliderDidChange:(NSIndexPath *) cellIndexPath :(float)value {
//    NSInteger sec = [cellIndexPath section];
//    NSInteger row = [cellIndexPath row];
//    NSLog(@"%@ float slider set new value %f", self.title ,value);
//
////    NSNumber * floatNumber = (NSNumber*) self.observedObject;
////    NSLog(@"%@ float slider set observed value %f to new value %f", self.title, [floatNumber floatValue] ,value);
//
//    NSLog(@"%@ float slider set to %f", self.title, value);
//    [self updateContextWithValue:[NSNumber numberWithFloat:value]];
//    
//    [self debugClassTypes];
//    //    [self.resultDict setObject:[NSString stringWithFormat:@"%.2f",value] forKey:[self.optionsArray[sec][1][row] valueForKey:@"return"]];
//    //    [[[SharedData getInstance] settings] setFloat:value forKey:[self.optionsArray[sec][1][row] valueForKey:@"return"]];
//}

@end
