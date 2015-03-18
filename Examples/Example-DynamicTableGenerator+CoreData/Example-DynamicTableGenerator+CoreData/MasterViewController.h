//
//  MasterViewController.h
//  Example-DynamicTableGenerator+CoreData
//
//  Created by tpb on 3/17/15.
//  Copyright (c) 2015 DirectDiagnostics. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "DynamicTableView.h"

@class DetailViewController;

@interface MasterViewController : UITableViewController <NSFetchedResultsControllerDelegate,OptionsDelegate>

@property (strong, nonatomic) DetailViewController *detailViewController;

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;


@end

