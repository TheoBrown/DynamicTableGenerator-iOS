//
//  ActionSheetCell.h
//  DynamicTableGenerator
//
//  Created by tpb on 1/27/15.
//  Copyright (c) 2015 Theodore Brown. All rights reserved.
//

#import "BaseCell.h"
#import "ActionSheetStringPicker.h"

@interface SimpleActionSheetCell : BaseCell

@property (nonatomic, strong) ActionSheetStringPicker *actionSheetPicker;
@property (nonatomic, strong) UIView *actionSheetView;
@property (nonatomic, strong) UIView *actionSheetAcessoryView;

@property (nonatomic, strong) IBOutlet UIButton *actionButton;


- (IBAction)makeSelection:(UIControl *)sender;


@property (nonatomic, retain) NSString *actionSheetTitle; //displayed label for action sheet
@property (strong, nonatomic) NSArray* optionsArray; //an array of strings that will be displayed in the action sheet
@property (strong, nonatomic) NSString *selectedResultTitle; //the chosen string from action sheet action
@property (strong, nonatomic) NSDictionary* resultsMap;

@end
