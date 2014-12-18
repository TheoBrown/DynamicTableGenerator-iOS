//
//  MutableDataCellViewControllerTableViewController.h
//  TableViewDataCells
//
//  Created by Theodore Brown on 8/9/14.
//  Copyright (c) 2014 Theodore Brown. All rights reserved.


//

#import <UIKit/UIKit.h>
#import "PureLayout.h"
#import "TableCellEditableProtocol.h"

#import "DynamicTableViewCellManager.h"

#import "TableViewNavigationBar.h"
#import "TableViewNavigationDelegate.h"


/**
 DynamicTableViewController manages a table view and its dynamically generated content. 
 
 Content can be created from a standard NSObject, or from a CoreData ManagedObject
 
 The object must be passed to DynamicTableViewCellManager first, parsed, and used to init this VC.
 
 */

@protocol OptionsDelegate <NSObject>
-(void)optionsWereUpdated:(NSDictionary*)optionsDictionary;

@end

@interface DynamicTableViewController : UIViewController <TableCellEditable,UITableViewDelegate,UITableViewDataSource>
{
    __weak id optionsDelegate;
}
@property (nonatomic,weak) id<OptionsDelegate> optionsDelegate;
@property (nonatomic, strong) DynamicTableViewCellManager *  cellManager;
@property (nonatomic, strong) UITableView *  tableView;

@property (nonatomic, strong) TableViewNavigationBar *  keyPad;
@property (nonatomic, strong) UIView *  keyPadView;

@property (nonatomic, strong) NSIndexPath *currentSelection;


@property (nonatomic, assign) BOOL didSetupConstraints;


@property (nonatomic, strong) NSMutableDictionary *resultDict;

- (void) setupWithInputArray:(NSArray*) cellInputArray;

@end
