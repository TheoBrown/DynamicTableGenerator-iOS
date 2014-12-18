//
//  SwitchOptionCellInput.m
//  DynamicTableGenerator
//
//  Created by tpb on 11/14/14.
//  Copyright (c) 2014 Theodore Brown. All rights reserved.
//

#import "SwitchOptionCellInput.h"

@implementation SwitchOptionCellInput

-(NSString*) cellType {
    return DTVCCellIdentifier_SwitchCell;
}

-(id) initSwitchInputForObject:(id) managedObject forReturnKey:(NSString*)newReturnKey withTitle:(NSString*) cellTitle withDefault:(BOOL) defaultBool  inSection:(NSString*) newSectionHeader {
    self = [super init];
    
    if (self) {
        //        NSDictionary* settingsDictionary = @{@"Identifier":@"SliderCellID",
        //                                             @"return":@"yMinValue",
        //                                             @"settings":@{@"minValue":@-50.0f,
        //                                                           @"maxValue":@50.0f,
        //                                                           @"defaultValue":@(self.yMinValue ?:0.0f)}}
        self = [self initType:DTVCCellIdentifier_SwitchCell forReturnKey:newReturnKey withTitle:cellTitle inSection:newSectionHeader];
        
        [self createDefaultValueForObject:managedObject orValue:[NSNumber numberWithBool:defaultBool]];
    }
    return self;
}



//- (void) createDefaultValueForObject:(id)managedObject orValue:(id) backupValue {
//    NSObject* newDefault = [managedObject valueForKey:self.returnKey] ?:backupValue;
//    [self setManagedObject:managedObject withDefaultValue:newDefault];
//    
//}

#pragma mark - editable table cell delegate methods
- (void) cellSwitchDidChange: (NSIndexPath *) cellIndexPath :(NSNumber*) value{
    [self updateValue:value];
    [self updateContextWithValue:value];
}

-(BOOL) getDisplayValue{
    NSNumber* numberValue = (NSNumber*)self.value;
    return [numberValue boolValue];
}
//- (void) cellSwitchDidChange: (NSIndexPath *) cellIndexPath :(BOOL) newValue {
//    NSInteger sec = [cellIndexPath section];
//    NSInteger row = [cellIndexPath row];
//    [self updateValue:[NSNumber numberWithBool:newValue]];
//}
@end