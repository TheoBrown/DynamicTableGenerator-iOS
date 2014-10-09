//
//  ResultSelectionController.m
//  CoreDataTest
//
//  Created by Theodore Brown on 10/14/13.
//  Copyright (c) 2013 Theodore Brown. All rights reserved.
//

#import "ResultSelectionController.h"
#import "SharedData.h"
@interface ResultSelectionController ()
-(void) setTestType:(NSString*)testType;
@end

@implementation ResultSelectionController
@synthesize arForTable = _arForTable;
@synthesize arForIPs = _arForIPs;
@synthesize selectedTestType;
@synthesize resultDelegate;
- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}




- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = selectedTestType;
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonItemStyleDone target:self action:@selector(doneButtonPressed:)];
	self.navigationItem.rightBarButtonItem = addButton;	// Do any additional setup
//    self.arForTable=[NSArray arrayWithObjects:@"Object-One",@"Object-Two",@"Object-Three",@"Object-Four",@"Object-Five", nil];
    self.arForTable = [[[[SharedData getInstance] settings] dictionaryForKey:@"resultTypes"] objectForKey:selectedTestType];

    self.arForIPs=[NSMutableArray array];

}


#pragma mark - Table view data source

-(void) setTestType:(NSString*)testType{
    self.selectedTestType = testType;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.arForTable count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    if([self.arForIPs containsObject:indexPath]){
        [cell setAccessoryType:UITableViewCellAccessoryCheckmark];
    } else {
        [cell setAccessoryType:UITableViewCellAccessoryNone];
    }
    cell.textLabel.text=[self.arForTable objectAtIndex:indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if([self.arForIPs containsObject:indexPath]){
        [self.arForIPs removeObject:indexPath];
    } else {
        [self.arForIPs addObject:indexPath];
    }
    [tableView reloadData];
}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillDisappear:(BOOL)animated{
//    NSMutableArray *selectedresulttypes = [NSMutableArray array];
//    for (NSIndexPath * path in self.arForIPs){
//        [selectedresulttypes addObject:[self.arForTable objectAtIndex:path.row]];
//    }
//    NSLog(@"Result Selection will close with : %@",selectedresulttypes);
////    share.selectedresultTypes = selectedresulttypes;
//    [[[SharedData getInstance] settings] setObject:selectedresulttypes forKey:@"selectedResultTypes"];

}

-(IBAction)doneButtonPressed:(id)sender{
    NSMutableArray *selectedresulttypes = [NSMutableArray array];
    for (NSIndexPath * path in self.arForIPs){
        [selectedresulttypes addObject:[self.arForTable objectAtIndex:path.row]];
    }
    NSLog(@"Result Selection will close with : %@",selectedresulttypes);
    //    share.selectedresultTypes = selectedresulttypes;
    [[[SharedData getInstance] settings] setObject:selectedresulttypes forKey:@"selectedResultTypes"];
    if([self.resultDelegate respondsToSelector:@selector(resultsUpdated:)])
    {
        NSLog(@"Settings will respond");
        
        [self.resultDelegate resultsUpdated:[NSArray arrayWithArray:selectedresulttypes]];
    }
    [self.navigationController popViewControllerAnimated:YES];
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
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
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

/*
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */

@end
