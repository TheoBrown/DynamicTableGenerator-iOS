//
//  CellWithSwitch.h
//  CoreDataTest
//
//  Created by Theodore Brown on 12/11/13.
//  Copyright (c) 2013 Theodore Brown. All rights reserved.
//


#import <UIKit/UIKit.h>

#import "XIBBasedTableCell.h"
#import "TableCellEditableProtocol.h"

@interface CellWithSwitch : XIBBasedTableCell {
    id <TableCellEditable> _delegate;
}

@property (nonatomic, strong) id delegate;

@property (nonatomic, weak) IBOutlet UILabel *title;
@property (nonatomic, weak) IBOutlet UILabel *subTitle;
@property (nonatomic, weak) IBOutlet UISwitch *cellSwitch;

-(IBAction)switchDidChange:(id)sender;

@end

