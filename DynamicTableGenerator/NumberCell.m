//
//  NumberCell.m
//  DynamicTableGenerator
//
//  Created by tpb on 11/14/14.
//  Copyright (c) 2014 Theodore Brown. All rights reserved.
//

#import "NumberCell.h"

@implementation NumberCell

-(NSString *) reuseIdentifier {
    return DTVCCellIdentifier_NumberCell;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    reuseIdentifier = [self reuseIdentifier];
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        NSDictionary * cellContentFormatDict = @{[NSNumber numberWithInt:DTVCInputType_NumberCell_Decimal]:@{@"format":@"%.2f",
                                                                                                 @"default":@"0.00",
                                                                                                 @"contentType":[NSNumber numberWithInt:UIKeyboardTypeDecimalPad]},
                                     [NSNumber numberWithInt:DTVCInputType_NumberCell_Integer]:@{@"format":@"%d",
                                                                                                 @"default":@"0",
                                                                                                 @"contentType":[NSNumber numberWithInt:UIKeyboardTypeNumberPad]},
                                     };
        [self setCellContentFormatDict:cellContentFormatDict];
        
        self.numericTextField = [UITextField newAutoLayoutView];
        [self.numericTextField addTarget:self action:@selector(contentWasSelected:) forControlEvents:UIControlEventEditingDidBegin];

        [self defineContentSelector:@selector(showKeyBoard)];

        [self.numericTextField setClearsOnBeginEditing:true];
        [self.numericTextField addTarget:self action:@selector(textFieldValueDidChange:) forControlEvents:UIControlEventEditingDidEnd];
        [self.numericTextField addTarget:self action:@selector(textFieldValueDidChange:) forControlEvents:UIControlEventEditingDidEndOnExit];
        [self.numericTextField addTarget:self action:@selector(textFieldValueDidChange:) forControlEvents:UIControlEventValueChanged];
        [self.numericTextField setTextAlignment:NSTextAlignmentRight];

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
        [self.numericTextField autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:self.title withOffset:kLabelHorizontalSpace];

        self.didSetupAcessoryConstraints = YES;
    }
    
    [super updateConstraints];
}

-(void) cellFormatWasUpdated {
    NSLog(@"%@ format type is %d",self.title.text,[self.cellContentFormatType intValue]);
    [self.numericTextField setKeyboardType:[self.cellContentFormatType intValue]];

}

//-(void) setCellFormat:(NSString *)formatString{
//    self.cellFormatString = formatString;
//    NSLog(@"Number cell format set to %@", self.cellFormatString);
//    if ([formatString isEqualToString:@"integer"]){
//        self.numberFormatString = [[self.numberPadFormatDict valueForKey:formatString] valueForKey:@"format"];
//        self.numberDefaultString =[[self.numberPadFormatDict valueForKey:formatString] valueForKey:@"default"];
//        self.numberPadMode = UIKeyboardTypeNumberPad;
//        
//    }
//    else if ([formatString isEqualToString:@"decimal"]){
//        self.numberDefaultString =[[self.numberPadFormatDict valueForKey:formatString] valueForKey:@"default"];
//        self.numberFormatString = [[self.numberPadFormatDict valueForKey:formatString] valueForKey:@"format"];
//        self.numberPadMode = UIKeyboardTypeDecimalPad;
//        
//    }
//}

-(NSString*)stringFromNumber:(NSNumber*)number {
    NSString* displayString = [[NSString alloc] init];
    NSLog(@"format %@, format str %@",self.cellContentFormatType,self.cellContentFormatString);
    if ([self.cellFormatType intValue] == DTVCInputType_NumberCell_Integer) {
        displayString = [NSString stringWithFormat:self.cellContentFormatString, [number intValue]];
    }
    else if ([self.cellFormatType intValue] == DTVCInputType_NumberCell_Decimal) {
        displayString = [NSString stringWithFormat:self.cellContentFormatString, [number floatValue]];
    }
    else {
        NSLog(@"ERROR: %d not predefined value ",[self.cellContentFormatType intValue]);
    }
    return displayString;
}

-(IBAction)textFieldValueDidChange:(id)sender {
    NSScanner *scanner = [[NSScanner alloc] initWithString:self.numericTextField.text];
    float value;
    if (![scanner scanFloat:&value]){
        value = 0;
        self.numericTextField.text = self.cellContentTitle;
    } else {
        value = [self.numericTextField.text floatValue];
    }
    NSNumber *newValue = [NSNumber numberWithFloat:value];
    self.numericTextField.text = [self stringFromNumber:newValue];
    NSLog(@"text value did change with %f, should display %@",value,[self stringFromNumber:newValue]);
    if ([self.delegate respondsToSelector:@selector(cellNumericValueDidChange::)]){
        [self.delegate cellNumericValueDidChange:self.indexPath :[NSNumber numberWithFloat:value]];
    }
}

#pragma mark -text delegate
- (void) showKeyBoard {
    [self.numericTextField becomeFirstResponder];
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    [textField resignFirstResponder];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}
@end
