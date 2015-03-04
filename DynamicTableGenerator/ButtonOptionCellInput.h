//
//  ButtonOptionCellInput.h
//  DynamicTableGenerator
//
//  Created by Theodore Brown on 3/3/15.
//  Copyright (c) 2015 Theodore Brown. All rights reserved.
//

#import "BaseOptionCellInput.h"

/*
 A simple cell that sends an action/block on button press
 **/
@interface ButtonOptionCellInput : BaseOptionCellInput
@property (copy) void (^callBackBlock)(void);
@property (nonatomic,strong) NSString* buttonTitle;
-(id) initButtonCellWithBlock:(void(^)(void))methodBlock buttonTitle:(NSString*) buttonTitle withTitle:(NSString*) cellTitle  inSection:(NSString*) newSectionHeader;
-(id) initButtonCellWithBlock:(void(^)(void))methodBlock withTitle:(NSString*) cellTitle  inSection:(NSString*) newSectionHeader;

@end
