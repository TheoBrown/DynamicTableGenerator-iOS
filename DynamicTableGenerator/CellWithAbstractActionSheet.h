//
//  CellWithAbstractActionSheet.h
//  CoreDataTest
//
//  Created by Theodore Brown on 12/11/13.
//  Copyright (c) 2013 Theodore Brown. All rights reserved.
//


#import <UIKit/UIKit.h>

#import "XIBBasedTableCell.h"
#import "TableCellEditableProtocol.h"
#import "ActionSheetDatePicker.h"

@class AbstractActionSheetPicker;
@interface CellWithAbstractActionSheet : XIBBasedTableCell {
    id <TableCellEditable> _delegate;
}

@property (nonatomic, strong) id delegate;
@property (nonatomic, strong) ActionSheetDatePicker *actionSheetPicker;
@property (nonatomic, strong) UIView *actionSheetView;
@property (nonatomic, strong) NSString *actionSheetTitle;
@property (nonatomic, strong) NSPredicate *actionSheetPredicate;
@property (nonatomic, strong) NSObject *predicateObject;
@property (nonatomic, strong) NSString *predicateString;
@property (strong, nonatomic) NSMutableArray *compoundPredicateArray;

@property (nonatomic, weak) IBOutlet UILabel *title;
@property (nonatomic, weak) IBOutlet UILabel *subTitle;
@property (nonatomic, weak) IBOutlet UIButton *actionButon;
@property (nonatomic, assign) NSInteger selectedIndex;
@property (strong, nonatomic) NSArray *actionSheetArray;
@property (strong, nonatomic) NSArray *fetchedResults;
@property (strong, nonatomic) NSArray *objectIDarray;

@property (nonatomic, strong) NSString *arrayEntitySortValue;
@property (nonatomic, strong) NSObject *arrayEntity;

- (IBAction)selectItem:(UIControl *)sender;
-(void) setRealPredicate:(NSString*) pString withObject:(NSObject*)pObject;
-(void) setCompoundPredicate:(NSArray*) predicateArray;
-(void) setRealPredicate:(NSString*) pString withObjectID:(NSURL*)objectURL;
-(void) setTitleFromID:(NSURL*)objectURL;
-(void) addCompoundPredicateFromString:(NSString*) pString withObjectURL:(NSURL*)objectURL;
-(void)setPredicateFromCompoundArray;
@end