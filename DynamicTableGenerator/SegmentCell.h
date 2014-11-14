//
//  SegmentCell.h
//  DynamicTableGenerator
//
//  Created by tpb on 11/14/14.
//  Copyright (c) 2014 Theodore Brown. All rights reserved.
//

#import "BaseCell.h"
#import "TableCellEditableProtocol.h"

@interface SegmentCell: BaseCell {
    id <TableCellEditable> _delegate;
}

@end
