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

//NSString * const dateCell = @"DateCellID";
//NSString * const sliderCell = @"SliderCellID";
//NSString * const buttonCell = @"ButtonCellID";
//NSString * const actionCell = @"ActionSheetCellID";
//NSString * const textCell = @"TableCellWithTextCellIdentifier";
//NSString * const switchCell = @"TableCellWithSwitchCellIdentifier";
//NSString * const numberCell = @"TableCellWithNumberCellIdentifier";
//NSString * const segmentCell = @"SegmentCellID";

@implementation BaseOptionCellInput
@synthesize sectionHeader, title, identifier , cellPosition;
@synthesize observedObject, value, defaultValue;

#pragma mark - init
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

-(id) initInputType:(NSString*) optionType forObject:(id) managedObject forReturnKey:(NSString*)newReturnKey withTitle:(NSString*) cellTitle  inSection:(NSString*) newSectionHeader{
    self = [super init];
    
    if (self) {
        self.returnKey = newReturnKey;
        self.title = cellTitle;
        self.sectionHeader = newSectionHeader;
        self.identifier = optionType;
        [self setManagedObject:managedObject];
    }
    return self;
}

-(id) initInputClassforObject:(id) managedObject forReturnKey:(NSString*)newReturnKey withTitle:(NSString*) cellTitle  inSection:(NSString*) newSectionHeader{
    self = [super init];
    
    if (self) {
        self.returnKey = newReturnKey;
        self.title = cellTitle;
        self.sectionHeader = newSectionHeader;
        self.identifier = [self cellType];
        [self setManagedObject:managedObject];
    }
    return self;
}
#pragma mark - value definitions
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
    NSLog(@"observed object is %@", [self.observedObject description]);
    self.defaultValue = defaultvalue;
    self.value = self.defaultValue;
}

- (void) createDefaultValueForObject:(id)managedObject orValue:(id) backupValue {
    NSObject* newDefault = [managedObject valueForKey:self.returnKey] ?:backupValue;
    [self setManagedObject:managedObject withDefaultValue:newDefault];
    
}
- (void) updateValue:(id) newValue {
    self.value = newValue;
    NSLog(@"Value set to %@",newValue);
}

#pragma mark - update values
-(NSObject*) getDisplayValue{
    return self.value;
}
- (void) saveObjectContext {
    //used to write to a core data entity
    if ([self.observedObject respondsToSelector:@selector(setValue:forKey:)]) {

        [self.observedObject setValue:self.value forKey:self.returnKey];
                NSLog(@"SaveObj:: %@ obj %@  set key %@ to %@",self.title,self.observedObject,self.returnKey,[self.observedObject valueForKey:self.returnKey]);
//        NSLog(@"to value %@ for value %@",[self.observedObject valueForKey:self.returnKey],self.value);
    }
}

- (void) updateContextWithValue:(NSObject*) newValue {
    //updates the value of an object, eg if managed object is NSObject (i.e. non dict-coding compliant)
    
    
    if ([self.observedObject class] == [newValue class]) {
        NSLog(@"%@ Asked to set %@ obj to %@ from %@",self.title,self.observedObject,newValue,self.value);
//        NSLog(@"%@ asked to update value to %@",self.title,newValue);

        self.observedObject = newValue;
        self.value = newValue;
    }
}

#pragma mark - Cell Type Options
- (void) defineCellInputFormatType:(NSNumber*) newCellInputFormatType {
//    NSLog(@"%@ input format set to %d",self.title,newCellInputFormatType);
    self.cellInputFormatType = newCellInputFormatType;
}

#pragma  mark - debug
- (void) printDebug {
    NSLog(@"title: %@ , section %@, id %@", self.title, self.sectionHeader, self.identifier);
}

- (void) debugClassTypes {
    NSLog(@"observedObject: %@ , value %@, id %@", [self.observedObject class], [self.value class], self.identifier);

}
-(NSString*) cellType {
    
    if (!self.identifier) {
        NSLog(@"ERROR Cell type not set");
    }
    return self.identifier;
    
}
@end
