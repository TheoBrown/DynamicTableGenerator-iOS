//
//  OptionCell.m
//  DynamicTableGenerator
//
//  Created by tpb on 11/18/14.
//  Copyright (c) 2014 Theodore Brown. All rights reserved.
//

#import "OptionCell.h"
#import "FetchedResultsHelper.h"

@implementation OptionCell

-(NSString *) reuseIdentifier {
    return DTVCCellIdentifier_ButtonCell;
}




-(IBAction)buttonPressed:(UIControl *)sender{
    if (self.selectedTestType != nil){
        self.resultsViewController = [[DynamicTableViewCellOptionsPickerViewController alloc] init];
        self.resultsViewController.selectedTestType = self.selectedTestType;
        self.resultsViewController.resultDelegate = self;
#warning will not work if no navigation controller exits

        [[self.delegate navigationController] pushViewController:self.resultsViewController animated:YES];
        NSLog(@"Try to present %@", [self.resultsViewController description]);
    }
}

-(void) setResultTypeFromURL:(NSURL *) objectURL{
    NSObject * pObject = [[FetchedResultsHelper getInstance] getObjectFromID:objectURL];
    self.selectedTestType = [pObject valueForKey:@"testType"];
}
-(void) resultsUpdated:(NSArray *)resultArray{
    
    [self.cellButton setTitle:[NSString stringWithFormat:@"%@", [resultArray description]]forState:UIControlStateNormal];
    [self.delegate cellButtonresultsUpdated:self.indexPath withResults:resultArray];
}
@end
