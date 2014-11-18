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

-(int) parsTextEntryTypes:(NSString*) parsedPropertyType {
    int returnInputEnumType = 0;
        if ([parsedPropertyType isEqualToString:@"a"]) {
            returnInputEnumType = DTVCInputType_TextCell_Ascii;
        }
        else if ([parsedPropertyType isEqualToString:@"abc"]) {
            returnInputEnumType = DTVCInputType_TextCell_Alphabet;
        }
        else if ([parsedPropertyType isEqualToString:@"e"]) {
            returnInputEnumType = DTVCInputType_TextCell_Email;
        }
        else if ([parsedPropertyType isEqualToString:@"u"]) {
            returnInputEnumType = DTVCInputType_TextCell_URL;
        }
        else if ([parsedPropertyType isEqualToString:@"p"]) {
            returnInputEnumType = DTVCInputType_TextCell_Phone;
        }
        else {
            returnInputEnumType = DTVCInputType_TextCell_Ascii;
        }
    return returnInputEnumType;
}

-(void) populateTableInfo: (NSDictionary *) info{
    NSMutableArray *tempCellsArray = [[NSMutableArray alloc] init];
    NSMutableDictionary *displaynames = [[NSMutableDictionary alloc] init];
    NSLog(@"%@" ,[info description]);
    for (NSString* key in info){
        NSString* propertyTypeString = [info objectForKey:key];
        NSLog(@" key = %@, propStr = %@",key,propertyTypeString);

        NSArray * parsedPropertys = [self parseTypeFromStringFormat:key];
        NSLog(@"parsed propertys are %@",parsedPropertys);
        
        NSString* cleanPropertyName = parsedPropertys[0];
        NSString* parsedPropertyType = parsedPropertys[1];
        int inputFormatType = [parsedPropertys[2] intValue];

        
        
        NSString *displayName =[self displayStringForKey:cleanPropertyName];


        [displaynames setObject:displayName forKey:key];
        
        if ([propertyTypeString isEqualToString:@"NSNumber"]) { //create alternative controls based on attr name
            if ([parsedPropertyType isEqualToString:@"B"]) {
                propertyTypeString = @"B";
            }
            else if ([parsedPropertyType isEqualToString:@"f"]) {
                propertyTypeString = @"f";
            }

        }

        NSLog(@"%@ key property type %@ format %d",displayName,propertyTypeString,inputFormatType);

        if ([propertyTypeString  isEqual: @"NSString"]){
            int inputFormatType = [self parsTextEntryTypes:parsedPropertyType];
            NSLog(@"%@ parsed to input enum %d",parsedPropertyType,inputFormatType);
            TextOptionCellInput* newTextCell = [[TextOptionCellInput alloc] initTextInputForObject:self.mutableFormObject forReturnKey:key withTitle:displayName inSection:@"text section"];
            NSLog(@"%@ parsed to finished init," ,newTextCell.title);

            [newTextCell defineCellInputFormatType:[NSNumber numberWithInt:inputFormatType]];
            NSLog(@"%@ parsed set format %d," ,newTextCell.title,[newTextCell.cellInputFormatType intValue]);

            [tempCellsArray addObject:newTextCell];
        }
        
        else if ([propertyTypeString isEqual:@"NSDate"]) {
            DateOptionCellInput *newDateCell = [[DateOptionCellInput alloc] initDateInputForObject:self.mutableFormObject forReturnKey:key withTitle:displayName inSection:@"dates section"];
            
            [newDateCell defineCellInputFormatType:[NSNumber numberWithInt:inputFormatType]];
            
            [tempCellsArray addObject:newDateCell];

        }
        else if ([propertyTypeString isEqual:@"NSNumber"]) {
            NumberOptionCellInput* newNumberCell = [[NumberOptionCellInput alloc] initNumberInputForObject:self.mutableFormObject forReturnKey:key withTitle:displayName inSection:@"number section"];
            
            [newNumberCell defineCellInputFormatType:[NSNumber numberWithInt:inputFormatType]];
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

#pragma mark  - property type parsing

-(NSArray*) parseTypeFromStringFormat:(NSString*)keyString {
    int inputFormatType = 0;
    if ([keyString rangeOfString:@"__"].location != NSNotFound) {
        NSArray *listItems = [keyString componentsSeparatedByString:@"__"];
        NSLog(@"list items in parseTypeFromStringFormat %@",listItems);
        NSString *typeString = listItems[1];
        NSString *displayString = [NSString stringWithFormat:@"%@",listItems[0]];
        NSString *propertyString = [[NSString alloc] init];
        
        if ([typeString isEqualToString:@"b"]) {
            propertyString = @"B";
            inputFormatType = DTVCInputType_SwitchCell_Bool;
        }
        else if ([typeString isEqualToString:@"f"]) {
            propertyString = @"f";
            inputFormatType = DTVCInputType_SliderCell_Float;
        }
        else if ([typeString isEqualToString:@"d"]) { //descimal
            propertyString = @"decimal";
            inputFormatType = DTVCInputType_NumberCell_Decimal;
        }
        else if ([typeString isEqualToString:@"dtd"]) {
            propertyString = @"date";
            inputFormatType = DTVCInputType_DateCell_Date;
        }
        else if ([typeString isEqualToString:@"dtdt"]) {
            propertyString = @"datetime";
            inputFormatType = DTVCInputType_DateCell_DateTime;
            
        }
        else if ([typeString isEqualToString:@"dtt"]) {
            propertyString = @"time";
            inputFormatType = DTVCInputType_DateCell_Time;
        }
        else if ([typeString isEqualToString:@"i"]) {
            propertyString = @"integer";
            inputFormatType = DTVCInputType_NumberCell_Integer;
        }
        else {
            propertyString = typeString;
            inputFormatType = DTVCInputType_SwitchCell_Bool;
        }
        return @[displayString,propertyString,[NSNumber numberWithInt:inputFormatType]];
    }
    return @[keyString,@"",[NSNumber numberWithInt:inputFormatType]];
    
}

@end
