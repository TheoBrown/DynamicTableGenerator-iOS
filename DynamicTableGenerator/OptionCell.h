//
//  OptionCell.h
//  DynamicTableGenerator
//
//  Created by tpb on 11/18/14.
//  Copyright (c) 2014 Theodore Brown. All rights reserved.
//

#import "BaseCell.h"
#import "DynamicTableViewCellOptionsPickerViewController.h"

/**
 *  `OptionCell` allows picking multiple items out of an array using `DynamicTableViewCellOptionsPickerViewController`
 */
@interface OptionCell : BaseCell <resultArrayDelegate>

@property (nonatomic, strong) DynamicTableViewCellOptionsPickerViewController * resultsViewController;

@property (nonatomic, strong) IBOutlet UIButton *cellButton;

@property (nonatomic, retain) NSString *selectedTestType;
@property (nonatomic, retain) NSString *titleObject;
@property (strong, nonatomic) NSArray* optionsArray;

@property (strong, nonatomic) NSArray* selectedOptionsArray;

- (IBAction)buttonPressed:(UIControl *)sender;
-(void) setResultTypeFromURL:(NSURL *) objectURL;

-(NSString*) combineStringsFromArray:(NSArray*) stringArray;


@end







