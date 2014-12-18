//
//  MutableDataCellViewControllerTableViewController.m
//  TableViewDataCells
//
//  Created by Theodore Brown on 8/9/14.
//  Copyright (c) 2014 Theodore Brown. All rights reserved.
//

#import "DynamicTableViewController.h"

#import "TPBLayout.h"
#import "TableViewNavigationBar.h"
#import "BaseCell.h"

#import "SharedData.h"
#import "FetchedResultsHelper.h"

@implementation DynamicTableViewController
@synthesize optionsDelegate, cellManager;
@synthesize resultDict;

#pragma mark - custom init methods
- (void) setupWithInputArray:(NSArray*) cellInputArray {
    self.cellManager = [[DynamicTableViewCellManager alloc] initWithDelegate:self andtableView:self.tableView andCellInputs:cellInputArray];
    
    NSLog(@"Dynamic Table View Controller setup with array %@" , [cellInputArray description]);
}


#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    CGFloat controlHeight = 40.0;
    CGRect tableFrame = CGRectMake(self.view.bounds.origin.x, self.view.bounds.origin.x, self.view.bounds.size.width, self.view.bounds.size.height-controlHeight);
    self.tableView = [[UITableView alloc] initWithFrame:tableFrame];
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.delegate = self;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 44.0; // set this to whatever your "average" cell height is; it doesn't need to be very accurate
    self.tableView.contentInset = UIEdgeInsetsMake(0.0, 0.0, 250.0, 0.0);
    [self.view addSubview:self.tableView];
    
	UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(saveSettings:)];
	self.navigationItem.rightBarButtonItem = addButton;
    
    [self.tableView reloadData];
    CGRect keyPadFrame = CGRectMake(self.view.bounds.origin.x, self.view.bounds.size.height-controlHeight, self.view.bounds.size.width, controlHeight);
    UIView* newView = [[UIView alloc] initWithFrame:keyPadFrame];
    [newView setBackgroundColor:[UIColor redColor]];

    self.keyPad = [[TableViewNavigationBar alloc] initWithDelegate:self andFrame:keyPadFrame];
    self.keyPadView = self.keyPad.view;
    [self.view addSubview:self.keyPadView];
    [self.view bringSubviewToFront:self.keyPadView];
}

-(UIView*) createKeysLayout {
    return nil;
}

//- (void) updateViewConstraints {
//    if (!self.didSetupConstraints) {
//        [self.view addSubview:self.keyPadView];
//
//        NSLog(@"tableView did update constraints");
//        // Note: if the constraints you add below require a larger cell size than the current size (which is likely to be the default size {320, 44}), you'll get an exception.
//        // As a fix, you can temporarily increase the size of the cell's contentView so that this does not occur using code similar to the line below.
//        //      See here for further discussion: https://github.com/Alex311/TableCellWithAutoLayout/commit/bde387b27e33605eeac3465475d2f2ff9775f163#commitcomment-4633188
//        
//        [UIView autoSetPriority:UILayoutPriorityRequired forConstraints:^{
//            [self.tableView autoSetContentCompressionResistancePriorityForAxis:ALAxisHorizontal];
//        }];
//        [self.tableView autoPinEdgeToSuperviewEdge:ALEdgeTop];
//        [self.tableView autoPinEdgeToSuperviewEdge:ALEdgeLeading];
//         [self.tableView autoPinEdgeToSuperviewEdge:ALEdgeTrailing];
//        [self.tableView autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:25+30];
//
//        NSLog(@"keypad super %@" ,[self.keyPadView.superview description]);
//        [self.keyPadView autoSetDimension:ALDimensionHeight toSize:30.0];
////        [self.keyPadView autoPinEdgeToSuperviewEdge:ALEdgeBottom];
//        [self.keyPadView autoPinEdgeToSuperviewEdge:ALEdgeLeading];
//        [self.keyPadView autoPinEdgeToSuperviewEdge:ALEdgeTrailing];
//        [self.keyPadView autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.tableView];
//        [self.keyPadView autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:25];
//
////        [self.keyboardToolbar autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.tableView withOffset:kLabelVerticalInsets];
////        
////        [UIView autoSetPriority:UILayoutPriorityRequired forConstraints:^{
////            [self.keyboardToolbar autoSetContentCompressionResistancePriorityForAxis:ALAxisVertical];
////        }];
////        [self.keyboardToolbar autoPinEdgeToSuperviewEdge:ALEdgeLeading withInset:kLabelHorizontalInsets];
////        //        [self.subTitle autoPinEdgeToSuperviewEdge:ALEdgeTrailing withInset:kLabelHorizontalInsets];
////        [self.keyboardToolbar autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:kLabelVerticalInsets];
//        
//        self.didSetupConstraints = YES;
//    }
//    
//    [super updateViewConstraints];
//}

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
//    NSLog(@"table view cellForRowAtIndexPath %@",[self stringForIndex:indexPath]);

    UITableViewCell * cell = [self.cellManager getCellatIndexPath:indexPath andDelegate:self];
    [cell setNeedsUpdateConstraints];
    [cell updateConstraintsIfNeeded];
    return cell;
}

