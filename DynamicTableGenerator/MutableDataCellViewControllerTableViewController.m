//
//  MutableDataCellViewControllerTableViewController.m
//  TableViewDataCells
//
//  Created by Theodore Brown on 8/9/14.
//  Copyright (c) 2014 Theodore Brown. All rights reserved.
//

#import "MutableDataCellViewControllerTableViewController.h"
#import "SharedData.h"
#import "FetchedResultsHelper.h"



@implementation MutableDataCellViewControllerTableViewController


@synthesize optionsDelegate, cellManager;
@synthesize tagCode;
@synthesize resultDict;


- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id) initWithCellInputArray:(NSArray*) cellInputArray {
    self = [super init];
    if (self) {
        self.tagCode = [NSString stringWithFormat:@"06760"];
        self.tagOffset = 5;
        self.cellManager = [[MutableTableViewCellManager alloc] initWithTagCode:self.tagCode andOffset:self.tagOffset andtableView:self.tableView andCellInputs:cellInputArray];
        NSLog(@"cell mutables init with array %@" , [cellInputArray description]);
    }
    return self;
}

- (void) setupWithInputArray:(NSArray*) cellInputArray {
        self.tagCode = [NSString stringWithFormat:@"06760"];
        self.tagOffset = 5;
        self.cellManager = [[MutableTableViewCellManager alloc] initWithTagCode:self.tagCode andOffset:self.tagOffset andtableView:self.tableView andCellInputs:cellInputArray];
    NSLog(@"cell mutables setu[ with array %@" , [cellInputArray description]);
}
- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];

	UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(saveSettings:)];
	self.navigationItem.rightBarButtonItem = addButton;
    
    
    // Self-sizing table view cells in iOS 8 require that the rowHeight property of the table view be set to the constant UITableViewAutomaticDimension
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    // Self-sizing table view cells in iOS 8 are enabled when the estimatedRowHeight property of the table view is set to a non-zero value.
    // Setting the estimated row height prevents the table view from calling tableView:heightForRowAtIndexPath: for every row in the table on first load;
    // it will only be called as cells are about to scroll onscreen. This is a major performance optimization.
    self.tableView.estimatedRowHeight = 44.0; // set this to whatever your "average" cell height is; it doesn't need to be very accurate
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}


- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(contentSizeCategoryChanged:)
                                                 name:UIContentSizeCategoryDidChangeNotification
                                               object:nil];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIContentSizeCategoryDidChangeNotification
                                                  object:nil];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return [self.cellManager.sectionHeaderArray count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
//    return [optionsArray[section][1] count];
    return [self.cellManager rowsInSection:section];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
//    return self.optionsArray[section][0];
    return self.cellManager.sectionHeaderArray[section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [self.cellManager getCellatIndexPath:indexPath andDelegate:self];
    return cell;
}




#pragma mark - Table view delegate
- (void)contentSizeCategoryChanged:(NSNotification *)notification
{
    [self.tableView reloadData];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

-(IBAction)saveSettings:(id)sender{
    NSLog(@"Save Settings Hit with delegate %@", [self.optionsDelegate description]);
    [self.cellManager saveAllChanges];
//    NSLog(@"Pre existing settings dict %@", [[[[SharedData getInstance] settings] objectForKey:@"plotSettingsDict"] description]);
    //    [[[SharedData getInstance] settings] setObject:[NSDictionary dictionaryWithDictionary:self.resultDict] forKey:@"plotSettingsDict"];
//    NSLog(@"NEW settings dict %@", [[[[SharedData getInstance] settings] objectForKey:@"plotSettingsDict"] description]);
    if([self.optionsDelegate respondsToSelector:@selector(optionsWereUpdated:)])
    {
        NSLog(@"Settings will respond");
        [self.optionsDelegate optionsWereUpdated:self.resultDict];
    }
    [self.navigationController popViewControllerAnimated:YES];
    //    NSLog(@"Settings dismissed with no response");
    
    //    [self dismissModalViewControllerAnimated:YES];
    
}
#pragma mark - option cell methods
//-(NSDictionary *) getSettingsFromOptions:(NSString*) searchString{
//    NSMutableArray* array= [[NSMutableArray alloc] initWithArray:self.optionsArray];
//    for (NSArray * sectionArray in array){
//        
//        for(NSDictionary* cellDict in sectionArray[1])
//        {
//            if (cellDict[@"return"] == searchString){
//                NSDictionary *settings = cellDict[@"settings"];
//                return settings;
//                
//            }
//            else return nil;
//            
//        }
//    }
//    return nil;
//}

//-(void) getPositionInArrayForReturn:(NSString*) returnString{
//    NSUInteger outerIndex = [self.optionsArray indexOfObjectPassingTest:^(id subarray, NSUInteger outerIdx, BOOL *stopOuter) {
//        NSUInteger innerIndex = [subarray indexOfObjectPassingTest:^(id obj, NSUInteger innerIdx, BOOL *stopInner) {
//            return [obj isEqual:searchTerm];
//        }];
//        return innerIndex != NSNotFound;
//    }];
//    NSUInteger indexes[] = {outerIndex, innerIndex};
//    NSIndexPath *indexPath = [NSIndexPath indexPathWithIndexes:indexes length:2];
//
//    NSUInteger idx = [pendingFriends indexOfObjectPassingTest:^(id obj, NSUInteger idx, BOOL *stop) {
//        NSString *friends = (NSString *)[pendingFriends objectAtIndex:idx];
//        NSNumber *myFloat1;
//        myFloat1 = [friends userID];
//        *stop = [myFloat1 isEqualToNumber:userIdentity];
//        return (*stop); }];
//}
#pragma mark - options cell return delegates
- (void) cellNumericValueDidChange:(NSIndexPath *) cellIndexPath :(NSNumber *)value {
    NSInteger sec = [cellIndexPath section];
    NSInteger row = [cellIndexPath row];
    
}

- (void) cellSwitchDidChange:(NSIndexPath *) cellIndexPath :(BOOL)value{
    NSInteger sec = [cellIndexPath section];
    NSInteger row = [cellIndexPath row];
    NSNumber *boolNumber = [NSNumber numberWithBool:value];
    
    //    [self.resultDict setObject:boolNumber forKey:[self.optionsArray[sec][1][row] valueForKey:@"return"]];
    
}









@end
