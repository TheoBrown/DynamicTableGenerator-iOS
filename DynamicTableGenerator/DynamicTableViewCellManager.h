//
//  MutableTableViewCellManager.h
//  TableViewDataCells
//
//  Created by Theodore Brown on 8/9/14.
//  Copyright (c) 2014 Theodore Brown. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

#import "TableViewNavigationBar.h"
/**
 DTV_CellManager manages a table view and its dynamically generated content.
 
 Content can be created from a standard NSObject, or from a CoreData ManagedObject
 
 The object must be passed to DynamicTableViewCellManager first, parsed, and used to init this VC.
 
 */

@interface DynamicTableViewCellManager : NSObject
@property (nonatomic, strong) UITableView *tableView; // an instance of DTVC
@property (nonatomic, strong) NSIndexPath *currentSelection;

@property (nonatomic, strong) NSArray *sectionHeaderArray;
@property (nonatomic, strong) NSDictionary *sectionDescription;

@property (nonatomic, strong) TableViewNavigationBar *  keyPad;
@property (nonatomic, strong) UIView *  keyPadView;


@property (nonatomic, strong) NSMutableDictionary *resultDict; //not used now
- (id) initWithDelegate:(id) delegate andtableView:(UITableView*) newTableView andCellInputs:(NSArray*) cellInputArray;
-(void) setupAcessoryViewForFrame:(CGRect)viewFrame withDelegate:(id) delegate;
- (UITableViewCell*)  getCellatIndexPath:(NSIndexPath *)indexPath andDelegate:(id) delegateToAssign;
- (NSInteger) rowsInSection:(NSInteger) section;

- (void) saveAllChanges;

@end
