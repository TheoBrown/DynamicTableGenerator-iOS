//
//  SegmentCell.m
//  DynamicTableGenerator
//
//  Created by tpb on 11/14/14.
//  Copyright (c) 2014 Theodore Brown. All rights reserved.
//

#import "SegmentCell.h"

@implementation SegmentCell
-(NSString *) reuseIdentifier {
    return DTVCCellIdentifier_SegmentCell;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    reuseIdentifier = [self reuseIdentifier];
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.cellSegment = [UISegmentedControl newAutoLayoutView];
        [self.cellSegment addTarget:self action:@selector(segmentedControlChanged:) forControlEvents:UIControlEventValueChanged];
        [self.cellSegment addTarget:self action:@selector(contentWasSelected:) forControlEvents:UIControlEventTouchDown];

        [self.contentView addSubview:self.cellSegment];
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
            [self.cellSegment autoSetContentCompressionResistancePriorityForAxis:ALAxisVertical];
        }];
        [self.cellSegment autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:kLabelVerticalInsets];
        [self.cellSegment autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:kLabelVerticalInsets];
        [self.cellSegment autoPinEdge:ALEdgeLeading toEdge:ALEdgeTrailing ofView:self.title withOffset:kLabelHorizontalSpace];

        [self.cellSegment autoPinEdgeToSuperviewEdge:ALEdgeTrailing withInset:kLabelHorizontalInsets];
        
        self.didSetupAcessoryConstraints = YES;
    }
    
    [super updateConstraints];
}



-(IBAction)segmentedControlChanged:(UISegmentedControl*)sender {
    id result = [self.segmentResults objectAtIndex:sender.selectedSegmentIndex];
    if ([self.delegate respondsToSelector:@selector(cellSegmentDidChange:withObject:)]){
        [self.delegate cellSegmentDidChange:self.indexPath withObject:result];
    }
}
-(void) datedidChange{
//    NSCalendar *calendar = [NSCalendar currentCalendar];
//    NSDateComponents *components = [calendar components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit ) fromDate:[NSDate date]];
//    NSDate * startDate = [calendar dateFromComponents:components];
//    NSLog(@"Segment COntrol did change StartDate Components: %@", [startDate description]);
    
//    
//    NSDate * endDate = [calendar dateByAddingComponents:[self.segmentResults objectAtIndex:sender.selectedSegmentIndex] toDate:startDate options:0];
//    NSLog(@"EndDate Components: %@", [endDate description]);
    
//    [self.delegate cellDateSegmentDidChange:self.indexPath startDate:startDate endDate:endDate];
//    self.delegate cell
}

@end
