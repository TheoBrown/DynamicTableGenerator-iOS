//
//  CellWithSlider.h
//  CoreDataTest
//
//  Created by Theodore Brown on 12/12/13.
//  Copyright (c) 2013 Theodore Brown. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XIBBasedTableCell.h"
#import "TableCellEditableProtocol.h"

@interface CellWithSlider : XIBBasedTableCell {
    id <TableCellEditable> _delegate;
}

@property (nonatomic, strong) id delegate;
@property (nonatomic, weak) IBOutlet UILabel *title;
@property (nonatomic, weak) IBOutlet UILabel *subTitle;
@property (nonatomic, weak) IBOutlet UISlider *cellSlider;
@property (nonatomic, weak) IBOutlet UILabel *sliderLable;

- (IBAction)sliderValueChanged:(UIControl *)sender;


@end