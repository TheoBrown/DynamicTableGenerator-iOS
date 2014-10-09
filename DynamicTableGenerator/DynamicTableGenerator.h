//
//  DynamicTableGenerator.h
//  DynamicTableGenerator
//
//  Created by Theodore Brown on 10/9/14.
//  Copyright (c) 2014 Theodore Brown. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DynamicTableGenerator : NSObject
/*
 Invoke segue to table view as such
 
 else if ([[segue identifier] isEqualToString:@"showExample"])
 {
 NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
 NSManagedObject *object = [[self fetchedResultsController] objectAtIndexPath:indexPath];
 //    self.objectClass = [[MutableTableViewObjects alloc] init];
 
 MutableTableViewSetupHelper * formHelper = [[MutableTableViewSetupHelper alloc] initWithObject:object];
 [[segue destinationViewController] setupWithInputArray:[formHelper cellsArray]];
 
 [[segue destinationViewController] setOptionsDelegate:self];
 }
 
*/

@end
