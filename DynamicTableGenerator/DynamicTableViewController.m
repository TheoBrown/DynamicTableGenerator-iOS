//
//  MutableDataCellViewControllerTableViewController.m
//  TableViewDataCells
//
//  Created by Theodore Brown on 8/9/14.
//  Copyright (c) 2014 Theodore Brown. All rights reserved.
//

#import "DynamicTableViewController.h"

#import "TableViewNavigationBar.h"
#import "BaseCell.h"


@implementation DynamicTableViewController
@synthesize optionsDelegate, cellManager;
@synthesize resultDict;

#pragma mark - custom init methods

-(instancetype) init {
    self = [super init];
    if (self) {
        self.useTableNavigationBar = YES;
        
    }
    return self;
}

-(instancetype) initWithCells:(NSArray*) cellInputArray  {
    self = [super init];
    if (self) {
        self.tvStyle=UITableViewStylePlain;
        self.useTableNavigationBar = YES;
        self.cellManager = [[DynamicTableViewCellManager alloc] initWithDelegate:self andtableView:self.tableView andCellInputs:cellInputArray];
    }
    return self;
}
-(instancetype) initWithCells:(NSArray*) cellInputArray forStyle:(UITableViewStyle) tvStyle {
    self = [super init];
    if (self) {
        self.tvStyle=tvStyle;

        self.useTableNavigationBar = YES;
        self.cellManager = [[DynamicTableViewCellManager alloc] initWithDelegate:self andtableView:self.tableView andCellInputs:cellInputArray];
    }
    return self;
}
- (void) setupWithInputArray:(NSArray*) cellInputArray {
    self.cellManager = [[DynamicTableViewCellManager alloc] initWithDelegate:self andtableView:self.tableView andCellInputs:cellInputArray];
//    NSLog(@"Dynamic Table View Controller setup with array %@" , [cellInputArray description]);
}

//- (BOOL)respondsToSelector:(SEL)selector {
//    /**
//     *  This ensures tableView:heightForRowAtIndexPath will only be called if we are on iOS 7
//     */
//    static BOOL useSelector;
//    static dispatch_once_t predicate = 0;
//    dispatch_once(&predicate, ^{
//        useSelector = [[UIDevice currentDevice].systemVersion floatValue] < 8.0 ? YES : NO;
//        
//    });
//    NSLog(@"use selector %d",useSelector);
//    if (selector == @selector(tableView:heightForRowAtIndexPath:)) {
//        return useSelector;
//    }
//    
//    return [super respondsToSelector:selector];
//}
#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    //check version
    if (SYSTEM_VERSION_LESS_THAN(@"8.0")){//version is 7, 6 is not supported at all
#define OS_VERSION_7 = 1
        self.tableView.estimatedRowHeight = UITableViewAutomaticDimension;
    }
    else {
        self.tableView.rowHeight = UITableViewAutomaticDimension;
        self.tableView.estimatedRowHeight = 44.0; // set this to whatever your "average" cell height is; it doesn't need to be very accurate
    };
    CGFloat controlHeight = 40.0;
    CGRect tableFrame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.x, self.view.frame.size.width, self.view.frame.size.height-controlHeight);
    self.tableView=[[UITableView alloc] initWithFrame:tableFrame style:self.tvStyle];
    self.tableView.translatesAutoresizingMaskIntoConstraints=NO;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.delegate = self;
    self.tableView.contentInset = UIEdgeInsetsMake(0.0, 0.0, 250.0, 0.0);//large offset to not cover keyboard
    [self.view addSubview:self.tableView];
	UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(saveSettings:)];
	self.navigationItem.rightBarButtonItem = addButton;
    
    [self.tableView reloadData];
    if (self.useTableNavigationBar){
        CGRect keyPadFrame = CGRectMake(self.view.frame.origin.x, self.view.frame.size.height-controlHeight, self.view.frame.size.width, controlHeight);
        UIView* newView = [[UIView alloc] initWithFrame:keyPadFrame];
        [newView setBackgroundColor:[UIColor redColor]];
        self.keyPad = [[TableViewNavigationBar alloc] initWithDelegate:self andFrame:keyPadFrame];
        self.keyPadView = self.keyPad.view;
        [self.view addSubview:self.keyPadView];
        [self.view bringSubviewToFront:self.keyPadView];
    }
    [self.cellManager setupAcessoryViewForFrame:tableFrame withDelegate:self];
    [self.view setNeedsUpdateConstraints];

    
}
-(void) viewWillAppear:(BOOL)animated {

    [super viewWillAppear:animated];
    self.tableView.scrollEnabled=YES;
//    if (self.tableView.contentSize.height < self.tableView.frame.size.height) {
//        self.tableView.scrollEnabled = NO;
//    }
//    else {
//        self.tableView.scrollEnabled = YES;
//    }
}
- (void)viewDidAppear:(BOOL)animated {
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
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didRotate:) name:UIDeviceOrientationDidChangeNotification object:nil];
}

