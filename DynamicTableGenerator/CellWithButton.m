//
//  CellWithButton.m
//  CoreDataTest
//
//  Created by Theodore Brown on 12/12/13.
//  Copyright (c) 2013 Theodore Brown. All rights reserved.
//

#import "CellWithButton.h"
#import "FetchedResultsHelper.h"
@implementation CellWithButton

@synthesize delegate = _delegate;

@synthesize title = _title;
@synthesize subTitle = _subTitle;
@synthesize cellButton = _cellButton;
@synthesize selectedTestType, resultsViewController;
@synthesize titleObject;

-(NSString *) reuseIdentifier {
    return @"ButtonCellID";
}




-(IBAction)buttonPressed:(UIControl *)sender{
    if (self.selectedTestType != nil){
        self.resultsViewController = [[ResultSelectionController alloc] init];
        self.resultsViewController.selectedTestType = self.selectedTestType;
        self.resultsViewController.resultDelegate = self;
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