//
//  TextOptionCellInput.m
//  TableViewDataCells
//
//  Created by Theodore Brown on 8/9/14.
//  Copyright (c) 2014 Theodore Brown. All rights reserved.
//

#import "TextOptionCellInput.h"

@implementation TextOptionCellInput

-(NSString*) cellType {
    return DTVCCellIdentifier_TextCell;
}


-(id) initTextInputForObject:(id) managedObject forReturnKey:(NSString*)newReturnKey withTitle:(NSString*) cellTitle withDefault:(NSString*) defaultText  inSection:(NSString*) newSectionHeader {
    self = [super init];
    
    if (self) {
        //        NSDictionary* settingsDictionary = @{@"Identifier":@"SliderCellID",
        //                                             @"return":@"yMinValue",
        //                                             @"settings":@{@"minValue":@-50.0f,
        //                                                           @"maxValue":@50.0f,
        //                                                           @"defaultValue":@(self.yMinValue ?:0.0f)}}
        self = [self initType:DTVCCellIdentifier_TextCell forReturnKey:newReturnKey withTitle:cellTitle inSection:newSectionHeader];

        [self createDefaultValueForObject:managedObject orValue:defaultText];
    }
    return self;
}


#pragma mark - text delegate methods

#pragma mark - editable table cell delegate methods
- (void) cellTextValueDidChange:(NSIndexPath *) cellIndexPath :(NSString *) newValue{
    NSInteger sec = [cellIndexPath section];
    NSInteger row = [cellIndexPath row];
    [self updateValue:newValue];
    [self saveObjectContext];
    
    
}
@end
