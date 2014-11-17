//
//  MutableDataCellViewControllerTableViewController.m
//  TableViewDataCells
//
//  Created by Theodore Brown on 8/9/14.
//  Copyright (c) 2014 Theodore Brown. All rights reserved.
//

#import "DynamicTableViewController.h"
#import "SharedData.h"
#import "FetchedResultsHelper.h"

#import "TableViewNavigationBar.h"

@implementation DynamicTableViewController


@synthesize optionsDelegate, cellManager;
@synthesize tagCode;
@synthesize resultDict;



- (void) setupWithInputArray:(NSArray*) cellInputArray {


        self.tagCode = [NSString stringWithFormat:@"06760"];
        self.tagOffset = 5;
    self.keyboardToolbar = [self createInputAccessoryView];
//    [self.view addSubview:self.keyboardToolbar];
//    UIView *keyView = [[UIView alloc] init];
//    [keyView addSubview:self.keyboardToolbar];
//    [keyView sizeToFit];
//    self.tableView.tableFooterView = keyView;
    self.cellManager = [[MutableTableViewCellManager alloc] initWithTagCode:self.tagCode andOffset:self.tagOffset andtableView:self.tableView withAcessoryKeys:self.keyboardToolbar andCellInputs:cellInputArray];

    
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
    self.tableView = [UITableView newAutoLayoutView];
//    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.contentInset = UIEdgeInsetsMake(0.0, 0.0, 200.0, 0.0);
    self.view.userInteractionEnabled = YES;
    [self.view addSubview:self.tableView];
	UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(saveSettings:)];
	self.navigationItem.rightBarButtonItem = addButton;
    
    
    // Self-sizing table view cells in iOS 8 require that the rowHeight property of the table view be set to the constant UITableViewAutomaticDimension
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    // Self-sizing table view cells in iOS 8 are enabled when the estimatedRowHeight property of the table view is set to a non-zero value.
    // Setting the estimated row height prevents the table view from calling tableView:heightForRowAtIndexPath: for every row in the table on first load;
    // it will only be called as cells are about to scroll onscreen. This is a major performance optimization.
    self.tableView.estimatedRowHeight = 44.0; // set this to whatever your "average" cell height is; it doesn't need to be very accurate
    NSLog(@"table view did load");
//    self.keyPadView = [[TableViewNavigationBar alloc] initWithDelegate:self  andFrame:self.view.bounds];

//    [self.view addSubview:self.keyPadView];
//    [self.view bringSubviewToFront:self.keyPadView];
}
//- (void) updateViewConstraints {
//    if (!self.didSetupConstraints) {
//        // Note: if the constraints you add below require a larger cell size than the current size (which is likely to be the default size {320, 44}), you'll get an exception.
//        // As a fix, you can temporarily increase the size of the cell's contentView so that this does not occur using code similar to the line below.
//        //      See here for further discussion: https://github.com/Alex311/TableCellWithAutoLayout/commit/bde387b27e33605eeac3465475d2f2ff9775f163#commitcomment-4633188
//        
//        [UIView autoSetPriority:UILayoutPriorityRequired forConstraints:^{
//            [self.tableView autoSetContentCompressionResistancePriorityForAxis:ALAxisHorizontal];
//        }];
//        [self.tableView autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:kLabelVerticalInsets];
//        [self.tableView autoPinEdgeToSuperviewEdge:ALEdgeLeading withInset:kLabelHorizontalInsets];
//         [self.tableView autoPinEdgeToSuperviewEdge:ALEdgeTrailing withInset:kLabelHorizontalInsets];
//        
//        
//        [self.keyboardToolbar autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.tableView withOffset:kLabelVerticalInsets];
//        
//        [UIView autoSetPriority:UILayoutPriorityRequired forConstraints:^{
//            [self.keyboardToolbar autoSetContentCompressionResistancePriorityForAxis:ALAxisVertical];
//        }];
//        [self.keyboardToolbar autoPinEdgeToSuperviewEdge:ALEdgeLeading withInset:kLabelHorizontalInsets];
//        //        [self.subTitle autoPinEdgeToSuperviewEdge:ALEdgeTrailing withInset:kLabelHorizontalInsets];
//        [self.keyboardToolbar autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:kLabelVerticalInsets];
//        
//        self.didSetupConstraints = YES;
//    }
//    
//    [super updateViewConstraints];
//}
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
    [cell setNeedsUpdateConstraints];
    [cell updateConstraintsIfNeeded];
    return cell;
}




#pragma mark - Table view delegate
- (void) contentOfCellWasSelected: (NSIndexPath *) cellIndexPath{
    NSLog(@"contentOfCellWasSelected  %@" ,[self stringForIndex:cellIndexPath]);
    if (self.currentSelection != cellIndexPath) {
        self.currentSelection = cellIndexPath;
        [self.tableView selectRowAtIndexPath:self.currentSelection animated:YES scrollPosition:UITableViewScrollPositionMiddle];
    }
}

- (void)contentSizeCategoryChanged:(NSNotification *)notification
{
    [self.tableView reloadData];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"tableView Row Selected %@" ,[self stringForIndex:indexPath]);
    self.currentSelection = indexPath;
    
}
#pragma mark -t ext delegat options

-(UIToolbar *)createInputAccessoryView
{
    UIToolbar* keyboard = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 44)];
    keyboard.barStyle = UIBarStyleDefault;
    keyboard.tintColor = [UIColor blueColor];
    UIBarButtonItem* previousButton = [[UIBarButtonItem alloc] initWithTitle:@"Previous" style:UIBarButtonItemStylePlain target:self action:@selector(gotoPrevTextfield:)];
    UIBarButtonItem* nextButton = [[UIBarButtonItem alloc] initWithTitle:@"Next" style:UIBarButtonItemStylePlain target:self action:@selector(gotoNextTextfield:)];
//    UIBarButtonItem* flexSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem* doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneTyping:)];
    [keyboard setItems:[NSArray arrayWithObjects: previousButton, nextButton, doneButton, nil] animated:NO];
    [keyboard removeFromSuperview];
    [keyboard setUserInteractionEnabled:YES];
    return keyboard;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {

    return YES;
}


#pragma mark textfield toolbar
-(void)gotoPrevTextfield: (id) sender
{
    NSLog(@"go to prev");

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
    
    [self.tableView selectRowAtIndexPath:self.currentSelection animated:YES scrollPosition: UITableViewScrollPositionMiddle];
}

-(void)gotoNextTextfield: (id) sender
{
    NSLog(@"go to next");
    //Remember to check boundaries before just setting an indexpath or your app will crash!
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
    
    [self.tableView selectRowAtIndexPath:self.currentSelection animated:YES scrollPosition: UITableViewScrollPositionMiddle];


}
-(void)doneTyping: (id) sender {
    NSLog(@"done typing");
    [self.view endEditing:YES];

}
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


#pragma mark - debug helpers

- (NSString*) stringForIndex:(NSIndexPath*)indexPath {
    NSString *pathString = [[NSString alloc] initWithFormat:@" Row: %ld Section: %ld ",(long)indexPath.row,(long)indexPath.section];
  return pathString;
}





@end
