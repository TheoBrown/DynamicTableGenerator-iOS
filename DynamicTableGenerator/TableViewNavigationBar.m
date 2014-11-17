//
//  TableViewNavigationBar.m
//  DynamicTableGenerator
//
//  Created by tpb on 11/16/14.
//  Copyright (c) 2014 Theodore Brown. All rights reserved.
//

#import "TableViewNavigationBar.h"

@implementation TableViewNavigationBar

-(id) initWithDelegate:(id) tvDelegate andFrame:(CGRect) viewFrame {
    CGRect myFrame = CGRectMake(300,300,viewFrame.size.width,44.0);
    self = [super initWithFrame:myFrame];
    if (self) {
        self.delegate = tvDelegate;
        self.backgroundColor = [UIColor redColor];
        self.nextButton = [UIButton newAutoLayoutView];
        [self.nextButton setTitle:@"next" forState:UIControlStateNormal];
        [self.nextButton addTarget:self action:@selector(nextButtonPressed:) forControlEvents:UIControlEventTouchDown];
        
        self.previousButton = [UIButton newAutoLayoutView];
        [self.previousButton setTitle:@"prev" forState:UIControlStateNormal];
        [self.previousButton addTarget:self action:@selector(prevButtonPressed:) forControlEvents:UIControlEventTouchDown];

        self.doneButton = [UIButton newAutoLayoutView];
        [self.doneButton setTitle:@"done" forState:UIControlStateNormal];
        [self.doneButton addTarget:self action:@selector(doneButtonPressed:) forControlEvents:UIControlEventTouchDown];
        
        [self addSubview:self.nextButton];
        [self addSubview:self.previousButton];
        [self addSubview:self.doneButton];

    }
    return self;
}
- (void)updateConstraints
{
    if (!self.didSetupConstraints) {
        // Note: if the constraints you add below require a larger cell size than the current size (which is likely to be the default size {320, 44}), you'll get an exception.
        // As a fix, you can temporarily increase the size of the cell's contentView so that this does not occur using code similar to the line below.
        //      See here for further discussion: https://github.com/Alex311/TableCellWithAutoLayout/commit/bde387b27e33605eeac3465475d2f2ff9775f163#commitcomment-4633188
//        self.bounds = CGRectMake(0.0f, 0.0f, 99999.0f, 99999.0f);
        
        [UIView autoSetPriority:UILayoutPriorityRequired forConstraints:^{
            [self.previousButton autoSetContentCompressionResistancePriorityForAxis:ALAxisHorizontal];
        }];
        [self.previousButton autoPinEdgeToSuperviewEdge:ALEdgeLeading withInset:kLabelHorizontalInsets];

        [self.previousButton autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:kLabelVerticalInsets];
        [self.previousButton autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:kLabelVerticalInsets];
        [self.previousButton autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:self.nextButton withOffset:kLabelHorizontalInsets];

        
        [UIView autoSetPriority:UILayoutPriorityRequired forConstraints:^{
            [self.nextButton autoSetContentCompressionResistancePriorityForAxis:ALAxisVertical];
        }];
        
//        [self.nextButton autoPinEdgeToSuperviewEdge:ALEdgeLeading withInset:kLabelHorizontalInsets];
        [self.nextButton autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:self.previousButton withOffset:kLabelHorizontalInsets];
//        [self.nextButton autoPinEdge:ALEdgeRight toEdge: ofView:self.self.nextButton withOffset:kLabelHorizontalInsets];

        [self.nextButton autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:kLabelVerticalInsets];
        [self.nextButton autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:kLabelVerticalInsets];
        
//        [self.doneButton autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:self.previousButton withOffset:kLabelHorizontalInsets];

        [UIView autoSetPriority:UILayoutPriorityRequired forConstraints:^{
            [self.doneButton autoSetContentCompressionResistancePriorityForAxis:ALAxisVertical];
        }];
        
        [self.doneButton autoPinEdgeToSuperviewEdge:ALEdgeTrailing withInset:kLabelHorizontalInsets];
        
        [self.doneButton autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:kLabelVerticalInsets];
        [self.doneButton autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:kLabelVerticalInsets];
        
        self.didSetupConstraints = YES;
    }
    
    [super updateConstraints];
}
-(void)nextButtonPressed:(id) sender {
    [self.delegate gotoNextTextfield:sender];
}
-(void)prevButtonPressed:(id) sender {
    [self.delegate gotoPrevTextfield:sender];
}
-(void)doneButtonPressed:(id) sender {
    [self.delegate doneTyping:sender];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
