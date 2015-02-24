//
//  TextCell.m
//  DynamicTableGenerator
//
//  Created by tpb on 11/14/14.
//  Copyright (c) 2014 Theodore Brown. All rights reserved.
//

#import "TextCell.h"

@implementation TextCell

-(NSString *) reuseIdentifier {
    return DTVCCellIdentifier_TextCell;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
//    NSLog(@"Text cell init called");
    reuseIdentifier = [self reuseIdentifier];
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        NSDictionary * cellContentFormatDict = @{[NSNumber numberWithInt:DTVCInputType_TextCell_Email]:@{@"format":@"%.2f",
                                                                                           @"default":@"Enter Email",
                                                                                           @"contentType":[NSNumber numberWithInt:UIKeyboardTypeEmailAddress]},
                                   [NSNumber numberWithInt:DTVCInputType_TextCell_Alphabet]:@{@"format":@"%d",
                                                                                              @"default":@"Enter Text",
                                                                                              @"contentType":[NSNumber numberWithInt:UIKeyboardTypeAlphabet]},
                                   [NSNumber numberWithInt:DTVCInputType_TextCell_Ascii]:@{@"format":@"%d",
                                                                                           @"default":@"Enter Text",
                                                                                           @"contentType":[NSNumber numberWithInt:UIKeyboardTypeASCIICapable]},
                                   [NSNumber numberWithInt:DTVCInputType_TextCell_URL]:@{@"format":@"%d",
                                                                                           @"default":@"Enter URL",
                                                                                           @"contentType":[NSNumber numberWithInt:UIKeyboardTypeURL]},
                                   [NSNumber numberWithInt:DTVCInputType_TextCell_Phone]:@{@"format":@"%d",
                                                                                           @"default":@"Enter Phone Number",
                                                                                           @"contentType":[NSNumber numberWithInt:UIKeyboardTypePhonePad]},
                                   };
        
        [self setCellContentFormatDict:cellContentFormatDict];
        self.cellTextField = [UITextField newAutoLayoutView];
        
//        self.cellTextField.backgroundColor = [UIColor colorWithRed:1 green:0 blue:0 alpha:0.5]; // light blue
        [self.cellTextField setClearsOnBeginEditing:true];
        [self.cellTextField addTarget:self action:@selector(contentWasSelected:) forControlEvents:UIControlEventEditingDidBegin];

        [self.cellTextField addTarget:self action:@selector(textFieldValueDidChange:) forControlEvents:UIControlEventEditingDidEnd];
        [self.cellTextField addTarget:self action:@selector(textFieldValueDidChange:) forControlEvents:UIControlEventEditingDidEndOnExit];
        [self.cellTextField addTarget:self action:@selector(textFieldValueDidChange:) forControlEvents:UIControlEventValueChanged];

        [self defineContentSelector:@selector(showKeyBoard)];

        [self.cellTextField setTextAlignment:NSTextAlignmentRight];
        [self.contentView addSubview:self.cellTextField];
    }
    
    return self;
}

#pragma mark view updates
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
        [self.cellTextField autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:self.title withOffset:kLabelHorizontalSpace];
        
        self.didSetupAcessoryConstraints = YES;
    }
    
    [super updateConstraints];
}

#pragma mark - action control


- (void) cellFormatWasUpdated {
//    NSLog(@"%@ format updated", self.title.text);
    self.cellTextField.placeholder = self.cellContentTitle;
    [self.cellTextField setKeyboardType:[self.cellContentFormatType intValue]];
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
    if ([self.delegate respondsToSelector:@selector(cellTextValueDidChange::)]){
        [self.delegate cellTextValueDidChange:self.indexPath :value];

    }
}

#pragma mark -delegat methods for text entry
#pragma text field delegates
- (void) showKeyBoard {
    [self.cellTextField becomeFirstResponder];
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    [textField resignFirstResponder];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}
@end
