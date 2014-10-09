//
//  CellWithSwitch.m
//  CoreDataTest
//
//  Created by Theodore Brown on 12/11/13.
//  Copyright (c) 2013 Theodore Brown. All rights reserved.
//

#import "CellWithSwitch.h"



@implementation CellWithSwitch

@synthesize delegate = _delegate;

@synthesize title = _title;
@synthesize subTitle = _subTitle;
@synthesize cellSwitch = _cellSwitch;

-(NSString *) reuseIdentifier {
    return @"TableCellWithSwitchCellIdentifier";
}

-(IBAction)switchDidChange:(id)sender {
    BOOL *value;
    value = self.cellSwitch.on;
    [self.delegate cellSwitchDidChange:self.indexPath:value];
}

@end