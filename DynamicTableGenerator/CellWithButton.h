//
//  CellWithButton.h
//  CoreDataTest
//
//  Created by Theodore Brown on 12/12/13.
//  Copyright (c) 2013 Theodore Brown. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XIBBasedTableCell.h"
#import "TableCellEditableProtocol.h"
#import "DynamicTableViewCellOptionsPickerViewController.h"


@interface CellWithButton : XIBBasedTableCell <resultArrayDelegate> {
    id <TableCellEditable> _delegate;
}

@property (nonatomic, strong) id delegate;
@property (nonatomic, strong) DynamicTableViewCellOptionsPickerViewController * resultsViewController;

@property (nonatomic, weak) IBOutlet UILabel *title;
@property (nonatomic, weak) IBOutlet UILabel *subTitle;
@property (nonatomic, weak) IBOutlet UIButton *cellButton;

@property (nonatomic, retain) NSString *selectedTestType;
@property (nonatomic, retain) NSString *titleObject;

- (IBAction)buttonPressed:(UIControl *)sender;

-(void) setResultTypeFromURL:(NSURL *) objectURL;

@end