#pragma mark - Table view delegate
- (void) contentOfCellWasSelected: (NSIndexPath *) cellIndexPath{
    NSLog(@"contentOfCellWasSelected  %@" ,[self stringForIndex:cellIndexPath]);
    if (self.currentSelection != cellIndexPath) {
        [self.view endEditing:YES];
        self.currentSelection = cellIndexPath;
        [self.tableView selectRowAtIndexPath:self.currentSelection animated:YES scrollPosition:UITableViewScrollPositionTop];
    }
}

- (void)contentSizeCategoryChanged:(NSNotification *)notification
{
    [self.tableView reloadData];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.view endEditing:YES]; // dismiss current editing views
    NSLog(@"tableView Row Selected %@" ,[self stringForIndex:indexPath]);
    self.currentSelection = indexPath;
    [self displayContentForCellAtIndex:self.currentSelection];
    
}

-(void) displayContentForCellAtIndex:(NSIndexPath*)indexPath {
    NSLog(@"displayContentForCellAtIndex %@" ,[self stringForIndex:indexPath]);
    BaseCell* selectedCell = (BaseCell*)[self.tableView cellForRowAtIndexPath:indexPath];
    [selectedCell showContentFromSelector];
}

#pragma mark - Input delegate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    return YES;
}

#pragma mark  keyboard delegate
-(void) keyboardWillChange {
    NSLog(@"keyboard frame changed");
}

-(void) keyboardWillShow {
    NSLog(@"keyboardWillShow");
    //    [[self.view viewWithTag:1] setHidden:YES];
    //    [self.keyPadView removeFromSuperview];
}
-(void) keyboardWillHide {
    NSLog(@"keyboardWillHide");
    //    [[self.view viewWithTag:1] setHidden:NO];
    //    [self.view addSubview:self.keyPadView];
    //    [self.view bringSubviewToFront:self.keyPadView];
    
}
#pragma mark - TableViewNavigationBar Implementation
-(void)gotoPrevTextfield: (id) sender
{
    [self.view endEditing:YES]; // dismiss current editing views
    
    NSInteger lastRowInSection = [self.cellManager rowsInSection:self.currentSelection.section]-1;
    NSInteger lastSection = [self.cellManager.sectionHeaderArray count]-1;
    NSInteger newRow;
    NSInteger newSection;
    
    if(self.currentSelection){
        if (self.currentSelection.row > 0) {
            newSection = self.currentSelection.section;
            newRow = self.currentSelection.row-1;
        }
        else if (self.currentSelection.row == 0) {
            if (self.currentSelection.section > 0) {
                newSection = self.currentSelection.section-1;
                newRow = [self.cellManager rowsInSection:newSection]-1;
            }
            else if (self.currentSelection.section == 0) {
                newSection = lastSection;
                newRow = [self.cellManager rowsInSection:newSection]-1;
            }
        }
        self.currentSelection = [NSIndexPath indexPathForRow:newRow  inSection:newSection];
    }
    else{
        NSLog(@"no current selection exits");
    }
    
    [self.tableView selectRowAtIndexPath:self.currentSelection animated:YES scrollPosition:UITableViewScrollPositionTop];
    [self displayContentForCellAtIndex:self.currentSelection];
}

-(void)gotoNextTextfield: (id) sender
{
    [self.view endEditing:YES]; // dismiss current editing views
    NSInteger lastRowInSection = [self.cellManager rowsInSection:self.currentSelection.section]-1;
    NSInteger lastSection = [self.cellManager.sectionHeaderArray count]-1;
    NSInteger newRow;
    NSInteger newSection;

    if(self.currentSelection){
        if (self.currentSelection.row <lastRowInSection) {
            newSection = self.currentSelection.section;
            newRow = self.currentSelection.row+1;
        }
        else if (self.currentSelection.row ==lastRowInSection) {
            if (self.currentSelection.section < lastSection) {
                newSection = self.currentSelection.section+1;
                newRow = 0;
            }
            else if (self.currentSelection.section == lastSection) {
                newSection = 0;
                newRow = 0;
            }
        }
        self.currentSelection = [NSIndexPath indexPathForRow:newRow  inSection:newSection];
    }
    else{
        NSLog(@"no current selection exits");
    }
    
    [self.tableView selectRowAtIndexPath:self.currentSelection animated:YES scrollPosition:UITableViewScrollPositionTop];
    [self displayContentForCellAtIndex:self.currentSelection];
}

-(void)doneTyping: (id) sender {
//    NSLog(@"done typing");
    [self.view endEditing:YES];

}

#pragma mark - session recording
-(void)saveCurrentEntry: (id) sender {

}

#pragma mark save options
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

#pragma mark - notifications


#pragma mark - debug helpers

- (NSString*) stringForIndex:(NSIndexPath*)indexPath {
    NSString *pathString = [[NSString alloc] initWithFormat:@" Row: %ld Section: %ld ",(long)indexPath.row,(long)indexPath.section];
  return pathString;
}

#pragma mark - required view controller  implementation
- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}
- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{    NSLog(@"table view will appear");
    
    [super viewWillAppear:animated];
}


- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    NSLog(@"table view did appear");
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillChange)
                                                 name:UIKeyboardWillChangeFrameNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    
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
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillShowNotification
                                                  object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillHideNotification
                                                  object:nil];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
@end
