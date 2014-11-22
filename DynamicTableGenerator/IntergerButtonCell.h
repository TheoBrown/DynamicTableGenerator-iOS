//
//  IntergerButtonCell.h
//  DynamicTableGenerator
//
//  Created by tpb on 11/21/14.
//  Copyright (c) 2014 Theodore Brown. All rights reserved.
//

#import "BaseCell.h"
#import "SegmentCell.h"

@interface IntergerButtonCell : SegmentCell

@property (nonatomic, strong) IBOutlet UILabel *segmentValueLabel;
@property (nonatomic, strong) IBOutlet NSNumber *segmentValue;

@end
