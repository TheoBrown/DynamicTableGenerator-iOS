//
//  DateCell.m
//  DynamicTableGenerator
//
//  Created by tpb on 11/14/14.
//  Copyright (c) 2014 Theodore Brown. All rights reserved.
//

#import "DateCell.h"

@implementation DateCell


/* date modes
 
 typedef NS_ENUM(NSInteger, UIDatePickerMode) {
 UIDatePickerModeTime,           // Displays hour, minute, and optionally AM/PM designation depending on the locale setting (e.g. 6 | 53 | PM)
 UIDatePickerModeDate,           // Displays month, day, and year depending on the locale setting (e.g. November | 15 | 2007)
 UIDatePickerModeDateAndTime,    // Displays date, hour, minute, and optionally AM/PM designation depending on the locale setting (e.g. Wed Nov 15 | 6 | 53 | PM)
 UIDatePickerModeCountDownTimer, // Displays hour and minute (e.g. 1 | 53)
 };
 
 */

-(NSString *) reuseIdentifier {
    return DTVCCellIdentifier_DateCell;
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    reuseIdentifier = [self reuseIdentifier];
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        NSDictionary *cellContentFormatDict = @{[NSNumber numberWithInt:DTVCInputType_DateCell_Date]:@{@"format":@"MM-dd-YYYY",
                                                                                       @"title":@"Select A Day",
                                                                                       @"contentType":[NSNumber numberWithInt:UIDatePickerModeDate]},
                                [NSNumber numberWithInt:DTVCInputType_DateCell_DateTime]:@{@"format":@"MM-dd-YYYY hh:mm a",
                                                                                       @"title":@"Select A Date and Time",
                                                                                       @"contentType":[NSNumber numberWithInt:UIDatePickerModeDateAndTime]},
                                [NSNumber numberWithInt:DTVCInputType_DateCell_Time]:@{@"format":@"hh:mm:ss a",
                                                                                       @"title":@"Select A Time",
                                                                                       @"contentType":[NSNumber numberWithInt:UIDatePickerModeTime]}};
        [self setCellContentFormatDict:cellContentFormatDict];
        self.dateButon = [UIButton newAutoLayoutView];
//        self.dateButon.backgroundColor = [UIColor colorWithRed:1 green:0 blue:0 alpha:0.5]; // light blue
        [self.dateButon setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.dateButon addTarget:self action:@selector(selectADate:) forControlEvents:UIControlEventTouchUpInside];
        [self.dateButon addTarget:self action:@selector(contentWasSelected:) forControlEvents:UIControlEventTouchDown];
        [self.dateButon setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];

        [self defineContentSelector:@selector(selectADate:)];
        
        //set button text to display to the right, slightly offset from edge
        self.dateButon.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        self.dateButon.contentEdgeInsets = UIEdgeInsetsMake(0,0,0,10);
        [self.contentView addSubview:self.dateButon];
    }
    
    return self;
}

//-(void) setCellFormat:(NSString *)formatString{
//    self.cellFormatString = formatString;
//    if ([formatString isEqualToString:@"date"]){
//        self.dateFormatString = [[self.dateFormatDict valueForKey:formatString] valueForKey:@"format"];
//        
//        self.datePickerMode = UIDatePickerModeDate;
//        self.datePickerTitle =[[self.dateFormatDict valueForKey:formatString] valueForKey:@"title"];
//        
//    }
//    else if ([formatString isEqualToString:@"datetime"]){
//        self.dateFormatString = [[self.dateFormatDict valueForKey:formatString] valueForKey:@"format"];
//        self.datePickerTitle =[[self.dateFormatDict valueForKey:formatString] valueForKey:@"title"];
//        
//        self.datePickerMode = UIDatePickerModeDateAndTime;
//    }
//    else if ([formatString isEqualToString:@"time"]){
//        self.dateFormatString = [[self.dateFormatDict valueForKey:formatString] valueForKey:@"format"];
//        self.datePickerTitle =[[self.dateFormatDict valueForKey:formatString] valueForKey:@"title"];
//        self.datePickerMode = UIDatePickerModeTime;
//    }
//}

- (void) cellFormatWasUpdated {
//    NSLog(@"%@ format updated", self.title.text);
}
#pragma mark - View control


- (void)updateConstraints
{
    if (!self.didSetupAcessoryConstraints) {
        // Note: if the constraints you add below require a larger cell size than the current size (which is likely to be the default size {320, 44}), you'll get an exception.
        // As a fix, you can temporarily increase the size of the cell's contentView so that this does not occur using code similar to the line below.
        //      See here for further discussion: https://github.com/Alex311/TableCellWithAutoLayout/commit/bde387b27e33605eeac3465475d2f2ff9775f163#commitcomment-4633188
        
        self.contentView.bounds = CGRectMake(0.0f, 0.0f, 99999.0f, 99999.0f);
        
        
        [UIView autoSetPriority:UILayoutPriorityRequired forConstraints:^{
            [self.dateButon autoSetContentCompressionResistancePriorityForAxis:ALAxisVertical];
        }];
        [self.dateButon autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:kLabelVerticalInsets];
        [self.dateButon autoPinEdgeToSuperviewEdge:ALEdgeTrailing withInset:kLabelHorizontalInsets];
        [self.dateButon autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:self.title withOffset:kLabelHorizontalSpace];

        self.didSetupAcessoryConstraints = YES;
    }
    
    [super updateConstraints];
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

#pragma mark - UI actions
- (IBAction)selectADate:(UIControl *)sender {
    if (self.selectedDate == nil)
    {
        self.selectedDate = [NSDate date];
    }

    
    //    NSLog(@"Select a Date called in custom cell");
    
    //    [self.delegate selectADate:sender];
    _actionSheetPicker = [[ActionSheetDatePicker alloc] initWithTitle:self.cellContentTitle datePickerMode:[self.cellContentFormatType intValue] selectedDate:self.selectedDate target:self action:@selector(dateWasSelected:element:) origin:sender];
        [self.actionSheetPicker addCustomButtonWithTitle:@"Now" value:[NSDate date]];
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
    if ([self.delegate respondsToSelector:@selector(cellDateDidChange::)]){
    [self.delegate cellDateDidChange:self.indexPath :pickedDate];
    }
    
}
-(NSString*)stringFromDate:(NSDate*)date{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:self.cellContentFormatString];
    
    //Optionally for time zone converstions
    [formatter setTimeZone:[NSTimeZone timeZoneWithName:@"..."]];
    
    NSString *tempdatestring = [formatter stringFromDate:date];
    return tempdatestring;
}


@end
