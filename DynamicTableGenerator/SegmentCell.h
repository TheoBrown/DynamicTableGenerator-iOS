//
//  SegmentCell.h
//  DynamicTableGenerator
//
//  Created by tpb on 11/14/14.
//  Copyright (c) 2014 Theodore Brown. All rights reserved.
//

#import "BaseCell.h"
#import "TableCellEditableProtocol.h"

@interface SegmentCell: BaseCell



@property (nonatomic, strong) IBOutlet UISegmentedControl *cellSegment;
@property (nonatomic, strong) NSArray * segmentResults;

-(IBAction)segmentedControlChanged:(id)sender;

@end
