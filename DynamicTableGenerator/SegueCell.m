//
//  SegueCell.m
//  DynamicTableGenerator
//
//  Created by tpb on 12/20/14.
//  Copyright (c) 2014 Theodore Brown. All rights reserved.
//

#import "SegueCell.h"

@implementation SegueCell

-(NSString *) reuseIdentifier {
    return DTVCCellIdentifier_SegueCell;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    reuseIdentifier = [self reuseIdentifier];
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        
        self.cellButton = [UIButton newAutoLayoutView];
        //        self.cellButton.backgroundColor = [UIColor colorWithRed:1 green:0 blue:0 alpha:0.5]; // light blue
        [self.cellButton addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [self.cellButton addTarget:self action:@selector(contentWasSelected:) forControlEvents:UIControlEventTouchDown];
        [self.cellButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        [self defineContentSelector:@selector(buttonPressed:)];
        
        //set button text to display to the right, slightly offset from edge
        self.cellButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        self.cellButton.contentEdgeInsets = UIEdgeInsetsMake(0,0,0,10);
        [self.contentView addSubview:self.cellButton];
        self.accessoryType=UITableViewCellAccessoryDisclosureIndicator;

    }
    
    return self;
}



#pragma mark - View control


- (void)updateConstraints
{
    if (!self.didSetupAcessoryConstraints) {
        // Note: if the constraints you add below require a larger cell size than the current size (which is likely to be the default size {320, 44}), you'll get an exception.
        // As a fix, you can temporarily increase the size of the cell's contentView so that this does not occur using code similar to the line below.
        //      See here for further discussion: https://github.com/Alex311/TableCellWithAutoLayout/commit/bde387b27e33605eeac3465475d2f2ff9775f163#commitcomment-4633188
        
        self.contentView.bounds = CGRectMake(0.0f, 0.0f, 99999.0f, 99999.0f);
        
        
        [UIView autoSetPriority:UILayoutPriorityRequired forConstraints:^{
            [self.cellButton autoSetContentCompressionResistancePriorityForAxis:ALAxisVertical];
        }];
        [self.cellButton autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:kLabelVerticalInsets];
        [self.cellButton autoPinEdgeToSuperviewEdge:ALEdgeTrailing withInset:kLabelHorizontalInsets];
        [self.cellButton autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:self.title withOffset:kLabelHorizontalSpace];
        
        self.didSetupAcessoryConstraints = YES;
    }
    
    [super updateConstraints];
}


-(IBAction)buttonPressed:(UIControl *)sender{
    if ([self.tableViewDelegate navigationController]!=nil){
        if ([[self.tableViewDelegate navigationController] respondsToSelector:@selector(pushViewController:animated:)]){
            [[self.tableViewDelegate navigationController] pushViewController:self.destinationVC animated:YES];

        }
    }
    //           [self presentViewController:self.resultsViewController animated:YES completion: nil];
}

@end
