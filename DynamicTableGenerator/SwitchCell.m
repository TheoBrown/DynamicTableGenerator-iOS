//
//  SwitchCell.m
//  DynamicTableGenerator
//
//  Created by tpb on 11/14/14.
//  Copyright (c) 2014 Theodore Brown. All rights reserved.
//

#import "SwitchCell.h"

@implementation SwitchCell


-(NSString *) reuseIdentifier {
    return DTVCCellIdentifier_SwitchCell;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    reuseIdentifier = [self reuseIdentifier];
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.cellSwitch = [UISwitch newAutoLayoutView];
        [self.cellSwitch addTarget:self action:@selector(switchDidChange:) forControlEvents:UIControlEventValueChanged];
        [self.cellSwitch addTarget:self action:@selector(contentWasSelected:) forControlEvents:UIControlEventTouchDown];
        [self.cellSwitch addTarget:self action:@selector(contentWasSelected:) forControlEvents:UIControlEventTouchUpInside];

        [self.contentView addSubview:self.cellSwitch];
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
            [self.cellSwitch autoSetContentCompressionResistancePriorityForAxis:ALAxisVertical];
        }];
        [self.cellSwitch autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:kLabelVerticalInsets];
        [self.cellSwitch autoPinEdgeToSuperviewEdge:ALEdgeTrailing withInset:kLabelHorizontalInsets];
        
        self.didSetupAcessoryConstraints = YES;
    }
    
    [super updateConstraints];
}

-(IBAction)switchDidChange:(id)sender {
    BOOL value = self.cellSwitch.on;
    NSNumber * switchValue = [NSNumber numberWithBool:value];
    if ([self.delegate respondsToSelector:@selector(cellSwitchDidChange::)]){
        [self.delegate cellSwitchDidChange:self.indexPath:switchValue];

    }
}

@end
