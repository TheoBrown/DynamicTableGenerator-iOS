//
//  NumberOptionCellInput.m
//  TableViewDataCells
//
//  Created by Theodore Brown on 8/10/14.
//  Copyright (c) 2014 Theodore Brown. All rights reserved.
//

#import "NumberOptionCellInput.h"

@implementation NumberOptionCellInput
-(id) initNumberInputForObject:(id) managedObject forReturnKey:(NSString*)newReturnKey withTitle:(NSString*) cellTitle  inSection:(NSString*) newSectionHeader {
    self = [super init];
    
    if (self) {
        self = [self initType:DTVCCellIdentifier_NumberCell forReturnKey:newReturnKey withTitle:cellTitle inSection:newSectionHeader];
        
        [self createDefaultValueForObject:managedObject orValue:[NSNumber numberWithFloat:0.0f]];
    }
    return self;
}

-(id) initNumberInputForObject:(id) managedObject forReturnKey:(NSString*)newReturnKey withTitle:(NSString*) cellTitle withDefault:(NSNumber*) defaultNumber  inSection:(NSString*) newSectionHeader {
    self = [super init];
    
    if (self) {
        //        NSDictionary* settingsDictionary = @{@"Identifier":@"SliderCellID",
        //                                             @"return":@"yMinValue",
        //                                             @"settings":@{@"minValue":@-50.0f,
        //                                                           @"maxValue":@50.0f,
        //                                                           @"defaultValue":@(self.yMinValue ?:0.0f)}}
        self = [self initType:DTVCCellIdentifier_NumberCell forReturnKey:newReturnKey withTitle:cellTitle inSection:newSectionHeader];
        
        [self createDefaultValueForObject:managedObject orValue:defaultNumber];
    }
    return self;
}

- (void) createDefaultValueForObject:(id)managedObject orValue:(id) backupValue {
    NSObject* newDefault = [managedObject valueForKey:self.returnKey] ?:backupValue;
    [self setManagedObject:managedObject withDefaultValue:newDefault];
    
}


#pragma mark - editable table cell delegate methods
- (void) cellNumericValueDidChange: (NSIndexPath *) cellIndexPath :(NSNumber *) newValue {
    NSInteger sec = [cellIndexPath section];
    NSInteger row = [cellIndexPath row];
    [self updateValue:newValue];
    [self updateContextWithValue:newValue];

}


@end
