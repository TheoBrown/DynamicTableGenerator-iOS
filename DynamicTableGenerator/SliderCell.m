//
//  SliderCell.m
//  DynamicTableGenerator
//
//  Created by tpb on 11/14/14.
//  Copyright (c) 2014 Theodore Brown. All rights reserved.
//

#import "SliderCell.h"

@implementation SliderCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    reuseIdentifier = [self reuseIdentifier];
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.cellSlider = [UISlider newAutoLayoutView];
        self.sliderLable = [UILabel newAutoLayoutView];
        [self.cellSlider addTarget:self action:@selector(sliderValueChanged:) forControlEvents:UIControlEventValueChanged];

        [self.contentView addSubview:self.cellSlider];
        [self.contentView addSubview:self.sliderLable];

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
            [self.sliderLable autoSetContentCompressionResistancePriorityForAxis:ALAxisVertical];
        }];
        [self.sliderLable autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:kLabelVerticalInsets];
        [self.sliderLable autoPinEdgeToSuperviewEdge:ALEdgeTrailing withInset:kLabelHorizontalInsets];
        
        [self.cellSlider autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:self.title withOffset:kLabelHorizontalSpace];

        [self.cellSlider autoPinEdge:ALEdgeRight toEdge:ALEdgeLeft ofView:self.sliderLable withOffset:kLabelHorizontalSpace];
        [self.cellSlider autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:kLabelVerticalInsets];

        self.didSetupAcessoryConstraints = YES;
    }
    
    [super updateConstraints];
}

-(NSString *) reuseIdentifier {
    return @"SliderCellID";
}

-(IBAction)sliderValueChanged:(UISlider *)sender{
    float value = sender.value;
    self.sliderLable.text = [NSString stringWithFormat:@"%.2f",value];
    NSNumber * sliderValue = [NSNumber numberWithFloat:value];

    [self.delegate cellSliderDidChange:self.indexPath :sliderValue];
}
@end
