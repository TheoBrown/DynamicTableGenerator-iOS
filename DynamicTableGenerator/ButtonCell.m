//
//  ButtonCell.m
//  DynamicTableGenerator
//
//  Created by Theodore Brown on 3/3/15.
//  Copyright (c) 2015 Theodore Brown. All rights reserved.
//

#import "ButtonCell.h"

@implementation ButtonCell

-(NSString *) reuseIdentifier {
    return DTVCCellIdentifier_ButtonCell;
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    reuseIdentifier = [self reuseIdentifier];
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.actionButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        
        self.actionButton.translatesAutoresizingMaskIntoConstraints=NO;
        self.actionButton.frame=CGRectMake(0, 0, 80, 80);
        
        // Set the button Text Color
        [self.actionButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.actionButton setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
        
        // Set default backgrond color
        [self.actionButton setBackgroundColor:[UIColor blackColor]];
        // Draw a custom gradient
        //        CAGradientLayer *btnGradient = [CAGradientLayer layer];
        //        btnGradient.frame = self.actionButton.bounds;
        //        btnGradient.colors = [NSArray arrayWithObjects:
        //                              (id)[[UIColor colorWithRed:102.0f / 255.0f green:102.0f / 255.0f blue:102.0f / 255.0f alpha:1.0f] CGColor],
        //                              (id)[[UIColor colorWithRed:51.0f / 255.0f green:51.0f / 255.0f blue:51.0f / 255.0f alpha:1.0f] CGColor],
        //                              nil];
        //        [self.actionButton.layer insertSublayer:btnGradient atIndex:0];
        
        // Round button corners
        CALayer *btnLayer = [self.actionButton layer];
        [btnLayer setMasksToBounds:YES];
        [btnLayer setCornerRadius:5.0f];
        
        // Apply a 1 pixel, black border
        [btnLayer setBorderWidth:1.0f];
        [btnLayer setBorderColor:[[UIColor blackColor] CGColor]];
        
        
        
        
        self.actionButton.backgroundColor = [UIColor colorWithRed:0 green:0 blue:1.0 alpha:0.5]; // light blue
        [self.actionButton addTarget:self action:@selector(actionButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        //        [self.actionButton addTarget:self action:@selector(contentWasSelected:) forControlEvents:UIControlEventTouchDown];
        
        
        //        [self defineContentSelector:@selector(actionButtonPressed:)];
        
        //set button text to display to the right, slightly offset from edge
        self.actionButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        self.actionButton.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        
        self.actionButton.contentEdgeInsets = UIEdgeInsetsMake(0,0,0,10);
        [self.contentView addSubview:self.actionButton];
    }
    
    return self;
}

- (void)updateConstraints
{
    if (!self.didSetupAcessoryConstraints) {
        // Note: if the constraints you add below require a larger cell size than the current size (which is likely to be the default size {320, 44}), you'll get an exception.
        // As a fix, you can temporarily increase the size of the cell's contentView so that this does not occur using code similar to the line below.
        //      See here for further discussion: https://github.com/Alex311/TableCellWithAutoLayout/commit/bde387b27e33605eeac3465475d2f2ff9775f163#commitcomment-4633188
        
        self.contentView.bounds = CGRectMake(0.0f, 0.0f, 99999.0f, 99999.0f);
        
        
        [UIView autoSetPriority:UILayoutPriorityRequired forConstraints:^{
            [self.actionButton autoSetContentCompressionResistancePriorityForAxis:ALAxisVertical];
        }];
        [self.actionButton autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:kLabelVerticalInsets];
        [self.actionButton autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:kLabelVerticalInsets];
        [self.actionButton autoSetDimension:ALDimensionWidth toSize:85.0];
        [self.actionButton autoPinEdgeToSuperviewEdge:ALEdgeTrailing withInset:kLabelHorizontalInsets];
        [self.actionButton autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:self.title withOffset:3*kLabelHorizontalSpace];
        
        self.didSetupAcessoryConstraints = YES;
    }
    
    [super updateConstraints];
}

- (void)actionButtonPressed:(id) sender {
    
    if ([self.delegate respondsToSelector:@selector(cellButtonPressed:)]){
        [self.delegate cellButtonPressed:self.indexPath];
    }
    
}
@end
