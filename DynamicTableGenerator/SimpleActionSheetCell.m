//
//  ActionSheetCell.m
//  DynamicTableGenerator
//
//  Created by tpb on 1/27/15.
//  Copyright (c) 2015 Theodore Brown. All rights reserved.
//

#import "SimpleActionSheetCell.h"

@implementation SimpleActionSheetCell

-(NSString *) reuseIdentifier {
    return DTVCCellIdentifier_SimpleActionCell;
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    reuseIdentifier = [self reuseIdentifier];
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
//        NSDictionary *cellContentFormatDict = @{[NSNumber numberWithInt:DTVCInputType_DateCell_Date]:@{@"format":@"MM-dd-YYYY",
//                                                                                                       @"title":@"Select A Day",
//                                                                                                       @"contentType":[NSNumber numberWithInt:UIDatePickerModeDate]},
//                                                [NSNumber numberWithInt:DTVCInputType_DateCell_DateTime]:@{@"format":@"MM-dd-YYYY hh:mm a",
//                                                                                                           @"title":@"Select A Date and Time",
//                                                                                                           @"contentType":[NSNumber numberWithInt:UIDatePickerModeDateAndTime]},
//                                                [NSNumber numberWithInt:DTVCInputType_DateCell_Time]:@{@"format":@"hh:mm:ss a",
//                                                                                                       @"title":@"Select A Time",
//                                                                                                       @"contentType":[NSNumber numberWithInt:UIDatePickerModeTime]}};
//        [self setCellContentFormatDict:cellContentFormatDict];
        
        self.actionButton = [UIButton newAutoLayoutView];
        //        self.actionButton.backgroundColor = [UIColor colorWithRed:1 green:0 blue:0 alpha:0.5]; // light blue
        [self.actionButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.actionButton addTarget:self action:@selector(makeSelection:) forControlEvents:UIControlEventTouchUpInside];
        [self.actionButton addTarget:self action:@selector(contentWasSelected:) forControlEvents:UIControlEventTouchDown];
        [self.actionButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        [self defineContentSelector:@selector(makeSelection:)];
        
        //set button text to display to the right, slightly offset from edge
        self.actionButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        self.actionButton.contentEdgeInsets = UIEdgeInsetsMake(0,0,0,10);
        [self.contentView addSubview:self.actionButton];
    }
    
    return self;
}


- (void) cellFormatWasUpdated {
    //    NSLog(@"%@ format updated", self.title.text);
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
            [self.actionButton autoSetContentCompressionResistancePriorityForAxis:ALAxisVertical];
        }];
        [self.actionButton autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:kLabelVerticalInsets];
        [self.actionButton autoPinEdgeToSuperviewEdge:ALEdgeTrailing withInset:kLabelHorizontalInsets];
        [self.actionButton autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:self.title withOffset:kLabelHorizontalSpace];
        
        self.didSetupAcessoryConstraints = YES;
    }
    
    [super updateConstraints];
}


-(void) setActionSheetView: (UIView*) newview
{
    NSLog(@"actionSheetView View called with %@" ,[newview description]);
    NSLog(@" View changed from   %@" ,[self.actionSheetView description]);
    
    if (self.actionSheetView == nil){
        NSLog(@"actionSheetView does not exist yet");
        
        self.actionSheetView = newview;
        NSLog(@"actionSheetView View set");
    }
    
    
}

#pragma mark - UI actions
- (IBAction)makeSelection:(UIControl *)sender {
    NSInteger defaultSelection;
    if ([self.optionsArray containsObject:self.selectedResultTitle]){
        defaultSelection= [self.optionsArray indexOfObject:self.selectedResultTitle];
    }
    else {
        defaultSelection=0;
    }
//    NSInteger defaultSelection = ([self.optionsArray indexOfObject:self.selectedResultTitle] > 0) ? [self.optionsArray indexOfObject:self.selectedResultTitle] : 0;
    NSString* title = self.actionSheetTitle ? self.actionSheetTitle : @"Please Make Selection";
    NSLog(@"options %@ , title %@, default %ld",[self.optionsArray description],title,(long)defaultSelection);
    [ActionSheetStringPicker showPickerWithTitle:title
                                            rows:self.optionsArray
                                initialSelection:defaultSelection
                                       doneBlock:^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue) {
                                           [self optionWasSelected:selectedIndex];

                                       }
                                     cancelBlock:^(ActionSheetStringPicker *picker) {
                                         NSLog(@"Block Picker Canceled");
                                     }
                                          origin:self];
}

-(void) optionWasSelected:(NSInteger) selectedIndex {
    
    self.selectedResultTitle=[self.optionsArray objectAtIndex:selectedIndex];
    [self.actionButton setTitle:self.selectedResultTitle forState:UIControlStateNormal];
    
    if ([self.cellFormatType intValue] == DTVCInputType_SimpleActionSheetCell_Index) {
        if ([self.delegate respondsToSelector:@selector(cellSimpleActionSheetDidChange:withIndex:)]){
            [self.delegate cellSimpleActionSheetDidChange:self.indexPath withIndex:selectedIndex];

        }
    }
    else if ([self.cellFormatType intValue] == DTVCInputType_SimpleActionSheetCell_String) {
        if ([self.delegate respondsToSelector:@selector(cellSimpleActionSheetDidChange:withString:)]){
        [self.delegate cellSimpleActionSheetDidChange:self.indexPath withString:self.selectedResultTitle];
        }
    }
    else if ([self.cellFormatType intValue] == DTVCInputType_SimpleActionSheetCell_DictMap) {
        if ([self.delegate respondsToSelector:@selector(cellSimpleActionSheetDidChange:withObject:)]){
        [self.delegate cellSimpleActionSheetDidChange:self.indexPath withObject:[self.resultsMap objectForKey:self.selectedResultTitle]];
        }
    }
    else {
        NSLog(@"ERROR: %d not predefined value ",[self.cellContentFormatType intValue]);
    }
    

//    switch (selectedIndex) {
//        case 0:
//            [CompositionInstructions sharedInstance].compositionOrientation=UIInterfaceOrientationPortrait;
//            break;
//        case 1:
//            [CompositionInstructions sharedInstance].compositionOrientation=UIInterfaceOrientationLandscapeLeft;
//            break;
//        case 2:
//            [CompositionInstructions sharedInstance].compositionOrientation=UIInterfaceOrientationLandscapeRight;
//            break;
//        default:
//            break;
//    }
}


@end
