//
//  SegueOptionCellInput.m
//  DynamicTableGenerator
//
//  Created by tpb on 12/20/14.
//  Copyright (c) 2014 Theodore Brown. All rights reserved.
//

#import "SegueOptionCellInput.h"

@implementation SegueOptionCellInput
-(NSString*) cellType {
    return DTVCCellIdentifier_SegueCell;
}
-(id) initSegueOptionCellInputForVC:(id) viewController withTitle:(NSString*) cellTitle  inSection:(NSString*) newSectionHeader{
    self = [super init];
    if (self) {
        
        self = [self initType:[self cellType] forReturnKey:nil withTitle:cellTitle inSection:newSectionHeader];
        self.destinationVC = viewController;
    }
    return self;
}

@end
