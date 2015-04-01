//
//  DynamicTableViewConstants.h
//  DynamicTableGenerator
//
//  Created by tpb on 11/17/14.
//  Copyright (c) 2014 Theodore Brown. All rights reserved.
//

#import <Foundation/Foundation.h>

#ifndef DynamicTableGenerator_DynamicTableViewConstants_h
#define DynamicTableGenerator_DynamicTableViewConstants_h


#endif

//Version Macros
#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)


extern NSString * const DTVCCellIdentifier_DateCell;
extern NSString * const DTVCCellIdentifier_SliderCell;
extern NSString * const DTVCCellIdentifier_OptionPickerCell;
extern NSString * const DTVCCellIdentifier_ActionCell;
extern NSString * const DTVCCellIdentifier_SimpleActionCell;
extern NSString * const DTVCCellIdentifier_WebLinkCell;
extern NSString * const DTVCCellIdentifier_PurchaseCell;
extern NSString * const DTVCCellIdentifier_ButtonCell;
extern NSString * const DTVCCellIdentifier_TextCell;
extern NSString * const DTVCCellIdentifier_NumberCell;
extern NSString * const DTVCCellIdentifier_SwitchCell;
extern NSString * const DTVCCellIdentifier_SegmentCell;
extern NSString * const DTVCCellIdentifier_StepperCell;
extern NSString * const DTVCCellIdentifier_SegueCell;

typedef NS_ENUM(NSInteger, DTVCCellType)
{
     DTVCCellType_DateCell = 1,
     DTVCCellType_SliderCell,
     DTVCCellType_ButtonCell,
     DTVCCellType_ActionCell,
     DTVCCellType_TextCell,
     DTVCCellType_NumberCell,
     DTVCCellType_SwitchCell,
     DTVCCellType_SegmentCell,
     DTVCCellType_StepperCell,
     DTVCCellType_OptionPickerCell
};

typedef NS_ENUM(NSInteger, DTVCInputType_SwitchCell)
{
DTVCInputType_SwitchCell_Bool = 1,
};

typedef NS_ENUM(NSInteger, DTVCInputType_SliderCell)
{
    DTVCInputType_SliderCell_Float = 1,
    DTVCInputType_SliderCell_Integer
};

typedef NS_ENUM(NSInteger, DTVCInputType_NumberCell)
{
    DTVCInputType_NumberCell_Integer = 1,
    DTVCInputType_NumberCell_Decimal
};
typedef NS_ENUM(NSInteger, DTVCInputType_TextCell)
{
    DTVCInputType_TextCell_Alphabet = 1,
    DTVCInputType_TextCell_Ascii,
    DTVCInputType_TextCell_URL,
    DTVCInputType_TextCell_Email,
    DTVCInputType_TextCell_Phone
};
typedef NS_ENUM(NSInteger, DTVCInputType_DateCell)
{
    DTVCInputType_DateCell_Date = 1,
    DTVCInputType_DateCell_DateTime,
    DTVCInputType_DateCell_Time
};
typedef NS_ENUM(NSInteger, DTVCInputType_SegmentCell)
{
    DTVCInputType_SegmentCell_Object = 1,
};
typedef NS_ENUM(NSInteger, DTVCInputType_OptionPickerCell)
{
    DTVCInputType_OptionPicker_Array = 1,
};
typedef NS_ENUM(NSInteger, DTVCInputType_StepperCell)
{
    DTVCInputType_StepperCell_Interger = 1,
};
typedef NS_ENUM(NSInteger, DTVCInputType_SimpleActionSheetCell)
{
    DTVCInputType_SimpleActionSheetCell_String = 1,
    DTVCInputType_SimpleActionSheetCell_Index,
    DTVCInputType_SimpleActionSheetCell_DictMap,
};
