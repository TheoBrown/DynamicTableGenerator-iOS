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
        
        self.buyButton = [UIButton newAutoLayoutView];
        //        self.dateButon.backgroundColor = [UIColor colorWithRed:1 green:0 blue:0 alpha:0.5]; // light blue
        [self.buyButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.buyButton addTarget:self action:@selector(selectADate:) forControlEvents:UIControlEventTouchUpInside];
        [self.buyButton addTarget:self action:@selector(contentWasSelected:) forControlEvents:UIControlEventTouchDown];
        [self.buyButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        [self defineContentSelector:@selector(buyButtonPressed:)];
        
        //set button text to display to the right, slightly offset from edge
        self.buyButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
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
        [self.buyButton autoPinEdgeToSuperviewEdge:ALEdgeTrailing withInset:kLabelHorizontalInsets];
        [self.buyButton autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:self.title withOffset:kLabelHorizontalSpace];
        
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
