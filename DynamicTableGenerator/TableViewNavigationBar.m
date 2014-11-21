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
//    CGRect myFrame = CGRectMake(10 ,viewFrame.origin.y-100,viewFrame.size.width,44.0);
//    self = [super initWithFrame:viewFrame];
    self = [super init];
    if (self) {
//        self.translatesAutoresizingMaskIntoConstraints = NO;
//        self.userInteractionEnabled = NO;
        self.view = [[UIView alloc] initWithFrame:viewFrame];
        self.delegate = tvDelegate;
        self.view.backgroundColor = [UIColor colorWithRed:255/255.0 green:71/255.0 blue:113/255.0 alpha:1.0];
        self.view.opaque = YES;
        self.nextButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//        self.nextButton.translatesAutoresizingMaskIntoConstraints = NO;
        
        self.nextButton.backgroundColor = [UIColor greenColor];
        [self.nextButton setTitle:@"Next" forState:UIControlStateNormal];
        [self.nextButton addTarget:self action:@selector(nextButtonPressed:) forControlEvents:UIControlEventTouchDown];
        [self.nextButton setTitleColor:[UIColor colorWithRed:36/255.0 green:71/255.0 blue:113/255.0 alpha:1.0] forState:UIControlStateNormal];
        
        self.previousButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//        self.previousButton.translatesAutoresizingMaskIntoConstraints = NO;
        [self.previousButton setTitle:@"Prev" forState:UIControlStateNormal];
        [self.previousButton addTarget:self action:@selector(prevButtonPressed:) forControlEvents:UIControlEventTouchDown];
        self.previousButton.backgroundColor = [UIColor greenColor];
        [self.previousButton setTitleColor:[UIColor colorWithRed:36/255.0 green:71/255.0 blue:113/255.0 alpha:1.0] forState:UIControlStateNormal];

        self.doneButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//        self.doneButton.translatesAutoresizingMaskIntoConstraints = NO;
        [self.doneButton setTitle:@"Done" forState:UIControlStateNormal];
        [self.doneButton addTarget:self action:@selector(doneButtonPressed:) forControlEvents:UIControlEventTouchDown];
        self.doneButton.backgroundColor = [UIColor greenColor];
        [self.doneButton setTitleColor:[UIColor colorWithRed:36/255.0 green:71/255.0 blue:113/255.0 alpha:1.0] forState:UIControlStateNormal];

//        self.userInteractionEnabled = NO;
//        TPBLayout* layoutHelp = [[TPBLayout alloc] init];
//        NSArray * views = @[self.previousButton,self.nextButton,self.doneButton];
//        [layoutHelp horizontalLayout:views];

        [self.view addSubview:self.nextButton];
        [self.view addSubview:self.previousButton];
        [self.view addSubview:self.doneButton];
        CGFloat bWidth = 40;
        CGFloat bHeight = 30;
        CGFloat pad = 30;
        CGFloat cum = 0;
        CGFloat yOffset = 5;
        self.nextButton.frame =  CGRectMake(pad, yOffset, bWidth, bHeight);
        cum =pad+bWidth;
        self.previousButton.frame =  CGRectMake(pad+cum, yOffset, bWidth, bHeight);
        cum =cum +pad+bWidth;

        self.doneButton.frame =  CGRectMake(pad+cum, yOffset, bWidth, bHeight);


        [self.view setNeedsDisplay];
        [self.view setHidden:NO];
//        [self needsUpdateConstraints];
    }
    return self;
}
//- (void)updateConstraints
//{
//    if (!self.didSetupConstraints) {
//        
//
//
//        // Note: if the constraints you add below require a larger cell size than the current size (which is likely to be the default size {320, 44}), you'll get an exception.
//        // As a fix, you can temporarily increase the size of the cell's contentView so that this does not occur using code similar to the line below.
//        //      See here for further discussion: https://github.com/Alex311/TableCellWithAutoLayout/commit/bde387b27e33605eeac3465475d2f2ff9775f163#commitcomment-4633188
////        self.bounds = CGRectMake(0.0f, 0.0f, 99999.0f, 99999.0f);
//        
////        [UIView autoSetIdentifier:@"Pin Container View Edges" forConstraints:^{
////            [self autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0.0, 10.0, 10.0, 10.0) excludingEdge:ALEdgeTop];
////        }];
//        NSArray * views = @[self.previousButton,self.nextButton,self.doneButton];
//        
////        [self autoSetDimension:ALDimensionHeight toSize:40.0];
//
//        // Fix all the heights of the views to 40 pt
//        [views autoSetViewsDimension:ALDimensionHeight toSize:28.0];
//        
//        // Distribute the views horizontally across the screen, aligned to one another's horizontal axis,
//        // with 10 pt spacing between them and to their superview, and their widths matched equally
//        [views autoDistributeViewsAlongAxis:ALAxisHorizontal alignedTo:ALAttributeHorizontal withFixedSpacing:10.0 insetSpacing:YES matchedSizes:YES];
//        
//        // Align the red view to the horizontal axis of its superview.
//        // This will end up affecting all the views, since they are all aligned to one another's horizontal axis.
//        [self.doneButton autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
//        self.didSetupConstraints = YES;
//    }
//    
//    [super updateConstraints];
//}
-(void)nextButtonPressed:(id) sender {
    NSLog(@"control next");
    [self.delegate gotoNextTextfield:sender];
}
-(void)prevButtonPressed:(id) sender {
    NSLog(@"control prev`");

    [self.delegate gotoPrevTextfield:sender];
}
-(void)doneButtonPressed:(id) sender {
    NSLog(@"control done");

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
