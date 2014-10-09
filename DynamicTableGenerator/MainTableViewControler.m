//
//  MainTableViewControler.m
//  XIBTableCells
//
//  Created by Damian on 10/03/2012.
//

#import "MainTableViewControler.h"
#import "SharedData.h"
#import "FetchedResultsHelper.h"
@implementation MainTableViewControler
@synthesize optionsDelegate;
@synthesize optionsArray, resultDict, tagOffset, tagCode;
@synthesize updatedPredicates;
@synthesize fishTankArray,fishtankHidden;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
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
    self.fishtankHidden = FALSE;
	UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(saveSettings:)];
	self.navigationItem.rightBarButtonItem = addButton;
    self.resultDict = [[NSMutableDictionary alloc] init];
    self.updatedPredicates = [[NSMutableDictionary alloc] init];
    self.tagCode = [NSString stringWithFormat:@"06760"];
    int row, sec;
    for (sec=0; sec < [self.optionsArray count];sec++){
        for (row=0; row < [self.optionsArray[sec][1] count]; row++){
                [self.resultDict setValue:optionsArray[sec][1][row][@"settings"][@"defaultValue"]  forKey:[optionsArray[sec][1][row] valueForKey:@"return"]];
        }
    }

	// Do any additional setup after loading the view.
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
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
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
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
    return [self.optionsArray count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [optionsArray[section][1] count];
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return self.optionsArray[section][0];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    self.tagOffset = 5;
    NSString *CellIdentifier = optionsArray[indexPath.section][1][indexPath.row][@"Identifier"];
//    NSInteger tag = indexPath.section + indexPath.row;
    NSString *test = [NSString stringWithFormat:@"%d%@%d",(self.tagOffset+indexPath.section),self.tagCode, indexPath.row];
//    NSLog(@"Tag made as %@", test);
    NSInteger tag = [test integerValue];
//    NSLog(@"Tag recovered as  %ld", (long)tag);

    if ([CellIdentifier  isEqual: @"TableCellWithNumberCellIdentifier"]){
        NSLog(@"Creating CellwithID %@ at Row %d, Sec %d", CellIdentifier, [indexPath row], [indexPath section]);

        TableCellWithNumber *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = (TableCellWithNumber *)[TableCellWithNumber cellFromNibNamed:@"TableCellWithNumber"];
        }
        
        // Configure the cell...
        cell.title.text = optionsArray[indexPath.section][1][indexPath.row][@"return"];
        cell.subTitle.text = [NSString stringWithFormat:@"Row: %d, Sec: %d",[indexPath row], [indexPath section]];
        cell.numericTextField.tag = tag;
        cell.delegate = self;
        return cell;
        
    }
    else if ([CellIdentifier  isEqual: @"TableCellWithTextCellIdentifier"]){
        NSLog(@"Creating CellwithID %@ at Row %d, Sec %d", CellIdentifier, [indexPath row], [indexPath section]);

        CellWithText *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = (CellWithText *)[CellWithText cellFromNibNamed:@"CellWithText"];
        }
        
        // Configure the cell...
        cell.title.text = optionsArray[indexPath.section][1][indexPath.row][@"return"];
        cell.subTitle.text = [NSString stringWithFormat:@"Row: %d, Sec: %d",[indexPath row], [indexPath section]];
        cell.cellTextField.tag = tag;
        cell.delegate = self;
        return cell;
        
    }
    
    else if ([CellIdentifier  isEqual: @"TableCellWithSwitchCellIdentifier"]){
        NSLog(@"Creating CellwithID %@ at Row %d, Sec %d", CellIdentifier, [indexPath row], [indexPath section]);

        CellWithSwitch *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = (CellWithSwitch *)[CellWithSwitch cellFromNibNamed:@"CellWithSwitch"];
        }
        
        // Configure the cell...
        cell.title.text = optionsArray[indexPath.section][1][indexPath.row][@"return"];
        cell.subTitle.text = [NSString stringWithFormat:@"Row: %d, Sec: %d",[indexPath row], [indexPath section]];
        cell.cellSwitch.tag = tag;
        cell.delegate = self;
        return cell;
    }
    else if ([CellIdentifier  isEqual: @"DateCellID"]){
        NSLog(@"Creating CellwithID %@ at Row %d, Sec %d", CellIdentifier, [indexPath row], [indexPath section]);
        CellWithDate *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        if (cell == nil) {
            cell = (CellWithDate *)[CellWithDate cellFromNibNamed:@"CellWithDate"];
                        [cell.dateButon setTitle:[cell stringFromDate:optionsArray[indexPath.section][1][indexPath.row][@"settings"][@"defaultValue"]] forState:UIControlStateNormal];
        }

        // Configure the cell... 
        cell.title.text = optionsArray[indexPath.section][1][indexPath.row][@"return"];
        cell.subTitle.text = [NSString stringWithFormat:@"Row: %d, Sec: %d",[indexPath row], [indexPath section]];
        cell.dateButon.tag = tag;
        cell.delegate = self;
        //        UIView *dummyView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1, 1)];
        //
        //        cell.cellTextField.inputView = dummyView;
        //        if (cell.actionSheetView == nil){
        //            NSLog(@"Cell date view set to %@", [self.view description]);
        //
        //            [cell setActionSheetView:self.view];
        //
        //        }
        return cell;
    }
    else if ([CellIdentifier  isEqual: @"SliderCellID"]){
        NSLog(@"Creating CellwithID %@ at Row %d, Sec %d", CellIdentifier, [indexPath row], [indexPath section]);

        CellWithSlider *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = (CellWithSlider *)[CellWithSlider cellFromNibNamed:@"CellWithSlider"];
            cell.cellSlider.value = [optionsArray[indexPath.section][1][indexPath.row][@"settings"][@"defaultValue"] floatValue];
            cell.sliderLable.text = [NSString stringWithFormat:@"%f", [optionsArray[indexPath.section][1][indexPath.row][@"settings"][@"defaultValue"] floatValue]];

        }
        
        // Configure the cell...
        //cell.title.text = [NSString stringWithFormat:@"Row: %d", [indexPath row]];
        cell.title.text = optionsArray[indexPath.section][1][indexPath.row][@"return"];
        cell.subTitle.text = [NSString stringWithFormat:@"Row: %d, Sec: %d",[indexPath row], [indexPath section]];
        cell.cellSlider.tag = tag;
        cell.cellSlider.minimumValue = [optionsArray[indexPath.section][1][indexPath.row][@"settings"][@"minValue"]floatValue];
        cell.cellSlider.maximumValue = [optionsArray[indexPath.section][1][indexPath.row][@"settings"][@"maxValue"]floatValue];
        cell.delegate = self;


        //        UIView *dummyView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1, 1)];
        //
        //        cell.cellTextField.inputView = dummyView;
        //        if (cell.actionSheetView == nil){
        //            NSLog(@"Cell date view set to %@", [self.view description]);
        //
        //            [cell setActionSheetView:self.view];
        //
        //        }
        return cell;
    }
    else if ([CellIdentifier  isEqual: @"SegmentCellID"]){
        NSLog(@"Creating CellwithID %@ at Row %d, Sec %d", CellIdentifier, [indexPath row], [indexPath section]);

        CellWithSegment *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = (CellWithSegment *)[CellWithSegment cellFromNibNamed:@"CellWithSegment"];
        }
        
        // Configure the cell...
        cell.title.text = optionsArray[indexPath.section][1][indexPath.row][@"title"];
        cell.subTitle.text = [NSString stringWithFormat:@"Row: %d, Sec: %d",[indexPath row], [indexPath section]];
        
        NSArray * segmentResults = optionsArray[indexPath.section][1][indexPath.row][@"settings"][@"segmentResults"];
        NSArray * segmentTitles = optionsArray[indexPath.section][1][indexPath.row][@"settings"][@"segmentTitles"];
        cell.segmentResults = segmentResults;
        int count = 0;
        for (NSString * title in segmentTitles){
            if ( count < [cell.cellSegment numberOfSegments]){
                [cell.cellSegment setTitle:title forSegmentAtIndex:count];
            }
            else{
                [cell.cellSegment insertSegmentWithTitle:title atIndex:count animated:YES];

            }
            count++;
        }
