//
//  StepperCell.m
//  DynamicTableGenerator
//
//  Created by tpb on 12/17/14.
//  Copyright (c) 2014 Theodore Brown. All rights reserved.
//

#import "StepperCell.h"

@implementation StepperCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    reuseIdentifier = [self reuseIdentifier];
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.cellStepper = [UIStepper newAutoLayoutView];
        self.stepperLabel = [UILabel newAutoLayoutView];
        [self.cellStepper addTarget:self action:@selector(stepperValueChanged:) forControlEvents:UIControlEventValueChanged];
        [self.cellStepper addTarget:self action:@selector(contentWasSelected:) forControlEvents:UIControlEventTouchDown];
        [self.cellStepper addTarget:self action:@selector(contentWasSelected:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.contentView addSubview:self.cellStepper];
        [self.contentView addSubview:self.stepperLabel];
        
    }
    
    return self;
}

- (void)updateConstraints
{
    if (!self.didSetupAcessoryConstraints) {
        // Note: if the constraints you add below require a larger cell size than the current size (which is likely to be the default size {320, 44}), you'll get an exception.
        // As a fix, you can temporarily increase the size of the cell's contentView so that this does not occur using code similar to the line below.
        //      See here for further discussion: https://github.com/Alex311/TableCellWithAutoLayout/commit/bde387b27e33605eeac3465475d2f2ff9775f163#commitcomment-4633188
        
        self.contentView.bounds = CGRectMake(0.0f, 0.0f, 99999.0f, 99999.0f);
        
        
        [UIView autoSetPriority:UILayoutPriorityRequired forConstraints:^{
            [self.stepperLabel autoSetContentCompressionResistancePriorityForAxis:ALAxisVertical];
        }];
        [self.stepperLabel autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:kLabelVerticalInsets];
        [self.stepperLabel autoPinEdgeToSuperviewEdge:ALEdgeTrailing withInset:kLabelHorizontalInsets];
        
        [self.cellStepper autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:self.title withOffset:kLabelHorizontalSpace];
        
        [self.cellStepper autoPinEdge:ALEdgeRight toEdge:ALEdgeLeft ofView:self.stepperLabel withOffset:kLabelHorizontalSpace];
        [self.cellStepper autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:kLabelVerticalInsets];
        
        self.didSetupAcessoryConstraints = YES;
    }
    
    [super updateConstraints];
}

-(NSString *) reuseIdentifier {
    return DTVCCellIdentifier_SliderCell;
}

-(IBAction)stepperValueChanged:(UIStepper *)sender{
    double value = sender.value;
    self.stepperLabel.text = [NSString stringWithFormat:@"%d",(int)value];
    NSNumber * stepperValue = [NSNumber numberWithDouble:value];
    if ([self.delegate respondsToSelector:@selector(cellStepperDidChange::)]){
        [self.delegate cellStepperDidChange:self.indexPath :stepperValue];

    }
}
@end
