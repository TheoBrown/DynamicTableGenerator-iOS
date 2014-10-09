//
//  CellWithText.m
//  CoreDataTest
//
//  Created by Theodore Brown on 12/11/13.
//  Copyright (c) 2013 Theodore Brown. All rights reserved.
//

#import "CellWithText.h"


@implementation CellWithText

@synthesize delegate = _delegate;

@synthesize title = _title;
@synthesize subTitle = _subTitle;
@synthesize cellTextField = _cellTextField;

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





//@implementation CellWithText
//
//- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
//{
//    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
//    if (self) {
//        // Initialization code
//    }
//    return self;
//}
//
//- (void)setSelected:(BOOL)selected animated:(BOOL)animated
//{
//    [super setSelected:selected animated:animated];
//
//    // Configure the view for the selected state
//}
//
//@end
