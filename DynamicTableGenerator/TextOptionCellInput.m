//
//  TextOptionCellInput.m
//  TableViewDataCells
//
//  Created by Theodore Brown on 8/9/14.
//  Copyright (c) 2014 Theodore Brown. All rights reserved.
//

#import "TextOptionCellInput.h"

@implementation TextOptionCellInput

-(id) initTextInputForObject:(id) managedObject forReturnKey:(NSString*)newReturnKey withTitle:(NSString*) cellTitle  inSection:(NSString*) newSectionHeader {
    self = [super init];
    
    if (self) {
        self = [self initType:textCell forReturnKey:newReturnKey withTitle:cellTitle inSection:newSectionHeader];
        [self setManagedObject:managedObject];
    }
    return self;
}

-(id) initTextInputForObject:(id) managedObject forReturnKey:(NSString*)newReturnKey withTitle:(NSString*) cellTitle withDefault:(NSString*) defaultText  inSection:(NSString*) newSectionHeader {
    self = [super init];
    
    if (self) {
        //        NSDictionary* settingsDictionary = @{@"Identifier":@"SliderCellID",
        //                                             @"return":@"yMinValue",
        //                                             @"settings":@{@"minValue":@-50.0f,
        //                                                           @"maxValue":@50.0f,
        //                                                           @"defaultValue":@(self.yMinValue ?:0.0f)}}
        self = [self initType:textCell forReturnKey:newReturnKey withTitle:cellTitle inSection:newSectionHeader];

        [self createDefaultValueForObject:managedObject orValue:defaultText];
    }
    return self;
}

- (void) createDefaultValueForObject:(id)managedObject orValue:(id) backupValue {
    NSObject* newDefault = [managedObject valueForKey:self.returnKey] ?:backupValue;
    [self setManagedObject:managedObject withDefaultValue:newDefault];
    
}

#pragma mark - editable table cell delegate methods
- (void) cellTextValueDidChange:(NSIndexPath *) cellIndexPath :(NSString *) newValue{
    NSInteger sec = [cellIndexPath section];
    NSInteger row = [cellIndexPath row];
    [self updateValue:newValue];
}
@end
