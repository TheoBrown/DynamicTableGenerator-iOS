//
//  MutableTableViewSetupHelper.m
//  TableViewDataCells
//
//  Created by Theodore Brown on 8/10/14.
//  Copyright (c) 2014 Theodore Brown. All rights reserved.
//

#import "DynamicTableViewObjectParser.h"

#import "PropertyUtil.h"

@implementation DynamicTableViewObjectParser
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
 
 
 from core data:
 2014-11-16 13:29:32.615 StaticLibTest[2295:32614] Properties for class EventCatagory: {
 "catagory_name" = NSString;
 "catagory_type" = NSString;
 "decimal__d" = NSDecimalNumber;
 "end_time" = NSDate;
 int16 = NSNumber;
 int32 = NSNumber;
 int64 = NSNumber;
 occurances = NSSet;
 "public__b" = NSNumber;
 "rating__f" = NSNumber;
 "start_time" = NSDate;
 timeStamp = NSDate;
 }
 */




-(NSArray*) parseTypeFromStringFormat:(NSString*)keyString {
    if ([keyString rangeOfString:@"__"].location != NSNotFound) {

        NSArray *listItems = [keyString componentsSeparatedByString:@"__"];
        NSLog(@"list items in parseTypeFromStringFormat %@",listItems);
        NSString *typeString = listItems[1];
        NSString *displayString = [NSString stringWithFormat:@"%@",listItems[0]];
        
        NSString *propertyString = [[NSString alloc] init];
        
        if ([typeString isEqualToString:@"b"]) {
            propertyString = @"B";
        }
        else if ([typeString isEqualToString:@"f"]) {
            propertyString = @"f";
        }
        else if ([typeString isEqualToString:@"d"]) { //descimal
            propertyString = @"decimal";
        }
        else if ([typeString isEqualToString:@"dtd"]) {
            propertyString = @"date";
        }
        else if ([typeString isEqualToString:@"dtdt"]) {
            propertyString = @"datetime";
        }
        else if ([typeString isEqualToString:@"dtt"]) {
            propertyString = @"time";
        }
        else if ([typeString isEqualToString:@"i"]) {
            propertyString = @"integer";
        }
        else {
            propertyString = typeString;
        }
        return @[displayString,propertyString];
    }
    
    return @[keyString,@""];

}
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
        NSString* propertyTypeString = [info objectForKey:key];
        NSLog(@" key = %@, propStr = %@",key,propertyTypeString);

        NSArray * parsedPropertys = [self parseTypeFromStringFormat:key];
        NSLog(@"parsed propertys are %@",parsedPropertys);
        
        NSString* cleanPropertyName = parsedPropertys[0];
        NSString* parsedPropertyType = parsedPropertys[1];

        
        
        NSString *displayName =[self displayStringForKey:cleanPropertyName];
        
        [displaynames setObject:displayName forKey:key];
        if ([propertyTypeString isEqualToString:@"NSNumber"]) {
            
        
            if ([parsedPropertyType isEqualToString:@"B"]) {
                propertyTypeString = @"B";
            }
            else if ([parsedPropertyType isEqualToString:@"f"]) {
                propertyTypeString = @"f";
            }

        }
        else if ([propertyTypeString isEqualToString:@"NSString"]) {
            
            
            if ([parsedPropertyType isEqualToString:@"a"]) {
                parsedPropertyType = @"ascii";
            }
            else if ([parsedPropertyType isEqualToString:@"abc"]) {
                parsedPropertyType = @"alphabet";
            }
            else if ([parsedPropertyType isEqualToString:@"e"]) {
                parsedPropertyType = @"email";
            }
            else if ([parsedPropertyType isEqualToString:@"u"]) {
                parsedPropertyType = @"url";
            }
            else if ([parsedPropertyType isEqualToString:@"p"]) {
                parsedPropertyType = @"phone";
            }
            else {
                parsedPropertyType = @"ascii";
            }
        }

        if ([propertyTypeString  isEqual: @"NSString"]){
            TextOptionCellInput* newTextCell = [[TextOptionCellInput alloc] initTextInputForObject:self.mutableFormObject forReturnKey:key withTitle:displayName inSection:@"text section"];
            [newTextCell setCellType:parsedPropertyType];

            [tempCellsArray addObject:newTextCell];
        }
        
        else if ([propertyTypeString isEqual:@"NSDate"]) {
            DateOptionCellInput *newDateCell = [[DateOptionCellInput alloc] initDateInputForObject:self.mutableFormObject forReturnKey:key withTitle:displayName inSection:@"dates section"];
            
            [newDateCell setCellType:parsedPropertyType];
            
            [tempCellsArray addObject:newDateCell];

        }
        else if ([propertyTypeString isEqual:@"NSNumber"]) {
            NumberOptionCellInput* newNumberCell = [[NumberOptionCellInput alloc] initNumberInputForObject:self.mutableFormObject forReturnKey:key withTitle:displayName inSection:@"number section"];
            
            [newNumberCell setCellType:parsedPropertyType];
            [tempCellsArray addObject:newNumberCell];

        }
        else if ([propertyTypeString isEqual:@"NSObject"]) {
            
        }
        else if ([propertyTypeString isEqual:@"NSArray"]) {
            
        }
        else if ([propertyTypeString isEqual:@"NSSet"]) {
            
        }
        else if ([propertyTypeString isEqual:@"f"]) { // value is float
            SliderOptionCellInput *newCell = [[SliderOptionCellInput alloc] initFloatSliderInputForObject:self.mutableFormObject forReturnKey:key withTitle:displayName withDefault:[NSNumber numberWithFloat:0.5] withMaxValue:[NSNumber numberWithFloat:1] andMinValue:[NSNumber numberWithFloat:0] inSection:@"number section"];
            [tempCellsArray addObject:newCell];
        }
        else if ([propertyTypeString isEqual:@"d"]) { //CGFloat
            
        }
        else if ([propertyTypeString isEqual:@"q"]) { // NSInteger
            
        }
        else if ([propertyTypeString isEqual:@"NSDecimalNumber"]) { // NSDecimalNumber
            
        }
        else if ([propertyTypeString isEqual:@"B"]) { // bool
            SwitchOptionCellInput *newCell = [[SwitchOptionCellInput alloc] initSwitchInputForObject:self.mutableFormObject forReturnKey:key withTitle:displayName inSection:@"number section"];
            [tempCellsArray addObject:newCell];
        }
    }
    UserInfoDict = [[NSDictionary alloc] initWithDictionary:displaynames];
    UserInfoArray = [[NSArray alloc] initWithArray:[displaynames allKeys]];
//    NSLog(@"Temp Array Info: %@",UserInfoArray);
//

    self.cellsArray = [[NSArray alloc] initWithArray:tempCellsArray];
}




@end