//        [cell.cellSegment setTitle:@"Hour" forSegmentAtIndex:0];
//        [cell.cellSegment setTitle:@"Day" forSegmentAtIndex:1];
//        [cell.cellSegment insertSegmentWithTitle:@"Week" atIndex:2 animated:YES];
//        [cell.cellSegment insertSegmentWithTitle:@"Month" atIndex:3 animated:YES];
        //        [cell.cellSegment setTitle:@"Week" forSegmentAtIndex:2];
        //        [cell.cellSegment setTitle:@"Month" forSegmentAtIndex:3];
        
        
        cell.cellSegment.tag = tag;
        cell.delegate = self;
        return cell;
    }
    else if ([CellIdentifier  isEqual: @"ActionSheetCellID"]){
        NSLog(@"Creating CellwithID %@ at Row %d, Sec %d", CellIdentifier, [indexPath row], [indexPath section]);

        CellWithAbstractActionSheet *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        if (cell == nil) {
            cell = (CellWithAbstractActionSheet *)[CellWithAbstractActionSheet cellFromNibNamed:@"CellWithAbstractActionSheet"];
        }
        
        // Configure the cell...
        cell.title.text = optionsArray[indexPath.section][1][indexPath.row][@"return"];
        if ([optionsArray[indexPath.section][1][indexPath.row][@"return"] isEqualToString:@"selectedTank"])
        {
            self.fishTankArray = @[optionsArray[indexPath.section][1][indexPath.row],cell,indexPath];
            NSLog(@"Fishtank array created as %@" , [self.fishTankArray description]);
        }
        cell.subTitle.text = [NSString stringWithFormat:@"Row: %d, Sec: %d",[indexPath row], [indexPath section]];
        
//        cell.actionSheetPredicate = optionsArray[indexPath.section][1][indexPath.row][@"settings"][@"predicate"];
        cell.actionSheetTitle = optionsArray[indexPath.section][1][indexPath.row][@"title"];
        cell.arrayEntitySortValue = optionsArray[indexPath.section][1][indexPath.row][@"settings"][@"entitySortKey"];
        cell.arrayEntity = optionsArray[indexPath.section][1][indexPath.row][@"settings"][@"entity"];
        [cell setTitleFromID:[[[SharedData getInstance] settings] URLForKey:optionsArray[indexPath.section][1][indexPath.row][@"return"]]];
        if (self.optionsArray[indexPath.section][1][indexPath.row][@"settings"][@"prePredicates"] != nil){
            NSArray *prePredicates =self.optionsArray[indexPath.section][1][indexPath.row][@"settings"][@"prePredicates"];
            if ([self.optionsArray[indexPath.section][1][indexPath.row][@"settings"][@"predicateReference"] containsObject:@"selectedTank"])
            {
                
            }
            for(NSString *prePredicate in prePredicates){
                NSURL *predicateURLID =  [[[SharedData getInstance] settings] URLForKey:prePredicate];
                NSDictionary *prePredSettings = [self getSettingsFromOptions:prePredicate];
                NSString *prepredicateString = prePredSettings[@"predicateString"];
                [cell addCompoundPredicateFromString:prepredicateString withObjectURL:predicateURLID];
            }
            [cell setPredicateFromCompoundArray];
        }
        else {
            cell.actionSheetPredicate = [NSPredicate predicateWithFormat:optionsArray[indexPath.section][1][indexPath.row][@"settings"][@"nopredicateString"]];
        };

            
        cell.actionButon.tag = tag;
        cell.delegate = self;
        return cell;
    }
    else if ([CellIdentifier  isEqual: @"ButtonCellID"]){
        NSLog(@"Creating CellwithID %@ at Row %d, Sec %d", CellIdentifier, [indexPath row], [indexPath section]);

        CellWithButton *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        if (cell == nil) {
            cell = (CellWithButton *)[CellWithButton cellFromNibNamed:@"CellWithButton"];
        }
        
        // Configure the cell...
        cell.title.text = optionsArray[indexPath.section][1][indexPath.row][@"return"];
        cell.subTitle.text = [NSString stringWithFormat:@"Row: %d, Sec: %d",[indexPath row], [indexPath section]];
            [cell setResultTypeFromURL:[self.updatedPredicates objectForKey:optionsArray[indexPath.section][1][indexPath.row][@"return"]]];

        if (self.optionsArray[indexPath.section][1][indexPath.row][@"settings"][@"prePredicates"] != nil){
            NSArray *prePredicates =self.optionsArray[indexPath.section][1][indexPath.row][@"settings"][@"prePredicates"];
            if ([self.optionsArray[indexPath.section][1][indexPath.row][@"settings"][@"predicateReference"] containsObject:@"selectedTank"])
            {
                
            }
            for(NSString *prePredicate in prePredicates){
                NSURL *predicateURLID =  [[[SharedData getInstance] settings] URLForKey:prePredicate];
                NSDictionary *prePredSettings = [self getSettingsFromOptions:prePredicate];
                [cell setResultTypeFromURL:predicateURLID];

            }
        }
        cell.cellButton.tag = tag;
        cell.delegate = self;
        return cell;
    }
    return nil;
}



