//
//  DummyTestView.m
//  CoreDataTest
//
//  Created by Theodore Brown on 12/11/13.
//  Copyright (c) 2013 Theodore Brown. All rights reserved.
//

#import "DummyTestView.h"
#import "MainTableViewControler.h"
@interface DummyTestView ()

@end

@implementation DummyTestView
@synthesize actionButton;
@synthesize containerView;
@synthesize optionsBarButton;

@synthesize takePhotoButton;
@synthesize optionsPopover;
@synthesize optionsViewController;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(presentOptionsView:)];
	self.navigationItem.rightBarButtonItem = addButton;	// Do any additional setup after loading the view.
    [self configureView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) configureView
{
    //    self.optionsView = [[OptionsTableView alloc] initWithFrame:containerView.frame
//                                                         style:UITableViewStyleGrouped
//                                                        sample:self.currentSample
//                                         notificationsDelegate:self];
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)
    {
   
        self.optionsViewController = [[MainTableViewControler alloc] init];

        
        // Limit options popover dimensions. Todo make a popover automaticaly resize depending on number of registered properties
        
        self.optionsPopover = [[UIPopoverController alloc] initWithContentViewController:self.optionsViewController];
    }
    
}

- (IBAction)presentOptionsView:(id)sender
{
    NSArray *OptionsArray = @[@{@"Identifier":@"TableCellWithTextDateCellIdentifier",
                                @"return":@"startDate"},
                              @{@"Identifier":@"TableCellWithTextDateCellIdentifier",
                                @"return":@"endDate"},
                              @{@"Identifier":@"SliderCellID",
                                @"return":@"sliderValue",
                                @"settings":@{@"minValue":@0.0f,
                                              @"maxValue":@50.0f}}
                              ];
    
    self.optionsViewController = [[MainTableViewControler alloc] init];
    self.optionsViewController.optionsDelegate = self;
    self.optionsViewController.optionsArray = OptionsArray;
    NSLog(@"Try to present %@", [self.optionsViewController description]);
    [self.navigationController pushViewController:self.optionsViewController animated:YES];
}
- (void) cellNumericValueDidChange:(NSInteger)tag :(NSNumber *)value {
    NSLog(@"Dummytest %d,%.2f", tag, [value floatValue]);
    
}
- (void) cellTextValueDidChange:(NSInteger)tag :(NSString *) value{
    NSLog(@"Dummytest %d,%@", tag, value );
}
- (void) cellSwitchDidChange:(NSInteger)tag :(BOOL)value{
    NSLog(@"Dummytest %d,%hhd", tag, value );
}

- (void) cellDateSegmentDidChange: (NSInteger)tag startDate:(NSDate*) startDate endDate:(NSDate*)endDate{
    NSLog(@"Dummytest Dates did change from %@ to %@",[startDate description], [endDate description]);
}
-(void) cellSliderDidChange:(NSInteger)tag :(float)value{
    NSLog(@"Dummytest Slider %d,%f", tag, value);
}
-(void)optionsWereUpdated:(NSDictionary*)optionsDictionary{
    NSLog(@"Dummy view received options as %@", optionsDictionary);
}
@end
