//
//  DateCell.h
//  DynamicTableGenerator
//
//  Created by tpb on 11/14/14.
//  Copyright (c) 2014 Theodore Brown. All rights reserved.
//

#import "BaseCell.h"

#import "ActionSheetDatePicker.h"

@interface DateCell : BaseCell

@property (nonatomic, strong) ActionSheetDatePicker *actionSheetPicker;
@property (nonatomic, strong) UIView *actionSheetView;
@property (nonatomic, strong) UIView *actionSheetAcessoryView;

@property (nonatomic, strong) IBOutlet UIButton *dateButon;
@property (strong, nonatomic) NSDate *selectedDate;

- (IBAction)selectADate:(UIControl *)sender;
-(NSString*)stringFromDate:(NSDate*)date;


@end