/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

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

    NSLog(@"Pre existing settings dict %@", [[[[SharedData getInstance] settings] objectForKey:@"plotSettingsDict"] description]);
//    [[[SharedData getInstance] settings] setObject:[NSDictionary dictionaryWithDictionary:self.resultDict] forKey:@"plotSettingsDict"];
    NSLog(@"NEW settings dict %@", [[[[SharedData getInstance] settings] objectForKey:@"plotSettingsDict"] description]);
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
-(NSDictionary *) getSettingsFromOptions:(NSString*) searchString{
    NSMutableArray* array= [[NSMutableArray alloc] initWithArray:self.optionsArray];
    for (NSArray * sectionArray in array){
        
        for(NSDictionary* cellDict in sectionArray[1])
        {
            if (cellDict[@"return"] ==searchString){
                NSDictionary *settings = cellDict[@"settings"];
                return settings;
                
            }
            else return nil;
            
        }
    }
    return nil;
}

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
- (void) cellNumericValueDidChange:(NSInteger)tag :(NSNumber *)value {
    NSLog(@"%d,%.2f", tag, [value floatValue]);
    NSArray *tagArray = [self decodeTag:tag];
    NSInteger sec = [tagArray[0] integerValue];
    NSInteger row = [tagArray[1] integerValue];
    
}
- (void) cellTextValueDidChange:(NSInteger)tag :(NSString *) value{
    NSLog(@"%d,%@", tag, value );
    NSArray *tagArray = [self decodeTag:tag];
    NSInteger sec = [tagArray[0] integerValue];
    NSInteger row = [tagArray[1] integerValue];
}
- (void) cellSwitchDidChange:(NSInteger)tag :(BOOL)value{
    NSLog(@"%d,%hhd", tag, value );
    NSArray *tagArray = [self decodeTag:tag];
    NSInteger sec = [tagArray[0] integerValue];
    NSInteger row = [tagArray[1] integerValue];
    NSNumber *boolNumber = [NSNumber numberWithBool:value];

    [self.resultDict setObject:boolNumber forKey:[self.optionsArray[sec][1][row] valueForKey:@"return"]];

}
- (void) cellDateDidChange: (NSInteger)tag :(NSDate*) value
{
    NSLog(@"NSDate set in Main to %@", [value description]);
    NSArray *tagArray = [self decodeTag:tag];
    NSInteger sec = [tagArray[0] integerValue];
    NSInteger row = [tagArray[1] integerValue];
    
    [self.resultDict setObject:value forKey:[self.optionsArray[sec][1][row] valueForKey:@"return"]];
//    NSLog(@"Results at MainTable: %@", [self.resultDict description]);
}

