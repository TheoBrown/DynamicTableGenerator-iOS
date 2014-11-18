//
//  OptionCell.h
//  DynamicTableGenerator
//
//  Created by tpb on 11/18/14.
//  Copyright (c) 2014 Theodore Brown. All rights reserved.
//

#import "BaseCell.h"
#import "DynamicTableViewCellOptionsPickerViewController.h"


@interface OptionCell : BaseCell <resultArrayDelegate>

@property (nonatomic, strong) DynamicTableViewCellOptionsPickerViewController * resultsViewController;

@property (nonatomic, strong) IBOutlet UIButton *cellButton;

@property (nonatomic, retain) NSString *selectedTestType;
@property (nonatomic, retain) NSString *titleObject;

- (IBAction)buttonPressed:(UIControl *)sender;
-(void) setResultTypeFromURL:(NSURL *) objectURL;




@end







