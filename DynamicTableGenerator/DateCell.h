//
//  DateCell.h
//  DynamicTableGenerator
//
//  Created by tpb on 11/14/14.
//  Copyright (c) 2014 Theodore Brown. All rights reserved.
//

#import "BaseCell.h"
#import "TableCellEditableProtocol.h"

#import "ActionSheetDatePicker.h"

@interface DateCell : BaseCell {
    id <TableCellEditable> _delegate;
}

@property (nonatomic, strong) ActionSheetDatePicker *actionSheetPicker;
@property (nonatomic, strong) UIView *actionSheetView;

@property (nonatomic, strong) IBOutlet UIButton *dateButon;

@property (strong, nonatomic) NSDate *selectedDate;

@property (strong, nonatomic) NSDictionary *dateFormatDict;
@property (strong, nonatomic) NSString *dateFormatString;
@property (nonatomic) NSInteger datePickerMode;

- (IBAction)selectADate:(UIControl *)sender;
-(NSString*)stringFromDate:(NSDate*)date;
-(void) setDateFormat:(NSString *)formatString;

@end
