//
//  MutableTableViewSetupHelper.m
//  TableViewDataCells
//
//  Created by Theodore Brown on 8/10/14.
//  Copyright (c) 2014 Theodore Brown. All rights reserved.
//

#import "MutableTableViewSetupHelper.h"

#import "PropertyUtil.h"

@implementation MutableTableViewSetupHelper
@synthesize NewFormClass;
@synthesize  saveUserButton;
@synthesize  UserInfoArray, UserInfoDict, currentSelection,titletag;
@synthesize txtActiveField = _txtActiveField;
@synthesize keyboardToolbar = _keyboardToolbar;
@synthesize btnDone = _btnDone;
@synthesize btnNext = _btnNext;
@synthesize btnPrev = _btnPrev;
@synthesize cellsArray;

- (id) initWithObject:(id)newFormObject {
    if (self = [super init]) {
        if (self.mutableFormObject != newFormObject) {
            self.mutableFormObject = newFormObject;
            [self setupFormPropertiesFromObject:self.mutableFormObject];
        }
    }
    return self;
}
- (id) initWithManagedObject:(id)newFormObject {
    if (self = [super init]) {
        if (self.mutableFormObject != newFormObject) {
            self.mutableFormObject = newFormObject;
            [self setupFormPropertiesFromObject:self.mutableFormObject];
        }
    }
    return self;
}
- (id) initWithDict:(id)newFormObject {
    if (self = [super init]) {
        if (self.mutableFormObject != newFormObject) {
            self.mutableFormObject = newFormObject;
            [self setupFormPropertiesFromObject:self.mutableFormObject];
        }
    }
    return self;
}


- (void)setFormClass:(id)newFormClass
{
	NSLog(@"form class set to %@" , [newFormClass debugDescription]);
    if (self.mutableFormObject != newFormClass) {
        self.mutableFormObject = newFormClass;
        
        // Update the view.
    }
    
}

- (void) setupFormPropertiesFromObject:(id) formObject {
    NSDictionary *properties = [PropertyUtil classPropsFor:[formObject class]];
    NSLog(@"Properties for class %@: %@",[[formObject class] debugDescription], properties);
    [self populateTableInfo:properties];
}


/*
 Properties for class: {
 endDate = NSDate;
 majorIncrement = q;
 minorIncrement = q;
 pickedUser = NSObject;
 plotTypes = NSString;
 resultsToPlot = NSArray;
 startDate = NSDate;
 textInput = NSString;
 xNumber = NSNumber;
 xValue = f;
 yMaxValue = d;
 yMinValue = d;
 yNumber = NSNumber;
 yValue = f;
 }
 */

-(NSString*) displayStringForKey:(NSString*)keyString {
    NSString *displayString = [[NSString alloc] init];
    if ([keyString rangeOfString:@"_"].location != NSNotFound){
        NSArray *listItems = [keyString componentsSeparatedByString:@"_"];
        displayString = [NSString stringWithFormat:@"%@ %@",[listItems[0] capitalizedString],[listItems[1] capitalizedString]];
    }
    else{
        displayString = [keyString capitalizedString];
    }
    return displayString;
}

-(void) populateTableInfo: (NSDictionary *) info{
    NSMutableArray *tempCellsArray = [[NSMutableArray alloc] init];
    NSMutableDictionary *displaynames = [[NSMutableDictionary alloc] init];
    for (NSString* key in info){
        NSString* value = [info objectForKey:key];
        
        if ([value  isEqual: @"NSString"]){
            [displaynames setObject:[self displayStringForKey:key] forKey:key];
            TextOptionCellInput* newTextCell = [[TextOptionCellInput alloc] initTextInputForObject:self.mutableFormObject forReturnKey:key withTitle:[self displayStringForKey:key] inSection:@"text section"];
            [tempCellsArray addObject:newTextCell];
        }
        
        else if ([value isEqual:@"NSDate"]) {
            [displaynames setObject:[self displayStringForKey:key] forKey:key];
            DateOptionCellInput *newDateCell = [[DateOptionCellInput alloc] initDateInputForObject:self.mutableFormObject forReturnKey:key withTitle:[self displayStringForKey:key] inSection:@"dates section"];
            [tempCellsArray addObject:newDateCell];

        }
        else if ([value isEqual:@"NSNumber"]) {
            [displaynames setObject:[self displayStringForKey:key] forKey:key];
            NumberOptionCellInput* newNumberCell = [[NumberOptionCellInput alloc] initNumberInputForObject:self.mutableFormObject forReturnKey:key withTitle:[self displayStringForKey:key] inSection:@"number section"];
            [tempCellsArray addObject:newNumberCell];

        }
        else if ([value isEqual:@"NSObject"]) {
            
        }
        else if ([value isEqual:@"NSArray"]) {
            
        }
        else if ([value isEqual:@"NSSet"]) {
            
        }
        else if ([value isEqual:@"f"]) { // value is float
            
        }
        else if ([value isEqual:@"d"]) { //CGFloat
            
        }
        else if ([value isEqual:@"q"]) { // NSInteger
            
        }
        else if ([value isEqual:@"NSDecimalNumber"]) { // NSDecimalNumber
            
        }
    }
    UserInfoDict = [[NSDictionary alloc] initWithDictionary:displaynames];
    UserInfoArray = [[NSArray alloc] initWithArray:[displaynames allKeys]];
//    NSLog(@"Temp Array Info: %@",UserInfoArray);
//

    self.cellsArray = [[NSArray alloc] initWithArray:tempCellsArray];
}




@end