- (void) cellDateSegmentDidChange: (NSInteger)tag startDate:(NSDate*) startDate endDate:(NSDate*)endDate{
    NSLog(@"Dates did change from %@ to %@",[startDate description], [endDate description]);
    NSArray *tagArray = [self decodeTag:tag];
    NSInteger sec = [tagArray[0] integerValue];
    NSInteger row = [tagArray[1] integerValue];
    NSIndexPath *startindexPath = [NSIndexPath indexPathForRow:(row-2) inSection:sec];
        NSIndexPath *endindexPath = [NSIndexPath indexPathForRow:(row-1) inSection:sec];
    NSLog(@"Seting date display from Switch");
    CellWithDate *startDateCell = (CellWithDate *)[self.tableView cellForRowAtIndexPath:startindexPath];
    CellWithDate *endDateCell = (CellWithDate *)[self.tableView cellForRowAtIndexPath:endindexPath];
    [startDateCell.dateButon setTitle:[startDateCell stringFromDate:startDate] forState:UIControlStateNormal];
    [startDateCell.dateButon setTitle:[endDateCell stringFromDate:endDate] forState:UIControlStateNormal];
    NSLog(@"Start and End Date set");

    [self.resultDict setObject:startDate forKey:[self.optionsArray[sec][1][row] valueForKey:@"return"][0]];
    [self.resultDict setObject:endDate forKey:[self.optionsArray[sec][1][row] valueForKey:@"return"][1]];
        [[[SharedData getInstance] settings] setObject:startDate forKey:[self.optionsArray[sec][1][row] valueForKey:@"return"][0]];
        [[[SharedData getInstance] settings] setObject:endDate forKey:[self.optionsArray[sec][1][row] valueForKey:@"return"][1]];
}
-(void) cellSliderDidChange:(NSInteger)tag :(float)value{
    NSLog(@"MasterView Slider %d,%.2f", tag, value);
    NSArray *tagArray = [self decodeTag:tag];
    NSInteger sec = [tagArray[0] integerValue];
    NSInteger row = [tagArray[1] integerValue];

    [self.resultDict setObject:[NSString stringWithFormat:@"%.2f",value] forKey:[self.optionsArray[sec][1][row] valueForKey:@"return"]];
    [[[SharedData getInstance] settings] setFloat:value forKey:[self.optionsArray[sec][1][row] valueForKey:@"return"]];
}
-(NSArray*) decodeTag:(NSInteger) encodedTag{
    NSArray *listItems = [[NSString stringWithFormat:@"%d", encodedTag] componentsSeparatedByString:self.tagCode];
    NSInteger sec = [listItems[0] integerValue];
    sec = sec - self.tagOffset;
    NSInteger row = [listItems[1] integerValue];
    
    return @[[NSNumber numberWithInteger:sec],[NSNumber numberWithInteger:row]];
}
-(void) cellButtonresultsUpdated:(NSInteger)tag withResults:(NSArray *)resultArray{

        NSLog(@"MasterView Button %d , %@", tag, [resultArray description]);
        NSArray *tagArray = [self decodeTag:tag];
        NSInteger sec = [tagArray[0] integerValue];
        NSInteger row = [tagArray[1] integerValue];
        

        [self.resultDict setObject:resultArray forKey:[self.optionsArray[sec][1][row] valueForKey:@"return"]];
        [[[SharedData getInstance] settings] setObject:resultArray forKey:[self.optionsArray[sec][1][row] valueForKey:@"return"]];
}

