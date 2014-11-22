//
//  IntergerButtonCell.m
//  DynamicTableGenerator
//
//  Created by tpb on 11/21/14.
//  Copyright (c) 2014 Theodore Brown. All rights reserved.
//

#import "IntergerButtonCell.h"

@implementation IntergerButtonCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    reuseIdentifier = [self reuseIdentifier];
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.cellSegment = [UISegmentedControl newAutoLayoutView];
        [self.cellSegment addTarget:self action:@selector(segmentedControlChanged:) forControlEvents:UIControlEventValueChanged];
        [self.cellSegment addTarget:self action:@selector(contentWasSelected:) forControlEvents:UIControlEventTouchDown];
        [self.cellSegment insertSegmentWithTitle:@"+" atIndex:0 animated:NO];
        [self.cellSegment insertSegmentWithTitle:@"-" atIndex:1 animated:NO];

        [self.contentView addSubview:self.cellSegment];
    }
    
    return self;
}
-(IBAction)segmentedControlChanged:(UISegmentedControl*)sender {
    sender.selectedSegmentIndex;
    
//    self.delegate cellSegmentIntClickerDidChange:self.indexPath withValue:<#(NSNumber *)#>
}
@end
