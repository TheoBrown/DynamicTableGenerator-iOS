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
@synthesize cellsArray;

#pragma mark - init methods
//TODO different init for ManagedObject or NSObject..or NSDictionary??
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
    //this is the main method that initializes the array
    NSDictionary *properties = [PropertyUtil classPropsFor:[formObject class]];
    NSLog(@"Properties for class %@: %@",[[formObject class] debugDescription], properties);
    self.cellsArray = [self createInputFormForTargetObject:properties];
}


/*   Example Properties returned
 
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


-(NSArray*) createInputFormForTargetObject: (NSDictionary *) targeObjectPropertyDict{
    
    NSMutableArray *tempCellsArray = [[NSMutableArray alloc] init];
    NSMutableDictionary *displaynames = [[NSMutableDictionary alloc] init];
    NSLog(@"%@" ,[targeObjectPropertyDict description]);
    
    for (NSString* key in targeObjectPropertyDict){ //key is the raw property name, displayName is a cleaned up version converted to look nice
        
        NSArray * cellAttributeInfo = [self parseCellInfoFromAttributeName:key andAttributeClass:[targeObjectPropertyDict objectForKey:key]];

        NSString* cleanPropertyName = cellAttributeInfo[0];
        int cellType = [cellAttributeInfo[1] intValue];
//        int cellFormatType = [cellAttributeInfo[2] intValue];
        NSNumber* cellFormatType = cellAttributeInfo[2];

        NSString *displayName =[self displayStringForParameterName:cleanPropertyName];
        [displaynames setObject:displayName forKey:key];
        
        NSLog(@"%@ property %@ key type %d format %@",displayName,key,cellType,cellFormatType);
        
        if (cellType ==DTVCCellType_TextCell){
            NSLog(@"new text cell");
            TextOptionCellInput* newTextCell = [[TextOptionCellInput alloc] initInputClassforObject:self.mutableFormObject forReturnKey:key withTitle:displayName inSection:@"text section"];
            [newTextCell defineCellInputFormatType:cellFormatType];
            [tempCellsArray addObject:newTextCell];
        }
        else if (cellType ==DTVCCellType_DateCell) {
            NSLog(@"new date cell");

            DateOptionCellInput *newDateCell = [[DateOptionCellInput alloc] initInputClassforObject:self.mutableFormObject forReturnKey:key withTitle:displayName inSection:@"dates section"];
            [newDateCell defineCellInputFormatType:cellFormatType];
            [tempCellsArray addObject:newDateCell];
        }
        else if (cellType ==DTVCCellType_NumberCell) {
            NSLog(@"new number cell");

            NumberOptionCellInput* newNumberCell = [[NumberOptionCellInput alloc] initInputClassforObject:self.mutableFormObject forReturnKey:key withTitle:displayName inSection:@"number section"];
            [newNumberCell defineCellInputFormatType:cellFormatType];
            [tempCellsArray addObject:newNumberCell];
        }
        else if (cellType ==DTVCCellType_ButtonCell) {
            NSArray* defoptionsArray = @[@"Blue",@"Green",@"Red",@"Orange"];
            ButtonOptionCellInput* newOptionCell = [[ButtonOptionCellInput alloc] initOptionInputForObject:self.mutableFormObject forReturnKey:key withTitle:displayName withOptions:defoptionsArray inSection:@"Options Section"];
            [newOptionCell defineCellInputFormatType:cellFormatType];
            [tempCellsArray addObject:newOptionCell];
        }
        else if (cellType ==DTVCCellType_ActionCell) {
            // this can be linked to a fetched result picker
        }
        else if (cellType ==DTVCCellType_SliderCell) { // value is float
            NSLog(@"new slider cell");

            SliderOptionCellInput *newCell = [[SliderOptionCellInput alloc] initFloatSliderInputForObject:self.mutableFormObject forReturnKey:key withTitle:displayName withDefault:[NSNumber numberWithFloat:0.5] withMaxValue:[NSNumber numberWithFloat:1] andMinValue:[NSNumber numberWithFloat:0] inSection:@"number section"];
            [tempCellsArray addObject:newCell];
        }
        else if (cellType ==DTVCCellType_SwitchCell) { // bool
            NSLog(@"new switch cell");

            SwitchOptionCellInput *newCell = [[SwitchOptionCellInput alloc] initInputClassforObject:self.mutableFormObject forReturnKey:key withTitle:displayName inSection:@"number section"];
            [tempCellsArray addObject:newCell];
        }
    }
    self.attributeNameMapDict = [[NSDictionary alloc] initWithDictionary:displaynames];//maps the clean title to the attribute name -- the key is the attribute name
    self.targetAttributeNameList = [[NSArray alloc] initWithArray:[displaynames allKeys]]; //an array of the clean titles for the TV to show
    return [[NSArray alloc] initWithArray:tempCellsArray];
}

#pragma mark  - property type parsing from attribute name

-(NSArray*) extractDTV_AttributeStringFromPropertyName:(NSString*)keyString {
    NSString * typeString = [NSString new];
    NSString * displayString = [NSString new];
    
    if ([keyString rangeOfString:@"__"].location != NSNotFound) {
        NSArray *listItems = [keyString componentsSeparatedByString:@"__"];
        typeString = listItems[1];
        displayString = [NSString stringWithFormat:@"%@",listItems[0]];
    }
    else {
        displayString = keyString;
    }
    return @[displayString,typeString];
    
}



-(NSArray*)parseCellInfoFromAttributeName:(NSString*) attributeName andAttributeClass:(NSString*) attributeClassString {
    
    NSArray * parsedAttributeName = [self extractDTV_AttributeStringFromPropertyName:attributeName];
    NSString * cleanAttributeName =parsedAttributeName[0];
    NSString * DTVC_typeString =parsedAttributeName[1];
    
    int cellType = 0;
    int cellFormatType = 0;
    
    
    if ([attributeClassString  isEqual: @"NSString"]){
        cellType = DTVCCellType_TextCell;

        if (DTVC_typeString.length){ //checks is string is empty
            NSLog(@"text with format %@",DTVC_typeString);

            NSArray* updatedCellInfo = [self parseNSStringEntryTypes:DTVC_typeString];
            cellType = [updatedCellInfo[0] intValue];
            cellFormatType = [updatedCellInfo[1] intValue];
        }
    }
    
    else if ([attributeClassString isEqual:@"NSDate"]) {
        cellType = DTVCCellType_DateCell;

        if (DTVC_typeString.length){ //checks is string is empty
            NSLog(@"date with format %@",DTVC_typeString);

            NSArray* updatedCellInfo = [self parseNSDateEntryTypes:DTVC_typeString];
            cellType = [updatedCellInfo[0] intValue];
            cellFormatType = [updatedCellInfo[1] intValue];
        }
    }
    else if ([attributeClassString isEqual:@"NSNumber"]) {
        
        cellType = DTVCCellType_NumberCell;
        cellType = DTVCInputType_NumberCell_Decimal;
        
        if (DTVC_typeString.length){ //checks is string is empty
            NSLog(@"number with format %@",DTVC_typeString);

            NSArray* updatedCellInfo = [self parsedNSNumberEntryTypes:DTVC_typeString];
            cellType = [updatedCellInfo[0] intValue];
            cellFormatType = [updatedCellInfo[1] intValue];
        }
        NSLog(@"number with type %d %d ",cellType,cellFormatType);

    }
    else if ([attributeClassString isEqual:@"NSDecimalNumber"]) { // NSDecimalNumber
        cellType = DTVCCellType_NumberCell;
        cellFormatType = DTVCInputType_NumberCell_Decimal;
    }
    else if ([attributeClassString isEqual:@"f"]) { // value is float
        cellType = DTVCCellType_SliderCell;
        cellFormatType = 0;
        
    }
    else if ([attributeClassString isEqual:@"d"]) { //CGFloat
        cellType = DTVCCellType_NumberCell;
        cellFormatType = DTVCInputType_NumberCell_Decimal;
        
    }
    else if ([attributeClassString isEqual:@"q"]) { // NSInteger
        cellType = DTVCCellType_NumberCell;
        cellFormatType = DTVCInputType_NumberCell_Integer;
        
    }
    else if ([attributeClassString isEqual:@"B"]) { // bool
        cellType = DTVCCellType_SwitchCell;
        cellFormatType = 0;
    }
    else if ([attributeClassString isEqual:@"NSObject"]) {
        //What to do with blank object?
    }
    else if ([attributeClassString isEqual:@"NSArray"]) {
        cellType = DTVCCellType_ButtonCell;
        cellFormatType = 0;
    }
    else if ([attributeClassString isEqual:@"NSSet"]) {
        // this can be linked to a fetched result picker
        cellType = DTVCCellType_ActionCell;
        cellFormatType = 0;
    }
    else {
        NSLog(@"attribute class stirng %@ not recognized ",attributeClassString);
    }
    //create cellType
    return @[cleanAttributeName,[NSNumber numberWithInt:cellType],[NSNumber numberWithInt:cellFormatType]];
    
}

#pragma mark - Object Attribute Name Parsing

-(NSString*) displayStringForParameterName:(NSString*)keyString {
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

#pragma mark - clean parse object attributes

-(NSArray*) parseNSDateEntryTypes:(NSString*) parsedPropertyType {
    int cellType = 0;
    int cellFormatType = 0;
    if ([parsedPropertyType isEqualToString:@"dtd"]) {
        cellType =DTVCCellType_DateCell;
        cellFormatType = DTVCInputType_DateCell_Date;
    }
    else if ([parsedPropertyType isEqualToString:@"dtdt"]) {
        cellType =DTVCCellType_DateCell;
        cellFormatType = DTVCInputType_DateCell_DateTime;
    }
    else if ([parsedPropertyType isEqualToString:@"dtt"]) {
        cellType =DTVCCellType_DateCell;
        cellFormatType = DTVCInputType_DateCell_Time;
    }
    else {
        cellType =DTVCCellType_DateCell;
        cellFormatType = DTVCInputType_DateCell_Time;
    }
    return @[[NSNumber numberWithInt:cellType],[NSNumber numberWithInt:cellFormatType]];;
}

-(NSArray*) parseNSStringEntryTypes:(NSString*) parsedPropertyType {
    int cellType = 0;
    int cellFormatType = 0;
    
    if ([parsedPropertyType isEqualToString:@"a"]) {
        cellType =DTVCCellType_TextCell;
        cellFormatType = DTVCInputType_TextCell_Ascii;
    }
    else if ([parsedPropertyType isEqualToString:@"abc"]) {
        cellType =DTVCCellType_TextCell;
        cellFormatType = DTVCInputType_TextCell_Alphabet;
    }
    else if ([parsedPropertyType isEqualToString:@"e"]) {
        cellType =DTVCCellType_TextCell;
        cellFormatType = DTVCInputType_TextCell_Email;
    }
    else if ([parsedPropertyType isEqualToString:@"u"]) {
        cellType =DTVCCellType_TextCell;
        cellFormatType = DTVCInputType_TextCell_URL;
    }
    else if ([parsedPropertyType isEqualToString:@"p"]) {
        cellType =DTVCCellType_TextCell;
        cellFormatType = DTVCInputType_TextCell_Phone;
    }
    else {
        cellType =DTVCCellType_TextCell;
        cellFormatType = DTVCInputType_TextCell_Ascii;
    }
    return @[[NSNumber numberWithInt:cellType],[NSNumber numberWithInt:cellFormatType]];;
}

-(NSArray*) parsedNSNumberEntryTypes:(NSString*) parsedPropertyType {
    int cellType = 0;
    int cellFormatType = 0;
    if ([[parsedPropertyType lowercaseString] isEqualToString:@"b"]) {
        cellType = DTVCCellType_SwitchCell;
        cellFormatType = 0; //switch has no format
    }
    else if ([parsedPropertyType isEqualToString:@"f"]) {
        NSLog(@"ns numer set to slider");
        cellType = DTVCCellType_SliderCell;
        cellFormatType = 0; //slider has no format
    }
    else if ([parsedPropertyType isEqualToString:@"d"]) {
        cellType = DTVCCellType_NumberCell;
        cellFormatType = DTVCInputType_NumberCell_Decimal;
    }
    else if ([parsedPropertyType isEqualToString:@"i"]) {
        cellType = DTVCCellType_NumberCell;
        cellFormatType = DTVCInputType_NumberCell_Integer;
    }
    else {
        cellType = DTVCCellType_NumberCell;
        cellFormatType = DTVCInputType_NumberCell_Decimal;
    }
    return @[[NSNumber numberWithInt:cellType],[NSNumber numberWithInt:cellFormatType]];
}

#pragma mark - debugging tests

-(int) parseDTVNumberEntryTypes:(NSString*) parsedPropertyType {
    int returnInputEnumType = 0;
    NSString * propertyTypeString = [NSString new];
    if ([parsedPropertyType isEqualToString:@"B"]) {
        propertyTypeString = @"B";
        
    }
    else if ([parsedPropertyType isEqualToString:@"f"]) {
        propertyTypeString = @"f";
    }
    else if ([parsedPropertyType isEqualToString:@"d"]) {
        returnInputEnumType = DTVCInputType_NumberCell_Decimal;
    }
    else if ([parsedPropertyType isEqualToString:@"i"]) {
        returnInputEnumType = DTVCInputType_NumberCell_Integer;
    }
    else {
        returnInputEnumType = DTVCInputType_TextCell_Ascii;
    }
    return returnInputEnumType;
}

-(void) cellForType:(int) cellType {
    switch (cellType) {
        case DTVCCellType_TextCell: {
            
        }
            break;
        case DTVCCellType_NumberCell:
            //
            break;
        case DTVCCellType_DateCell:
            //
            break;
        case DTVCCellType_SwitchCell:
            //
            break;
        case DTVCCellType_SliderCell:
            //
            break;
        case DTVCCellType_ButtonCell:
            //
            break;
        case DTVCCellType_ActionCell:
            //
            break;
        default:
            break;
    }
    
}


//-(NSArray*) populateTableInfo: (NSDictionary *) info{
//    NSMutableArray *tempCellsArray = [[NSMutableArray alloc] init];
//    NSMutableDictionary *displaynames = [[NSMutableDictionary alloc] init];
//    NSLog(@"%@" ,[info description]);
//    
//    for (NSString* key in info){ //key is the raw property name, displayName is a cleaned up version converted to look nice
//        
//        [self parseCellInfoFromAttributeName:key andAttributeClass:[info objectForKey:key]];
//        
//        NSString* propertyTypeString = [info objectForKey:key];
//        NSLog(@" key = %@, propStr = %@",key,propertyTypeString);
//        
//        NSArray * parsedPropertys = [self parseTypeFromStringFormat:key];
//        NSLog(@"parsed propertys are %@",parsedPropertys);
//        
//        NSString* cleanPropertyName = parsedPropertys[0];
//        NSString* parsedPropertyType = parsedPropertys[1];
//        int inputFormatType = [parsedPropertys[2] intValue];
//        
//        NSString *displayName =[self displayStringForParameterName:cleanPropertyName];
//        [displaynames setObject:displayName forKey:key];
//        NSLog(@"%@ key property type %@ format %d",displayName,propertyTypeString,inputFormatType);
//        
//        
//        if ([propertyTypeString  isEqual: @"NSString"]){
//            
//            int inputFormatType = [self parseDTVTextEntryTypes:parsedPropertyType];
//            TextOptionCellInput* newTextCell = [[TextOptionCellInput alloc] initInputClassforObject:self.mutableFormObject forReturnKey:key withTitle:displayName inSection:@"text section"];
//            [newTextCell defineCellInputFormatType:[NSNumber numberWithInt:inputFormatType]];
//            [tempCellsArray addObject:newTextCell];
//        }
//        
//        else if ([propertyTypeString isEqual:@"NSDate"]) {
//            DateOptionCellInput *newDateCell = [[DateOptionCellInput alloc] initInputClassforObject:self.mutableFormObject forReturnKey:key withTitle:displayName inSection:@"dates section"];
//            
//            [newDateCell defineCellInputFormatType:[NSNumber numberWithInt:inputFormatType]];
//            
//            [tempCellsArray addObject:newDateCell];
//            
//        }
//        else if ([propertyTypeString isEqual:@"NSNumber"]) {
//            NumberOptionCellInput* newNumberCell = [[NumberOptionCellInput alloc] initInputClassforObject:self.mutableFormObject forReturnKey:key withTitle:displayName inSection:@"number section"];
//            
//            int inputFormatType = [self parseDTVTextEntryTypes:parsedPropertyType];
//            [newNumberCell defineCellInputFormatType:[NSNumber numberWithInt:inputFormatType]];
//            [tempCellsArray addObject:newNumberCell];
//            
//        }
//        else if ([propertyTypeString isEqual:@"NSObject"]) {
//            //What to do with blank object?
//        }
//        else if ([propertyTypeString isEqual:@"NSArray"]) {
//            NSArray* defoptionsArray = @[@"Blue",@"Green",@"Red",@"Orange"];
//            ButtonOptionCellInput* newOptionCell = [[ButtonOptionCellInput alloc] initOptionInputForObject:self.mutableFormObject forReturnKey:key withTitle:displayName withOptions:defoptionsArray inSection:@"Options Section"];
//            [newOptionCell defineCellInputFormatType:[NSNumber numberWithInt:inputFormatType]];
//            [tempCellsArray addObject:newOptionCell];
//        }
//        else if ([propertyTypeString isEqual:@"NSSet"]) {
//            // this can be linked to a fetched result picker
//        }
//        else if ([propertyTypeString isEqual:@"f"]) { // value is float
//            SliderOptionCellInput *newCell = [[SliderOptionCellInput alloc] initFloatSliderInputForObject:self.mutableFormObject forReturnKey:key withTitle:displayName withDefault:[NSNumber numberWithFloat:0.5] withMaxValue:[NSNumber numberWithFloat:1] andMinValue:[NSNumber numberWithFloat:0] inSection:@"number section"];
//            [tempCellsArray addObject:newCell];
//        }
//        else if ([propertyTypeString isEqual:@"d"]) { //CGFloat
//            
//        }
//        else if ([propertyTypeString isEqual:@"q"]) { // NSInteger
//            
//        }
//        else if ([propertyTypeString isEqual:@"NSDecimalNumber"]) { // NSDecimalNumber
//            
//        }
//        else if ([propertyTypeString isEqual:@"B"]) { // bool
//            SwitchOptionCellInput *newCell = [[SwitchOptionCellInput alloc] initInputClassforObject:self.mutableFormObject forReturnKey:key withTitle:displayName inSection:@"number section"];
//            [tempCellsArray addObject:newCell];
//        }
//    }
//    self.attributeNameMapDict = [[NSDictionary alloc] initWithDictionary:displaynames];//maps the clean title to the attribute name -- the key is the attribute name
//    self.targetAttributeNameList = [[NSArray alloc] initWithArray:[displaynames allKeys]]; //an array of the clean titles for the TV to show
//    return [[NSArray alloc] initWithArray:tempCellsArray];
//}
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
            inputFormatType = 0;
        }
        return @[displayString,propertyString,[NSNumber numberWithInt:inputFormatType]];
    }
    return @[keyString,@"",[NSNumber numberWithInt:inputFormatType]];
    
}
@end
