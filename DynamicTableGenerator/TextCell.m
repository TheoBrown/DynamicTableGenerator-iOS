//
//  TextCell.m
//  DynamicTableGenerator
//
//  Created by tpb on 11/14/14.
//  Copyright (c) 2014 Theodore Brown. All rights reserved.
//

#import "TextCell.h"

@implementation TextCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    NSLog(@"Text cell init called");
    reuseIdentifier = [self reuseIdentifier];
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.cellTextField = [UITextField newAutoLayoutView];
        self.cellTextField.backgroundColor = [UIColor colorWithRed:1 green:0 blue:0 alpha:0.5]; // light blue
        self.cellTextField.placeholder = @"Enter Text";
        [self.cellTextField setClearsOnBeginEditing:true];

        [self.cellTextField addTarget:self action:@selector(textFieldValueDidChange:) forControlEvents:UIControlEventEditingDidEnd];
        [self.cellTextField addTarget:self action:@selector(textFieldValueDidChange:) forControlEvents:UIControlEventEditingDidEndOnExit];
        [self.cellTextField addTarget:self action:@selector(textFieldValueDidChange:) forControlEvents:UIControlEventValueChanged];

        [self.contentView addSubview:self.cellTextField];
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
            [self.cellTextField autoSetContentCompressionResistancePriorityForAxis:ALAxisVertical];
        }];
        [self.cellTextField autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:kLabelVerticalInsets];
        [self.cellTextField autoPinEdgeToSuperviewEdge:ALEdgeTrailing withInset:kLabelHorizontalInsets];
        
        self.didSetupAcessoryConstraints = YES;
    }
    
    [super updateConstraints];
}

-(NSString *) reuseIdentifier {
    return @"TableCellWithTextCellIdentifier";
}

-(IBAction)textFieldValueDidChange:(id)sender {
    //    NSScanner *scanner = [[NSScanner alloc] initWithString:self.cellTextField.text];
    
    NSString * value = [[NSString alloc] init];
    //    if (![scanner scanString:value intoString:&value]){
    //        value = @"";
    //        self.cellTextField.text = @"";
    //    } else {
    //        value = self.cellTextField.text;
    //    }
    value = self.cellTextField.text;
    self.cellTextField.text = value;
    
    [self.delegate cellTextValueDidChange:self.indexPath :value];
}



@end
