//
//  StepperOptionCellInput.m
//  DynamicTableGenerator
//
//  Created by tpb on 12/17/14.
//  Copyright (c) 2014 Theodore Brown. All rights reserved.
//

#import "StepperOptionCellInput.h"

@implementation StepperOptionCellInput

-(NSString*) cellType {
    return DTVCCellIdentifier_StepperCell;
}



-(id) initStepperInputForObject:(id) managedObject forReturnKey:(NSString*)newReturnKey withTitle:(NSString*) cellTitle withDefault:(NSNumber*) defaultNumber withMaxValue:(NSNumber*) maxValue andMinValue:(NSNumber*) minValue inSection:(NSString*) newSectionHeader{
    
    self = [super init];
    
    NSLog(@"stepper created with object %@" , [managedObject description]);
    
    if (self) {
        //        NSDictionary* settingsDictionary = @{@"Identifier":@"SliderCellID",
        //                                             @"return":@"yMinValue",
        //                                             @"settings":@{@"minValue":@-50.0f,
        //                                                           @"maxValue":@50.0f,
        //                                                           @"defaultValue":@(self.yMinValue ?:0.0f)}}
        
        self = [self initType:DTVCCellIdentifier_StepperCell forReturnKey:newReturnKey withTitle:cellTitle inSection:newSectionHeader];
        
        self.minStepperValue = minValue;
        self.maxStepperValue = maxValue;
        [self createDefaultValueForObject:managedObject orValue:defaultNumber];
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


-(void) cellStepperDidChange:(NSIndexPath *) cellIndexPath :(NSNumber*) value{
    [self updateValue:value];
    [self updateContextWithValue:value];
}


@end
