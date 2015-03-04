//
//  ButtonOptionCellInput.m
//  DynamicTableGenerator
//
//  Created by Theodore Brown on 3/3/15.
//  Copyright (c) 2015 Theodore Brown. All rights reserved.
//

#import "ButtonOptionCellInput.h"

@implementation ButtonOptionCellInput
-(NSString*) cellType {
    return DTVCCellIdentifier_ButtonCell;
}
-(id) initButtonCellWithBlock:(void(^)(void))methodBlock buttonTitle:(NSString*) buttonTitle withTitle:(NSString*) cellTitle  inSection:(NSString*) newSectionHeader{
    self = [super init];
    if (self) {
        self.buttonTitle=buttonTitle;
        self.callBackBlock=methodBlock;
        self = [self initType:[self cellType] forReturnKey:nil withTitle:cellTitle inSection:newSectionHeader];
    }
    return self;
}
-(id) initButtonCellWithBlock:(void(^)(void))methodBlock withTitle:(NSString*) cellTitle  inSection:(NSString*) newSectionHeader{
    self = [super init];
    if (self) {
        self.buttonTitle=@"Restore";
        self.callBackBlock=methodBlock;
        self = [self initType:[self cellType] forReturnKey:nil withTitle:cellTitle inSection:newSectionHeader];
    }
    return self;
}

-(void)cellButtonPressed:(NSIndexPath *)indexPath{
    NSLog(@"Executing Block from cell %@ index %ld ", self.title,indexPath.row);

    self.callBackBlock();
}
@end
