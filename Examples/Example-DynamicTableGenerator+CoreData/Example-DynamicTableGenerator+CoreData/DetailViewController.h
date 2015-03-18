//
//  DetailViewController.h
//  Example-DynamicTableGenerator+CoreData
//
//  Created by tpb on 3/17/15.
//  Copyright (c) 2015 DirectDiagnostics. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;
@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;

@end