- (void)viewDidDisappear:(BOOL)animated {
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
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIDeviceOrientationDidChangeNotification
                                                  object:nil];
}


- (void) didRotate:(NSNotification *)notification {
    UIDeviceOrientation orientation = [[UIDevice currentDevice] orientation];
    [self.view setNeedsLayout];
    [self.view setNeedsDisplay];
    [self.tableView setNeedsLayout];
    [self.tableView setNeedsDisplay];
}
- (void)contentSizeCategoryChanged:(NSNotification *)notification
{
    NSLog(@"Tableview size catagory changed");
    [self.tableView reloadData];
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return YES;
}


- (void) updateViewConstraints {
    if (!self.didSetupConstraints) {
//        [self.view addSubview:self.keyPadView];

        NSLog(@"tableView did update constraints");
        // Note: if the constraints you add below require a larger cell size than the current size (which is likely to be the default size {320, 44}), you'll get an exception.
        // As a fix, you can temporarily increase the size of the cell's contentView so that this does not occur using code similar to the line below.
        //      See here for further discussion: https://github.com/Alex311/TableCellWithAutoLayout/commit/bde387b27e33605eeac3465475d2f2ff9775f163#commitcomment-4633188
        
        [UIView autoSetPriority:UILayoutPriorityRequired forConstraints:^{
            [self.tableView autoSetContentCompressionResistancePriorityForAxis:ALAxisHorizontal];
        }];
        [self.tableView autoPinEdgeToSuperviewEdge:ALEdgeTop];
        [self.tableView autoPinEdgeToSuperviewEdge:ALEdgeLeading];
         [self.tableView autoPinEdgeToSuperviewEdge:ALEdgeTrailing];
        [self.tableView autoPinEdgeToSuperviewEdge:ALEdgeBottom];

//        NSLog(@"keypad super %@" ,[self.keyPadView.superview description]);
//        [self.keyPadView autoSetDimension:ALDimensionHeight toSize:30.0];
////        [self.keyPadView autoPinEdgeToSuperviewEdge:ALEdgeBottom];
//        [self.keyPadView autoPinEdgeToSuperviewEdge:ALEdgeLeading];
//        [self.keyPadView autoPinEdgeToSuperviewEdge:ALEdgeTrailing];
//        [self.keyPadView autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.tableView];
//        [self.keyPadView autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:25];

//        [self.keyboardToolbar autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.tableView withOffset:kLabelVerticalInsets];
//        
//        [UIView autoSetPriority:UILayoutPriorityRequired forConstraints:^{
//            [self.keyboardToolbar autoSetContentCompressionResistancePriorityForAxis:ALAxisVertical];
//        }];
//        [self.keyboardToolbar autoPinEdgeToSuperviewEdge:ALEdgeLeading withInset:kLabelHorizontalInsets];
//        //        [self.subTitle autoPinEdgeToSuperviewEdge:ALEdgeTrailing withInset:kLabelHorizontalInsets];
//        [self.keyboardToolbar autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:kLabelVerticalInsets];
        
        self.didSetupConstraints = YES;
    }
    
    [super updateViewConstraints];
}

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
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
    return [self.cellManager rowsInSection:section];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return self.cellManager.sectionHeaderArray[section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    NSLog(@"table view cellForRowAtIndexPath %@",[self stringForIndex:indexPath]);
    NSLog(@"table view loading cell at %ld",indexPath.row);

    UITableViewCell * cell = [self.cellManager getCellatIndexPath:indexPath andDelegate:self];
    NSLog(@"table view loaded cell at %@",cell);

    [cell setNeedsUpdateConstraints];
    [cell updateConstraintsIfNeeded];
    return cell;
}

