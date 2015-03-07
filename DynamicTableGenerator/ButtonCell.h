//
//  ButtonCell.h
//  DynamicTableGenerator
//
//  Created by Theodore Brown on 3/3/15.
//  Copyright (c) 2015 Theodore Brown. All rights reserved.
//

#import "BaseCell.h"

/**
 *  Simple Cell with a button that can perform a selector/block
 */
@interface ButtonCell : BaseCell
@property (nonatomic, strong) IBOutlet UIButton *actionButton;

@end
