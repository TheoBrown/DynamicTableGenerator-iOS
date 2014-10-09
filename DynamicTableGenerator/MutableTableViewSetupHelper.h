//
//  MutableTableViewSetupHelper.h
//  TableViewDataCells
//
//  Created by Theodore Brown on 8/10/14.
//  Copyright (c) 2014 Theodore Brown. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "ActionSheetOptionCellInput.h"

#import "SliderOptionCellInput.h"
#import "DateOptionCellInput.h"
#import "TextOptionCellInput.h"
#import "SegmentOptionCellInput.h"
#import "NumberOptionCellInput.h"

@interface MutableTableViewSetupHelper : NSObject



@property (weak, nonatomic) IBOutlet UIButton *saveUserButton;

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain) NSDictionary *UserInfoDict;
@property (nonatomic, retain) NSArray *UserInfoArray;
@property (nonatomic, retain) NSArray *cellsArray;

//@property (nonatomic, retain) UserInfo *NewUserInfo;
//@property (nonatomic, retain) FishTank *NewFishTank;

@property (nonatomic, retain) NSManagedObjectModel *NewFormClass;
@property (strong, nonatomic) id mutableFormObject; // this is the object that is managed and updated

@property (nonatomic, strong) UITextField* txtActiveField;
@property (nonatomic, strong) UIToolbar* keyboardToolbar;
@property (nonatomic, strong) UIBarButtonItem* btnDone;
@property (nonatomic, strong) UIBarButtonItem* btnNext;
@property (nonatomic, strong) UIBarButtonItem* btnPrev;

@property (nonatomic, strong) NSIndexPath *currentSelection;
@property  NSInteger titletag;

- (id) initWithObject:(id)newFormObject;
- (id) initWithManagedObject:(id)newFormObject;
- (id) initWithDict:(id)newFormObject;

//-(IBAction)saveUser:(id)sender;
//- (void)setFormClass:(id)newFormClass;
//
//-(UIToolbar *)createInputAccessoryViewWithTags:(NSInteger) allTag;
@end

