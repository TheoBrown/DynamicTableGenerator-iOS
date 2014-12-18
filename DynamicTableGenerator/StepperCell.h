//
//  StepperCell.h
//  DynamicTableGenerator
//
//  Created by tpb on 12/17/14.
//  Copyright (c) 2014 Theodore Brown. All rights reserved.
//

#import "BaseCell.h"

@interface StepperCell : BaseCell
@property (nonatomic, strong) IBOutlet UIStepper *cellStepper;
@property (nonatomic, strong) IBOutlet UILabel *stepperLabel;

- (IBAction)stepperValueChanged:(UIControl *)sender;
@end
