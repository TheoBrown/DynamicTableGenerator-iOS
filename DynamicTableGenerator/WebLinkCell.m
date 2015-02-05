//
//  WebLinkCell.m
//  DynamicTableGenerator
//
//  Created by tpb on 2/3/15.
//  Copyright (c) 2015 Theodore Brown. All rights reserved.
//

#import "WebLinkCell.h"

@implementation WebLinkCell

-(NSString *) reuseIdentifier {
    return DTVCCellIdentifier_WebLinkCell;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    reuseIdentifier = [self reuseIdentifier];
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        //settings up cell text;
        self.authorLabel=[UILabel newAutoLayoutView];
        [self.authorLabel setTextAlignment:NSTextAlignmentLeft];
        [self.authorLabel setFont:[UIFont fontWithName:@"Arial-BoldMT" size:16]];
//        [self.authorLabel setBackgroundColor:[UIColor greenColor]];
        self.assetLabel=[UILabel newAutoLayoutView];
        [self.assetLabel setTextAlignment:NSTextAlignmentCenter];
//        [self.assetLabel setBackgroundColor:[UIColor orangeColor]];
        self.descriptionLabel = [UILabel newAutoLayoutView];
        [self.descriptionLabel setTextAlignment:NSTextAlignmentRight];
        [self.descriptionLabel setTextColor:[UIColor grayColor]];
//        [self.descriptionLabel setBackgroundColor:[UIColor blueColor]];
        [self.contentView addSubview:self.authorLabel];
        [self.contentView addSubview:self.assetLabel];
        [self.contentView addSubview:self.descriptionLabel];
        self.cellButton = [UIButton newAutoLayoutView];
        //        self.cellButton.backgroundColor = [UIColor colorWithRed:1 green:0 blue:0 alpha:0.5]; // light blue
        [self.cellButton addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [self.cellButton addTarget:self action:@selector(contentWasSelected:) forControlEvents:UIControlEventTouchDown];
        [self.cellButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        [self defineContentSelector:@selector(buttonPressed:)];
        
        //set button text to display to the right, slightly offset from edge
        self.cellButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        self.cellButton.contentEdgeInsets = UIEdgeInsetsMake(0,0,0,10);
        [self.cellButton setBackgroundColor:[UIColor clearColor]];
        self.cellButton.alpha=0.0;
        self.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        [self.contentView addSubview:self.cellButton];
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
            [self.authorLabel autoSetContentCompressionResistancePriorityForAxis:ALAxisVertical];
            [self.assetLabel autoSetContentCompressionResistancePriorityForAxis:ALAxisVertical];
            [self.descriptionLabel autoSetContentCompressionResistancePriorityForAxis:ALAxisVertical];

        }];
        [self.cellButton autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:kLabelVerticalInsets];
        [self.cellButton autoPinEdgeToSuperviewEdge:ALEdgeTrailing withInset:kLabelHorizontalInsets];
        [self.cellButton autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:self.title withOffset:kLabelHorizontalSpace];
        
        //set up text display
        [self.authorLabel autoPinEdgeToSuperviewEdge:ALEdgeLeading withInset:kLabelHorizontalInsets];
        [self.authorLabel autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:kLabelVerticalInsets];
        
        [self.assetLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.authorLabel withOffset:kLabelVerticalInsets];
        [self.assetLabel autoPinEdgeToSuperviewEdge:ALEdgeLeading withInset:2*kLabelHorizontalInsets];
        [self.assetLabel autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:kLabelVerticalInsets];
        [self.assetLabel autoPinEdge:ALEdgeTrailing toEdge:ALEdgeTrailing ofView:self.authorLabel];
        
        [self.descriptionLabel autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:kLabelVerticalInsets];
        [self.descriptionLabel autoPinEdgeToSuperviewEdge:ALEdgeTrailing withInset:kLabelHorizontalSpace];
        [self.descriptionLabel autoPinEdge:ALEdgeLeading toEdge:ALEdgeTrailing ofView:self.authorLabel withOffset:kLabelHorizontalSpace];

        self.didSetupAcessoryConstraints = YES;
    }
    
    [super updateConstraints];
}


-(IBAction)buttonPressed:(UIControl *)sender{
    NSLog(@"trying to open %@ on button press " ,self.linkURL);
    if ([[UIApplication sharedApplication] canOpenURL:self.linkURL]){
        NSLog(@"can open %@ on button press " ,self.linkURL);

        [[UIApplication sharedApplication] openURL:self.linkURL];
    }

}

@end
