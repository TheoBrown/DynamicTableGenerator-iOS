//
//  DateCell.m
//  DynamicTableGenerator
//
//  Created by tpb on 11/14/14.
//  Copyright (c) 2014 Theodore Brown. All rights reserved.
//

#import "DateCell.h"

@implementation DateCell

-(NSString *) reuseIdentifier {
    return @"DateCellID";
}
- (id)initWithStyle:(UITableViewCellStyle)style
{
    NSString* reuseIdentifier = [self reuseIdentifier];
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.dateButon = [UIButton newAutoLayoutView];
        [self.contentView addSubview:self.dateButon];
    }
    
    return self;
}

- (void)updateConstraints
{
    if (!self.didSetupConstraints) {
        // Note: if the constraints you add below require a larger cell size than the current size (which is likely to be the default size {320, 44}), you'll get an exception.
        // As a fix, you can temporarily increase the size of the cell's contentView so that this does not occur using code similar to the line below.
        //      See here for further discussion: https://github.com/Alex311/TableCellWithAutoLayout/commit/bde387b27e33605eeac3465475d2f2ff9775f163#commitcomment-4633188
        
        self.contentView.bounds = CGRectMake(0.0f, 0.0f, 99999.0f, 99999.0f);
        
        
        [UIView autoSetPriority:UILayoutPriorityRequired forConstraints:^{
            [self.dateButon autoSetContentCompressionResistancePriorityForAxis:ALAxisVertical];
        }];
        [self.dateButon autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:kLabelVerticalInsets];
        [self.dateButon autoPinEdgeToSuperviewEdge:ALEdgeTrailing withInset:kLabelHorizontalInsets];
        
        self.didSetupConstraints = YES;
    }
    
    [super updateConstraints];
}


- (IBAction)selectADate:(UIControl *)sender {
    if (self.selectedDate == nil)
    {
        self.selectedDate = [NSDate date];
    }
    //    NSLog(@"Select a Date called in custom cell");
    
    //    [self.delegate selectADate:sender];
    _actionSheetPicker = [[ActionSheetDatePicker alloc] initWithTitle:@"Please Select A Date" datePickerMode:UIDatePickerModeDate selectedDate:self.selectedDate target:self action:@selector(dateWasSelected:element:) origin:sender];
    //    [self.actionSheetPicker addCustomButtonWithTitle:@"Today" value:[NSDate date]];
    //    [self.actionSheetPicker addCustomButtonWithTitle:@"Yesterday" value:[[NSDate date] TC_dateByAddingCalendarUnits:NSDayCalendarUnit amount:-1]];
    self.actionSheetPicker.hideCancel = NO;
    [self.actionSheetPicker  setPickerView:self.actionSheetView];
    //    NSLog(@"Picker View set");
    [self.actionSheetPicker showActionSheetPicker];
}

- (void)dateWasSelected:(NSDate *)pickedDate element:(id)element {
    NSString *datestring = [self stringFromDate:pickedDate];
    //    NSLog(@"Date was selected as : %@", datestring);
    [self.dateButon setTitle:datestring forState:UIControlStateNormal];
    self.selectedDate = pickedDate;
    [self.delegate cellDateDidChange:self.indexPath :pickedDate];
    
    
}
-(NSString*)stringFromDate:(NSDate*)date{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MM-dd-YYYY"];
    
    //Optionally for time zone converstions
    [formatter setTimeZone:[NSTimeZone timeZoneWithName:@"..."]];
    
    NSString *tempdatestring = [formatter stringFromDate:date];
    return tempdatestring;
}

-(void) setActionSheetView: (UIView*) newview
{
    NSLog(@"actionSheetView View called with %@" ,[newview description]);
    NSLog(@" View changed from   %@" ,[self.actionSheetView description]);
    
    if (self.actionSheetView == nil){
        NSLog(@"actionSheetView does not exist yet");
        
        self.actionSheetView = newview;
        NSLog(@"actionSheetView View set");
    }
    
    
}
@end
