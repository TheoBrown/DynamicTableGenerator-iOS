//
//  CellWithSlider.m
//  CoreDataTest
//
//  Created by Theodore Brown on 12/12/13.
//  Copyright (c) 2013 Theodore Brown. All rights reserved.
//

#import "CellWithSlider.h"

@interface CellWithSlider ()

@end

@implementation CellWithSlider

@synthesize delegate = _delegate;
@synthesize title = _title;
@synthesize subTitle = _subTitle;
@synthesize cellSlider = _cellSlider;
@synthesize sliderLable;

-(NSString *) reuseIdentifier {
    return @"SliderCellID";
}




-(IBAction)sliderValueChanged:(UISlider *)sender{
    float value = sender.value;
    sliderLable.text = [NSString stringWithFormat:@"%.2f",value];
    [self.delegate cellSliderDidChange:self.indexPath :value];
}
@end