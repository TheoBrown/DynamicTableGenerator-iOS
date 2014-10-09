//
//  TableCellWithNumber.m
//  XIBTableCells
//
//  Created by Damian on 10/03/2012.
//

#import "TableCellWithNumber.h"

@implementation TableCellWithNumber

@synthesize delegate = _delegate;

@synthesize title = _title;
@synthesize subTitle = _subTitle;
@synthesize numericTextField = _numericTextField;

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
