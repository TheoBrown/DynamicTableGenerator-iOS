//
//  CellWithDate.h
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
@interface CellWithDate : XIBBasedTableCell {
    id <TableCellEditable> _delegate;
}

@property (nonatomic, strong) id delegate;
@property (nonatomic, strong) ActionSheetDatePicker *actionSheetPicker;
@property (nonatomic, strong) UIView *actionSheetView;

@property (nonatomic, weak) IBOutlet UILabel *title;
@property (nonatomic, weak) IBOutlet UILabel *subTitle;
@property (nonatomic, weak) IBOutlet UIButton *dateButon;
@property (strong, nonatomic) NSDate *selectedDate;
- (IBAction)selectADate:(UIControl *)sender;
-(NSString*)stringFromDate:(NSDate*)date;

@end