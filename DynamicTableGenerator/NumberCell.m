//
//  NumberCell.m
//  DynamicTableGenerator
//
//  Created by tpb on 11/14/14.
//  Copyright (c) 2014 Theodore Brown. All rights reserved.
//

#import "NumberCell.h"

@implementation NumberCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    reuseIdentifier = [self reuseIdentifier];
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.numericTextField = [UITextField newAutoLayoutView];
        [self.numericTextField addTarget:self action:@selector(textFieldValueDidChange:) forControlEvents:UIControlEventEditingDidEnd];
        [self.numericTextField addTarget:self action:@selector(textFieldValueDidChange:) forControlEvents:UIControlEventEditingDidEndOnExit];
        [self.numericTextField addTarget:self action:@selector(textFieldValueDidChange:) forControlEvents:UIControlEventValueChanged];
        [self.contentView addSubview:self.numericTextField];
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
            [self.numericTextField autoSetContentCompressionResistancePriorityForAxis:ALAxisVertical];
        }];
        [self.numericTextField autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:kLabelVerticalInsets];
        [self.numericTextField autoPinEdgeToSuperviewEdge:ALEdgeTrailing withInset:kLabelHorizontalInsets];
        
        self.didSetupAcessoryConstraints = YES;
    }
    
    [super updateConstraints];
}

-(NSString *) reuseIdentifier {
    return @"TableCellWithNumberCellIdentifier";
}

-(IBAction)textFieldValueDidChange:(id)sender {
    NSScanner *scanner = [[NSScanner alloc] initWithString:self.numericTextField.text];
    
    float value;
    if (![scanner scanFloat:&value]){
        value = 0;
        self.numericTextField.text = @"0.00";
    } else {
        value = [self.numericTextField.text floatValue];
    }
    
    self.numericTextField.text = [NSString stringWithFormat:@"%.2f", value];
    
    [self.delegate cellNumericValueDidChange:self.indexPath: [NSNumber numberWithFloat:value]];
}
@end
