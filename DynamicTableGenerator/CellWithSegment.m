//
//  CellWithSegment.m
//  CoreDataTest
//
//  Created by Theodore Brown on 12/11/13.
//  Copyright (c) 2013 Theodore Brown. All rights reserved.
//

#import "CellWithSegment.h"

@implementation CellWithSegment

@synthesize delegate = _delegate;

@synthesize title = _title;
@synthesize subTitle = _subTitle;
@synthesize cellSegment = _cellSegment;
@synthesize segmentResults;
-(NSString *) reuseIdentifier {
    return @"SegmentCellID";
}

-(IBAction)segmentedControlChanged:(UISegmentedControl*)sender {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit ) fromDate:[NSDate date]];
    NSDate * startDate = [calendar dateFromComponents:components];
    NSLog(@"Segment COntrol did change StartDate Components: %@", [startDate description]);
    
    
    NSDate * endDate = [calendar dateByAddingComponents:[self.segmentResults objectAtIndex:sender.selectedSegmentIndex] toDate:startDate options:0];
    NSLog(@"EndDate Components: %@", [endDate description]);

    [self.delegate cellDateSegmentDidChange:self.indexPath startDate:startDate endDate:endDate];
}

@end