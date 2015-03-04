//
//  OptionCell.m
//  DynamicTableGenerator
//
//  Created by tpb on 11/18/14.
//  Copyright (c) 2014 Theodore Brown. All rights reserved.
//

#import "OptionCell.h"

@implementation OptionCell

-(NSString *) reuseIdentifier {
    return DTVCCellIdentifier_OptionPickerCell;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    reuseIdentifier = [self reuseIdentifier];
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        

        self.cellButton = [UIButton newAutoLayoutView];
        //        self.cellButton.backgroundColor = [UIColor colorWithRed:1 green:0 blue:0 alpha:0.5]; // light blue
        [self.cellButton addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [self.cellButton addTarget:self action:@selector(contentWasSelected:) forControlEvents:UIControlEventTouchDown];
        [self.cellButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        [self defineContentSelector:@selector(buttonPressed:)];
        
        //set button text to display to the right, slightly offset from edge
        self.cellButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        self.cellButton.contentEdgeInsets = UIEdgeInsetsMake(0,0,0,10);
        [self.contentView addSubview:self.cellButton];
    }
    
    return self;
}


- (void) cellFormatWasUpdated {
    NSLog(@"%@ format updated", self.title.text);
}
#pragma mark - View control


- (void)updateConstraints
{
    if (!self.didSetupAcessoryConstraints) {
        // Note: if the constraints you add below require a larger cell size than the current size (which is likely to be the default size {320, 44}), you'll get an exception.
        // As a fix, you can temporarily increase the size of the cell's contentView so that this does not occur using code similar to the line below.
        //      See here for further discussion: https://github.com/Alex311/TableCellWithAutoLayout/commit/bde387b27e33605eeac3465475d2f2ff9775f163#commitcomment-4633188
        
        self.contentView.bounds = CGRectMake(0.0f, 0.0f, 99999.0f, 99999.0f);
        
        
        [UIView autoSetPriority:UILayoutPriorityRequired forConstraints:^{
            [self.cellButton autoSetContentCompressionResistancePriorityForAxis:ALAxisVertical];
        }];
        [self.cellButton autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:kLabelVerticalInsets];
        [self.cellButton autoPinEdgeToSuperviewEdge:ALEdgeTrailing withInset:kLabelHorizontalInsets];
        [self.cellButton autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:self.title withOffset:kLabelHorizontalSpace];
        
        self.didSetupAcessoryConstraints = YES;
    }
    
    [super updateConstraints];
}


-(IBAction)buttonPressed:(UIControl *)sender{
        self.resultsViewController = [[DynamicTableViewCellOptionsPickerViewController alloc] init];
        NSLog(@"Try to present %@", [self.resultsViewController description]);

        self.resultsViewController.selectedTestType = self.selectedTestType;
        [self.resultsViewController setOptionsArray:self.optionsArray];
        self.resultsViewController.resultDelegate = self;
#warning will not work if no navigation controller exits
    
    [self.resultsViewController parseDefaultSelection:self.selectedOptionsArray];

        [[self.tableViewDelegate navigationController] pushViewController:self.resultsViewController animated:YES];
//           [self presentViewController:self.resultsViewController animated:YES completion: nil];
}


-(void) resultsUpdated:(NSArray *)resultArray{
    
    [self.cellButton setTitle:[self combineStringsFromArray:resultArray] forState:UIControlStateNormal];
    if ([self.delegate respondsToSelector:@selector(cellButtonresultsUpdated:withResults:)]){
        [self.delegate cellButtonresultsUpdated:self.indexPath withResults:resultArray];
    }
    self.selectedOptionsArray = resultArray;
}

-(NSString*) combineStringsFromArray:(NSArray*) stringArray {
    NSString *finalString = [[NSString alloc] init];
    NSString* tempString = @"";
    NSInteger resultCount = [stringArray count];
    for (int i = 0; i < resultCount; i++) {
        NSLog(@"Temp:%@ item:%@",tempString,stringArray[i]);
        tempString = [tempString stringByAppendingString:(NSString*)stringArray[i]];
        if (resultCount-i ==1) { //this is the last item
            finalString = tempString;
        }
        else {
            tempString = [tempString stringByAppendingString:@", "];
        }
//        finalString = [NSString stringWithFormat:@"%@ %@,",finalString,item];

    }
    return finalString;
}
@end
