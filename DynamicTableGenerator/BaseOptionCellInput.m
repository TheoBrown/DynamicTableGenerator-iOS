//
//  BaseOptionCellInput.m
//  TableViewDataCells
//
//  Created by Theodore Brown on 8/9/14.
//  Copyright (c) 2014 Theodore Brown. All rights reserved.
//

#import "BaseOptionCellInput.h"
// setup constant strings for cell types
//extern NSString * const dateCell;
//extern NSString * const sliderCell;
//extern NSString * const buttonCell;
//extern NSString * const actionCell;
//extern NSString * const textCell;
//extern NSString * const numberCell;

NSString * const dateCell = @"DateCellID";
NSString * const sliderCell = @"SliderCellID";
NSString * const buttonCell = @"ButtonCellID";
NSString * const actionCell = @"ActionSheetCellID";
NSString * const textCell = @"TableCellWithTextCellIdentifier";
NSString * const switchCell = @"TableCellWithSwitchCellIdentifier";
NSString * const numberCell = @"TableCellWithNumberCellIdentifier";
NSString * const segmentCell = @"SegmentCellID";

@implementation BaseOptionCellInput
@synthesize sectionHeader, title, identifier , cellPosition;
@synthesize observedObject, value, defaultValue;

- (id) initType:(NSString*) optionType forReturnKey:(NSString*) newReturnKey withTitle:(NSString*) titleString inSection:(NSString*) sectionHeaderString {
//    NSLog(@"base init called");
    self = [super init];

    if (self) {
//        NSLog(@"base init did execute");
        self.returnKey = newReturnKey;
        self.title = titleString;
        self.sectionHeader = sectionHeaderString;
        self.identifier = optionType;
    }
//    [self printDebug];
    return self;
}

- (void) setManagedObject:(id) managedObject {
    self.observedObject = managedObject;
    self.defaultValue = [managedObject valueForKey:self.returnKey];
    if (self.defaultValue != NULL) {
        self.value = self.defaultValue;
    }
    NSLog(@"%@ set object with default %@ and value  %@",self.title,[self.defaultValue description], [self.value description]);
}

- (void) setManagedObject:(id) managedObject withDefaultValue:(NSObject*) defaultvalue {
    self.observedObject = managedObject;
//    NSLog(@"observed object is %@", [self.observedObject description]);
    self.defaultValue = defaultvalue;
    self.value = self.defaultValue;
}

- (void) updateValue:(id) newValue {
    self.value = newValue;
}

-(NSObject*) getDisplayValue{
    return self.value;
}
- (void) saveObjectContext {
    [self.observedObject setValue:self.value forKey:self.returnKey];
}

- (void) updateContextWithValue:(NSObject*) newValue {
    NSLog(@"%@ asked to update value to %@",self.title,newValue);
    if ([self.observedObject class] == [newValue class]) {
        NSLog(@"value is updated with context");
        
        self.observedObject = newValue;
        self.value = newValue;
    }
}

#pragma mark - Cell Type Options
- (void) setCellType:(NSString*) cellTypeString {
    self.cellTypeString = cellTypeString;
}

#pragma  mark - debug
- (void) printDebug {
    NSLog(@"title: %@ , section %@, id %@", self.title, self.sectionHeader, self.identifier);
}

- (void) debugClassTypes {
    NSLog(@"observedObject: %@ , value %@, id %@", [self.observedObject class], [self.value class], self.identifier);

}
@end
