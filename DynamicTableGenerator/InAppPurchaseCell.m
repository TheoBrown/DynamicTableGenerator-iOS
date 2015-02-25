//
//  InAppPurchaseCell.m
//  DynamicTableGenerator
//
//  Created by tpb on 2/24/15.
//  Copyright (c) 2015 Theodore Brown. All rights reserved.
//

#import "InAppPurchaseCell.h"

@implementation InAppPurchaseCell

-(NSString *) reuseIdentifier {
    return DTVCCellIdentifier_PurchaseCell;
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    reuseIdentifier = [self reuseIdentifier];
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.buyButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        
      self.buyButton.translatesAutoresizingMaskIntoConstraints=NO;
                          self.buyButton.frame=CGRectMake(0, 0, 80, 80);
        
        // Set the button Text Color
        [self.buyButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.buyButton setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
        
        // Set default backgrond color
        [self.buyButton setBackgroundColor:[UIColor blackColor]];
        // Draw a custom gradient
//        CAGradientLayer *btnGradient = [CAGradientLayer layer];
//        btnGradient.frame = self.buyButton.bounds;
//        btnGradient.colors = [NSArray arrayWithObjects:
//                              (id)[[UIColor colorWithRed:102.0f / 255.0f green:102.0f / 255.0f blue:102.0f / 255.0f alpha:1.0f] CGColor],
//                              (id)[[UIColor colorWithRed:51.0f / 255.0f green:51.0f / 255.0f blue:51.0f / 255.0f alpha:1.0f] CGColor],
//                              nil];
//        [self.buyButton.layer insertSublayer:btnGradient atIndex:0];
        
        // Round button corners
        CALayer *btnLayer = [self.buyButton layer];
        [btnLayer setMasksToBounds:YES];
        [btnLayer setCornerRadius:5.0f];
        
        // Apply a 1 pixel, black border
        [btnLayer setBorderWidth:1.0f];
        [btnLayer setBorderColor:[[UIColor blackColor] CGColor]];
        
        
        
        
        self.buyButton.backgroundColor = [UIColor colorWithRed:0 green:0 blue:1.0 alpha:0.5]; // light blue
        [self.buyButton addTarget:self action:@selector(buyButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
//        [self.buyButton addTarget:self action:@selector(contentWasSelected:) forControlEvents:UIControlEventTouchDown];


//        [self defineContentSelector:@selector(buyButtonPressed:)];
        
        //set button text to display to the right, slightly offset from edge
        self.buyButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        self.buyButton.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;

        self.buyButton.contentEdgeInsets = UIEdgeInsetsMake(0,0,0,10);
        [self.contentView addSubview:self.buyButton];
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
            [self.buyButton autoSetContentCompressionResistancePriorityForAxis:ALAxisVertical];
        }];
        [self.buyButton autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:kLabelVerticalInsets];
        [self.buyButton autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:kLabelVerticalInsets];
        [self.buyButton autoSetDimension:ALDimensionWidth toSize:85.0];
        [self.buyButton autoPinEdgeToSuperviewEdge:ALEdgeTrailing withInset:kLabelHorizontalInsets];
        [self.buyButton autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:self.title withOffset:3*kLabelHorizontalSpace];
        
        self.didSetupAcessoryConstraints = YES;
    }
    
    [super updateConstraints];
}

- (void)buyButtonPressed:(id) sender {
    UIButton *buyButton = (UIButton *)sender;
    
    if ([self.delegate respondsToSelector:@selector(cellPurchaseButtonPressed:)]){
        [self.delegate cellPurchaseButtonPressed:self.indexPath];
    }
    
}
@end
