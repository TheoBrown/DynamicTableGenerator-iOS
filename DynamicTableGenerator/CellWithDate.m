//
//  CellWithDate.m
//  CoreDataTest
//
//  Created by Theodore Brown on 12/11/13.
//  Copyright (c) 2013 Theodore Brown. All rights reserved.
//

#import "CellWithDate.h"

@interface CellWithDate()

-(NSString*)stringFromDate:(NSDate*)date;
@end

@implementation CellWithDate

@synthesize delegate = _delegate;

@synthesize title = _title;
@synthesize subTitle = _subTitle;
@synthesize dateButon = _dateButon;
@synthesize actionSheetPicker = _actionSheetPicker;
@synthesize selectedDate;
@synthesize actionSheetView;
-(NSString *) reuseIdentifier {
    return @"DateCellID";
}

-(IBAction)dateFieldSelected:(id)sender{
    
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







