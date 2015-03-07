//
//  TextOptionCellInput.h
//  TableViewDataCells
//
//  Created by Theodore Brown on 8/9/14.
//  Copyright (c) 2014 Theodore Brown. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseOptionCellInput.h"

//#import "CellWithText.h"

/**
 Text Input Cell supporting various text entry keyboard formats
 */
@interface TextOptionCellInput : BaseOptionCellInput <UITextFieldDelegate>

-(id) initTextInputForObject:(id) managedObject forReturnKey:(NSString*)newReturnKey withTitle:(NSString*) cellTitle withDefault:(NSString*) defaultText  inSection:(NSString*) newSectionHeader;
@end
