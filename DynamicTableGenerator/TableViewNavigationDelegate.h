//
//  TableViewNavigationDelegate.h
//  DynamicTableGenerator
//
//  Created by tpb on 11/16/14.
//  Copyright (c) 2014 Theodore Brown. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol TableViewNavigationDelegate <NSObject>

@optional
- (void) contentOfCellWasSelected: (NSIndexPath *) cellIndexPath;
@end