-(void) cellAbstractActionSheetPickerDidChange:(NSInteger)tag withPredicateArray:(NSArray *)predicateArray :(NSObject *)value{
    NSLog(@"MasterView Action SHeet %d , %@", tag, [value description]);
    NSArray *tagArray = [self decodeTag:tag];
    NSInteger sec = [tagArray[0] integerValue];
    NSInteger row = [tagArray[1] integerValue];
    
    if (self.optionsArray[sec][1][row][@"settings"][@"predicateReference"] != nil)
    {
    NSString *refPred = self.optionsArray[sec][1][row][@"settings"][@"predicateReference"];
    NSLog(@"Updated Preds set for key %@ : to value:%@",refPred,[value description]);
    [self.updatedPredicates setValue:value forKey:refPred];
    NSLog(@"Up prefs: %@", [self.updatedPredicates description]);
    }
    [self.resultDict setObject:value forKey:[self.optionsArray[sec][1][row] valueForKey:@"return"]];
    [[[SharedData getInstance] settings] setObject:value forKey:[self.optionsArray[sec][1][row] valueForKey:@"return"]];
    [self.tableView reloadData];
}
-(void) cellAbstractActionSheetPickerDidChange:(NSInteger)tag withPredicateArray:(NSArray *)predicateArray withURL:(NSURL *)value{
    NSLog(@"MasterView Action SHeet %d , %@", tag, [value description]);
    NSArray *tagArray = [self decodeTag:tag];
    NSInteger sec = [tagArray[0] integerValue];
    NSInteger row = [tagArray[1] integerValue];

    

    if ([self.optionsArray[sec][1][row][@"settings"][@"predicateReference"] containsObject:@"selectedTank"])
    {

        NSObject * pObject = [[FetchedResultsHelper getInstance] getObjectFromID:value];
        if ([pObject valueForKey:@"fishtank"]  == nil)
        {
            [self.tableView beginUpdates];
            NSLog(@"Selected Object does not have fish tank, removing from view");
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row inSection:sec];
            if( !self.fishtankHidden){
                NSIndexPath *fishtankpath = self.fishTankArray[2];

                NSMutableArray *temparray = [NSMutableArray arrayWithArray:[self.optionsArray mutableCopy]];
                NSLog(@"mut arra class %@", [temparray class]);
                NSLog(@"temp array b4 delete %@", [[[[temparray objectAtIndex:fishtankpath.section] objectAtIndex:1] objectAtIndex:fishtankpath.row] description]);
                NSMutableArray *fishTankSection = [[[temparray objectAtIndex:fishtankpath.section] objectAtIndex:1] mutableCopy];
                    NSMutableArray *fishTankSectionTitle = [[temparray objectAtIndex:fishtankpath.section] mutableCopy];
                [fishTankSection removeObjectAtIndex:fishtankpath.row];
                NSLog(@"array removed from section");
                [fishTankSectionTitle setObject:fishTankSection atIndexedSubscript:1];
                NSLog(@"section set into title");

                [temparray setObject:fishTankSectionTitle atIndexedSubscript:fishtankpath.section];
                NSLog(@"title set into options array");

                NSLog(@"temp array after delete %@",[[[[temparray objectAtIndex:fishtankpath.section] objectAtIndex:1] objectAtIndex:fishtankpath.row]description]);
                [[[SharedData getInstance] settings] setObject:nil forKey:@"selectedTank"];
                self.fishtankHidden = TRUE;
                self.optionsArray = nil;
                self.optionsArray = [NSArray arrayWithArray:temparray];
                [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]  withRowAnimation:UITableViewRowAnimationFade];
            }
        }
        else{
            if (self.fishtankHidden){
                NSMutableArray *temparray = [NSMutableArray arrayWithArray:self.optionsArray];
                [temparray removeObject:self.fishTankArray[0]];
                NSIndexPath *fishtankpath = self.fishTankArray[2];
                [temparray[fishtankpath.section][1] insertObject:self.fishTankArray[0] atIndex:fishtankpath.row];
                self.optionsArray = nil;
                self.optionsArray = [NSArray arrayWithArray:temparray];
                [self.tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:fishtankpath]  withRowAnimation:UITableViewRowAnimationFade];
                self.fishtankHidden = FALSE;
            }
        }
        [self.tableView reloadData];
        
        [self.tableView endUpdates];
    }
    
    if (self.optionsArray[sec][1][row][@"settings"][@"predicateReference"] != nil)
    {
        NSString *refPred = self.optionsArray[sec][1][row][@"settings"][@"predicateReference"];
//        NSLog(@"Updated Preds set for key %@ : to value:%@",refPred,[value description]);
        [self.updatedPredicates setValue:value forKey:refPred];
//        NSLog(@"Up prefs: %@", [self.  description]);
    }
    [self.resultDict setObject:value forKey:[self.optionsArray[sec][1][row] valueForKey:@"return"]];
    [[[SharedData getInstance] settings] setURL:value forKey:[self.optionsArray[sec][1][row] valueForKey:@"return"]];

    [self.tableView reloadData];
}
@end
