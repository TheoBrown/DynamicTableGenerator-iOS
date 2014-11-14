//
//  SliderCell.h
//  DynamicTableGenerator
//
//  Created by tpb on 11/14/14.
//  Copyright (c) 2014 Theodore Brown. All rights reserved.
//

#import "BaseCell.h"
#import "TableCellEditableProtocol.h"

@interface SliderCell : BaseCell {
    id <TableCellEditable> _delegate;
}

@property (nonatomic, strong) IBOutlet UISlider *cellSlider;
@property (nonatomic, strong) IBOutlet UILabel *sliderLable;

- (IBAction)sliderValueChanged:(UIControl *)sender;

@end