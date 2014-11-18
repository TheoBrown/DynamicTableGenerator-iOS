//
//  ActionSheetOptionCellInput.h
//  TableViewDataCells
//
//  Created by Theodore Brown on 8/9/14.
//  Copyright (c) 2014 Theodore Brown. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseOptionCellInput.h"

@interface ActionSheetOptionCellInput : BaseOptionCellInput <TableCellEditable>


@property (strong, nonatomic) NSString* noPredicate;
@property (strong, nonatomic) NSString* entity;
@property (strong, nonatomic) NSString* entitySortKey;
@property (strong, nonatomic) NSString* predicateString;
@property (strong, nonatomic) NSArray* predicateReference;
@property (strong, nonatomic) NSArray* prePredicates;

@end