#ifdef OS_VERSION_7
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // This project has only one cell identifier, but if you are have more than one, this is the time
    // to figure out which reuse identifier should be used for the cell at this index path.
    UITableViewCell* cell = [self.cellManager getCellatIndexPath:indexPath andDelegate:self];
    
    // Use the dictionary of offscreen cells to get a cell for the reuse identifier, creating a cell and storing
    // it in the dictionary if one hasn't already been added for the reuse identifier.
    // WARNING: Don't call the table view's dequeueReusableCellWithIdentifier: method here because this will result
    // in a memory leak as the cell is created but never returned from the tableView:cellForRowAtIndexPath: method!
//    RJTableViewCell *cell = [self.offscreenCells objectForKey:reuseIdentifier];
//    if (!cell) {
//        cell = [[RJTableViewCell alloc] init];
//        [self.offscreenCells setObject:cell forKey:reuseIdentifier];
//    }
    
//    // Configure the cell for this indexPath
//    [cell updateFonts];
//    NSDictionary *dataSourceItem = [self.model.dataSource objectAtIndex:indexPath.row];
//    cell.titleLabel.text =  [dataSourceItem valueForKey:@"title"];
//    cell.bodyLabel.text = [dataSourceItem valueForKey:@"body"];
    
    // Make sure the constraints have been added to this cell, since it may have just been created from scratch
    [cell setNeedsUpdateConstraints];
    [cell updateConstraintsIfNeeded];
    
    // The cell's width must be set to the same size it will end up at once it is in the table view.
    // This is important so that we'll get the correct height for different table view widths, since our cell's
    // height depends on its width due to the multi-line UILabel word wrapping. Don't need to do this above in
    // -[tableView:cellForRowAtIndexPath:] because it happens automatically when the cell is used in the table view.
    cell.bounds = CGRectMake(0.0f, 0.0f, CGRectGetWidth(tableView.bounds), CGRectGetHeight(cell.bounds));
    // NOTE: if you are displaying a section index (e.g. alphabet along the right side of the table view), or
    // if you are using a grouped table view style where cells have insets to the edges of the table view,
    // you'll need to adjust the cell.bounds.size.width to be smaller than the full width of the table view we just
    // set it to above. See http://stackoverflow.com/questions/3647242 for discussion on the section index width.
    
    // Do the layout pass on the cell, which will calculate the frames for all the views based on the constraints
    // (Note that the preferredMaxLayoutWidth is set on multi-line UILabels inside the -[layoutSubviews] method
    // in the UITableViewCell subclass
    [cell setNeedsLayout];
    [cell layoutIfNeeded];
    
    // Get the actual height required for the cell
    CGFloat height = [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
    
    // Add an extra point to the height to account for the cell separator, which is added between the bottom
    // of the cell's contentView and the bottom of the table view cell.
    height += 1;
    NSLog(@"cell at %ld hieght = %f",indexPath.row,height);
    return height;
}
#endif

// NOTE: Set the table view's estimatedRowHeight property instead of implementing the below method, UNLESS
// you have extreme variability in your row heights and you notice the scroll indicator "jumping" as you scroll.
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Do the minimal calculations required to be able to return an estimated row height that's
    // within an order of magnitude of the actual height.
    // For example:

        return 65.0f;
    
}

#pragma mark - Table view delegate
/**
 *  Selector performed by TableCell classes when the cell is clicked/selected. Automatically removes eidting windows and scrolls to the selected cell
 *
 *  @param cellIndexPath path of selected cell
 */
- (void) contentOfCellWasSelected: (NSIndexPath *) cellIndexPath{
//    NSLog(@"contentOfCellWasSelected  %@" ,[self stringForIndex:cellIndexPath]);
    if (self.currentSelection != cellIndexPath) {
        [self.view endEditing:YES];
        self.currentSelection = cellIndexPath;
        [self.tableView selectRowAtIndexPath:self.currentSelection animated:YES scrollPosition:UITableViewScrollPositionTop];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //    NSLog(@"tableView Row Selected %@" ,[self stringForIndex:indexPath]);
    [self.view endEditing:YES]; // dismiss current editing views
    self.currentSelection = indexPath;
    [self displayContentForCellAtIndex:self.currentSelection];
    
}
/**
 *  Automatically triggers the cells action via
 *
 *  @param indexPath indexPath description
 */
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
//    NSLog(@"keyboard frame changed");
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

-(void) viewWillDisappear:(BOOL)animated{
    [self.cellManager saveAllChanges];

    if([self.optionsDelegate respondsToSelector:@selector(optionsWereUpdated:)])
    {
        NSLog(@"Settings will respond");
        [self.optionsDelegate optionsWereUpdated:self.resultDict];
    }
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


@end
