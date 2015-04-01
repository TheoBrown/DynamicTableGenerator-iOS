//
//  MutableTableViewCellManager.m
//  TableViewDataCells
//
//  Created by Theodore Brown on 8/9/14.
//  Copyright (c) 2014 Theodore Brown. All rights reserved.
//

#import "DynamicTableViewCellManager.h"

#import "DynamicTableViewCells.h"
#import "DynamicTableViewConstants.h"
#import "DynamicTableView.h"


@implementation DynamicTableViewCellManager

@synthesize tableView;
@synthesize sectionHeaderArray;

extern const double EARTH_RADIUS;


#pragma mark - init methods
- (id) initWithDelegate:(id) delegate andtableView:(UITableView*) newTableView andCellInputs:(NSArray*) cellInputArray {
    self = [super init];
    if (self) {
        self = [super init];
        self.tableView = newTableView;

        [self parseInputArray:cellInputArray];
    }
    return self;
}

-(void) setupAcessoryViewForFrame:(CGRect)viewFrame withDelegate:(id) delegate {
    CGFloat controlHeight = 40.0;
    //        CGRect keyPadFrame = CGRectMake(self.tableView.bounds.origin.x, self.tableView.bounds.size.height, self.tableView.bounds.size.width, controlHeight);
    CGRect keyFrame = CGRectMake(0,0,viewFrame.size.width,controlHeight);
    //        self.keyPad = [[TableViewNavigationBar alloc] initWithDelegate:delegate andFrame:CGRectMake(0, 0, self.tableView.bounds.size.width, 40)];
    self.keyPad = [[TableViewNavigationBar alloc] initWithDelegate:delegate andFrame:keyFrame];
    self.keyPadView = self.keyPad.view;
    [self.keyPadView removeFromSuperview];
}

#pragma mark -table view setup
- (void) parseInputArray:(NSArray*) cellInputArray{
    NSMutableArray* sectionTitles = [[NSMutableArray alloc] init];
    NSMutableDictionary* sectionTitleDict = [[NSMutableDictionary alloc] init];

    for (BaseOptionCellInput* baseCellInput in cellInputArray) {
        if ([sectionTitles containsObject:baseCellInput.sectionHeader]) {
            // title already in section
            [sectionTitleDict[baseCellInput.sectionHeader] addObject:baseCellInput];
        }
        else {
            [sectionTitles addObject:baseCellInput.sectionHeader];
            sectionTitleDict[baseCellInput.sectionHeader] = [[NSMutableArray alloc] init];
            [sectionTitleDict[baseCellInput.sectionHeader] addObject:baseCellInput];
            // access inputs with self.sectionDescription[section_title][row#]
        }
    }
    self.sectionHeaderArray = [[NSArray alloc] initWithArray:sectionTitles];
    self.sectionDescription = [[NSDictionary alloc] initWithDictionary:sectionTitleDict];
}

#pragma mark -table view data/cell source
- (void) saveAllChanges {
    for (NSString* sectionKey in self.sectionHeaderArray) {
        for (BaseOptionCellInput* cellInput in self.sectionDescription[sectionKey]) {
            [cellInput saveObjectContext];
        }
    }
}
- (id) getInputForSectionTitle:(NSString*) sectionTitle atRow:(NSInteger) rowNumber {
    return self.sectionDescription[sectionTitle][rowNumber];
}

- (id) getInputForSectionIndex:(NSInteger) sectionNumber atRow:(NSInteger) rowNumber {
    NSString* sectionKey = self.sectionHeaderArray[sectionNumber];
    return self.sectionDescription[sectionKey][rowNumber];
}

- (NSInteger) rowsInSection:(NSInteger) section {
    NSString* sectionKey = self.sectionHeaderArray[section];
    return [self.sectionDescription[sectionKey] count];
}


- (UITableViewCell*)  getCellatIndexPath:(NSIndexPath *)indexPath andDelegate:(id) delegateToAssign {
    NSInteger row = [indexPath row];
    NSInteger section = [indexPath section];
    BaseOptionCellInput * baseCellInput = (BaseOptionCellInput*) [self getInputForSectionIndex:section atRow:row];
    NSString * CellIdentifier = baseCellInput.identifier;
    //create acessory view
    
    if ([CellIdentifier  isEqual: DTVCCellIdentifier_NumberCell]){
        NumberCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        NumberOptionCellInput * numberCellInput = (NumberOptionCellInput*)baseCellInput;
        if (cell == nil) {
            [self.tableView registerClass:[NumberCell class] forCellReuseIdentifier:CellIdentifier];
            cell = [[NumberCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        [cell defineCellFormatType:numberCellInput.cellInputFormatType];
        [cell.numericTextField setInputAccessoryView:self.keyPadView];
        cell.numericTextField.delegate = cell;
        
        cell.title.text = baseCellInput.title;
       // cell.subTitle.text = [NSString stringWithFormat:@"Row: %ld, Sec: %ld",(long)[indexPath row], (long)[indexPath section]];
        cell.delegate = numberCellInput;
        cell.indexPath = indexPath;
        cell.tableViewDelegate = delegateToAssign;
        cell.numericTextField.text = [cell stringFromNumber:(NSNumber*)[numberCellInput getDisplayValue]];
        NSLog(@"Display value for number %@,%@",numberCellInput.value,[numberCellInput getDisplayValue]);
        return cell;
    }
    else if ([CellIdentifier  isEqual: DTVCCellIdentifier_TextCell]){
        TextOptionCellInput* textCellInput = (TextOptionCellInput*) baseCellInput;
        TextCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        if (cell == nil) {
            [self.tableView registerClass:[TextCell class] forCellReuseIdentifier:CellIdentifier];
            cell = [[TextCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        

        [cell defineCellFormatType:textCellInput.cellInputFormatType];

        cell.title.text = textCellInput.title; //optionsArray[indexPath.section][1][indexPath.row][@"return"];
       // cell.subTitle.text = [NSString stringWithFormat:@"Row: %ld, Sec: %ld",(long)[indexPath row], (long)[indexPath section]];

        cell.cellTextField.clearsOnBeginEditing = YES;
        cell.cellTextField.autocorrectionType = UITextAutocorrectionTypeNo;
        
        
        [cell.cellTextField setInputAccessoryView:self.keyPadView];
        
        cell.cellTextField.delegate = cell;
        cell.selectionStyle = UITableViewCellSelectionStyleBlue;
        cell.delegate = textCellInput;
        cell.indexPath = indexPath;
        cell.tableViewDelegate = delegateToAssign;

        cell.cellTextField.text = textCellInput.value;

        return cell;
        
    }
    
    else if ([CellIdentifier  isEqual: DTVCCellIdentifier_SwitchCell]){
        SwitchOptionCellInput* switchCellInput = (SwitchOptionCellInput*) baseCellInput;

        SwitchCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            [self.tableView registerClass:[SwitchCell class] forCellReuseIdentifier:CellIdentifier];
            cell = [[SwitchCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        
        cell.title.text = switchCellInput.title; //optionsArray[indexPath.section][1][indexPath.row][@"return"];
       // cell.subTitle.text = [NSString stringWithFormat:@"Row: %ld, Sec: %ld",(long)[indexPath row], (long)[indexPath section]];
        cell.delegate = switchCellInput;
        cell.indexPath = indexPath;
        cell.tableViewDelegate = delegateToAssign;

        cell.cellSwitch.on = [switchCellInput getDisplayValue];
        return cell;
    }
    else if ([CellIdentifier  isEqual: DTVCCellIdentifier_DateCell]){
        DateOptionCellInput* dateCellInput = (DateOptionCellInput*) baseCellInput;
        DateCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        if (cell == nil) {
            [self.tableView registerClass:[DateCell class] forCellReuseIdentifier:CellIdentifier];
            cell = [[DateCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        [cell defineCellFormatType:dateCellInput.cellInputFormatType];
        [cell.dateButon setTitle:[cell stringFromDate:dateCellInput.value] forState:UIControlStateNormal];
        // Configure the cell...
        cell.title.text = dateCellInput.title; //optionsArray[indexPath.section][1][indexPath.row][@"return"];
       // cell.subTitle.text = [NSString stringWithFormat:@"Row: %ld, Sec: %ld",(long)[indexPath row], (long)[indexPath section]];
        cell.indexPath = indexPath;
        cell.selectedDate = dateCellInput.value;
        cell.delegate = dateCellInput;
        cell.tableViewDelegate = delegateToAssign;

        return cell;
    }
    else if ([CellIdentifier  isEqual: DTVCCellIdentifier_SliderCell]){
        SliderOptionCellInput* sliderCellInput = (SliderOptionCellInput*) baseCellInput;
        SliderCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            [self.tableView registerClass:[SliderCell class] forCellReuseIdentifier:CellIdentifier];
            cell = [[SliderCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        cell.sliderLable.text = [NSString stringWithFormat:@"%f", [sliderCellInput.value floatValue]];
        cell.title.text = sliderCellInput.title; //optionsArray[indexPath.section][1][indexPath.row][@"return"];
       // cell.subTitle.text = [NSString stringWithFormat:@"Row: %ld, Sec: %ld",(long)[indexPath row], (long)[indexPath section]];
        
        cell.indexPath = indexPath;
        cell.delegate = sliderCellInput;
        
        cell.cellSlider.minimumValue = [sliderCellInput.minSliderValue floatValue];
        cell.cellSlider.maximumValue = [sliderCellInput.maxSliderValue floatValue];
        [cell.cellSlider setValue:[sliderCellInput.value floatValue]];
        cell.tableViewDelegate = delegateToAssign;

        [cell sizeToFit];
        return cell;
    }
    else if ([CellIdentifier  isEqual: DTVCCellIdentifier_StepperCell]){
        StepperOptionCellInput* stepperCellInput = (StepperOptionCellInput*) baseCellInput;
        StepperCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            [self.tableView registerClass:[StepperCell class] forCellReuseIdentifier:CellIdentifier];
            cell = [[StepperCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        cell.stepperLabel.text = [NSString stringWithFormat:@"%f", [stepperCellInput.value floatValue]];
        cell.title.text = stepperCellInput.title; //optionsArray[indexPath.section][1][indexPath.row][@"return"];
       // cell.subTitle.text = [NSString stringWithFormat:@"Row: %ld, Sec: %ld",(long)[indexPath row], (long)[indexPath section]];
        
        cell.indexPath = indexPath;
        cell.delegate = stepperCellInput;
        
        cell.cellStepper.minimumValue = [stepperCellInput.minStepperValue floatValue];
        cell.cellStepper.maximumValue = [stepperCellInput.maxStepperValue floatValue];
        [cell.cellStepper setValue:[stepperCellInput.value integerValue]];
        cell.tableViewDelegate = delegateToAssign;
        [cell sizeToFit];
        return cell;
    }
    else if ([CellIdentifier  isEqual: DTVCCellIdentifier_SegmentCell]){
        //this is not done yet
        SegmentOptionCellInput* segmentCellInput = (SegmentOptionCellInput*) baseCellInput;
        SegmentCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            [self.tableView registerClass:[SegmentCell class] forCellReuseIdentifier:CellIdentifier];
            cell = [[SegmentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        
        cell.title.text=segmentCellInput.title;
       // cell.subTitle.text = [NSString stringWithFormat:@"Row: %ld, Sec: %ld",(long)[indexPath row], (long)[indexPath section]];
        cell.segmentResults = segmentCellInput.segmentValues;
        NSArray *segmentTitles = segmentCellInput.segmentTitles;
        int count = 0;
        for (NSString * title in segmentTitles){
            if ( count < [cell.cellSegment numberOfSegments]){
                [cell.cellSegment setTitle:title forSegmentAtIndex:count];
            }
            else{
                [cell.cellSegment insertSegmentWithTitle:title atIndex:count animated:YES];
                
            }
            count++;
        }
        
        cell.indexPath = indexPath;
        cell.tableViewDelegate = delegateToAssign;
        [cell.cellSegment setSelectedSegmentIndex:segmentCellInput.selectedSegment];
        cell.delegate = segmentCellInput;
        [cell sizeToFit];
        return cell;
    }
    else if ([CellIdentifier  isEqual: DTVCCellIdentifier_SimpleActionCell]){
        SimpleActionSheetOptionCellInput* cellInput = (SimpleActionSheetOptionCellInput*) baseCellInput;
        SimpleActionSheetCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            [self.tableView registerClass:[SimpleActionSheetCell class] forCellReuseIdentifier:CellIdentifier];
            cell = [[SimpleActionSheetCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        [cell defineCellFormatType:cellInput.cellInputFormatType];
        NSLog(@"action cell loaded with value %@ %@ %@",cellInput.value,[cellInput.value class],[NSString class]);
        NSString* defaultValue;
        NSString* classString = NSStringFromClass([cellInput.value class]);
        NSLog(@"Class stirng %@ %@",classString,[classString class]);

        if ([[classString lowercaseString] rangeOfString:@"string"].location != NSNotFound) {
            defaultValue=cellInput.value;
        }
        else if ([cellInput.value class]==[NSNumber class]) {
            defaultValue=[cellInput.optionsArray objectAtIndex:[(NSNumber*)cellInput.value integerValue]];
        }
        else{
            defaultValue = [cellInput.optionsArray objectAtIndex:0];
        }
        [cell.actionButton setTitle:defaultValue forState:UIControlStateNormal];
        // Configure the cell...
        cell.title.text = cellInput.title;
        cell.indexPath = indexPath;
        cell.optionsArray=cellInput.optionsArray;
        cell.resultsMap=cellInput.resultsMap;
        cell.actionSheetTitle=cellInput.actionSheetTitle;
        cell.selectedResultTitle = cellInput.value;
        cell.delegate = cellInput;
        cell.tableViewDelegate = delegateToAssign;
        return cell;
    }
//    else if ([CellIdentifier  isEqual: @"ActionSheetCellID"]){
//        ActionSheetOptionCellInput* actionCellInput = (ActionSheetOptionCellInput*) baseCellInput;
//
//        
//        NSLog(@"Creating CellwithID %@ at Row %d, Sec %d", CellIdentifier, [indexPath row], [indexPath section]);
//        
//        CellWithAbstractActionSheet *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
//        
//        if (cell == nil) {
//            cell = (CellWithAbstractActionSheet *)[CellWithAbstractActionSheet cellFromNibNamed:@"CellWithAbstractActionSheet"];
//        }
//        
//        // Configure the cell...
//        cell.title.text = actionCellInput.title;
//        
//        if ([optionsArray[indexPath.section][1][indexPath.row][@"return"] isEqualToString:@"selectedTank"])
//        {
//            self.fishTankArray = @[optionsArray[indexPath.section][1][indexPath.row],cell,indexPath];
//            NSLog(@"Fishtank array created as %@" , [self.fishTankArray description]);
//        }
//       // cell.subTitle.text = [NSString stringWithFormat:@"Row: %ld, Sec: %ld",(long)[indexPath row], (long)[indexPath section]];
//        
//        //        cell.actionSheetPredicate = optionsArray[indexPath.section][1][indexPath.row][@"settings"][@"predicate"];
//        cell.actionSheetTitle = optionsArray[indexPath.section][1][indexPath.row][@"title"];
//        cell.arrayEntitySortValue = optionsArray[indexPath.section][1][indexPath.row][@"settings"][@"entitySortKey"];
//        cell.arrayEntity = optionsArray[indexPath.section][1][indexPath.row][@"settings"][@"entity"];
//        [cell setTitleFromID:[[[SharedData getInstance] settings] URLForKey:optionsArray[indexPath.section][1][indexPath.row][@"return"]]];
//        if (self.optionsArray[indexPath.section][1][indexPath.row][@"settings"][@"prePredicates"] != nil){
//            NSArray *prePredicates =self.optionsArray[indexPath.section][1][indexPath.row][@"settings"][@"prePredicates"];
//            if ([self.optionsArray[indexPath.section][1][indexPath.row][@"settings"][@"predicateReference"] containsObject:@"selectedTank"])
//            {
//                
//            }
//            for(NSString *prePredicate in prePredicates){
//                NSURL *predicateURLID =  [[[SharedData getInstance] settings] URLForKey:prePredicate];
//                NSDictionary *prePredSettings = [self getSettingsFromOptions:prePredicate];
//                NSString *prepredicateString = prePredSettings[@"predicateString"];
//                [cell addCompoundPredicateFromString:prepredicateString withObjectURL:predicateURLID];
//            }
//            [cell setPredicateFromCompoundArray];
//        }
//        else {
//            cell.actionSheetPredicate = [NSPredicate predicateWithFormat:optionsArray[indexPath.section][1][indexPath.row][@"settings"][@"nopredicateString"]];
//        };
//
//        cell.indexPath = indexPath;
//        cell.actionButon.tag = tag;
//        cell.delegate = delegateToAssign;
//                [cell setNeedsUpdateConstraints];
//        [cell updateConstraintsIfNeeded];
//        return cell;
//    }
    else if ([CellIdentifier  isEqual: DTVCCellIdentifier_OptionPickerCell]){
        OptionPickerCellInput* optionCellInput = (OptionPickerCellInput*) baseCellInput;
        OptionCell  *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        if (cell == nil) {
            [self.tableView registerClass:[OptionCell class] forCellReuseIdentifier:CellIdentifier];
            cell = [[OptionCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        
        // Configure the cell...
        cell.title.text = optionCellInput.title; //optionsArray[indexPath.section][1][indexPath.row][@"return"];
       // cell.subTitle.text = [NSString stringWithFormat:@"Row: %ld, Sec: %ld",(long)[indexPath row], (long)[indexPath section]];
        cell.delegate = optionCellInput;
        
        cell.indexPath = indexPath;
        cell.tableViewDelegate = delegateToAssign;
        cell.optionsArray = optionCellInput.optionsArray;
        cell.selectedOptionsArray = (NSArray*)[optionCellInput getDisplayValue];
        
        [cell.cellButton setTitle:[cell combineStringsFromArray:cell.selectedOptionsArray] forState:UIControlStateNormal];
//        [cell setResultTypeFromURL:[self.updatedPredicates objectForKey:optionsArray[indexPath.section][1][indexPath.row][@"return"]]];
        
//        if (self.optionsArray[indexPath.section][1][indexPath.row][@"settings"][@"prePredicates"] != nil){
//            NSArray *prePredicates =self.optionsArray[indexPath.section][1][indexPath.row][@"settings"][@"prePredicates"];
//            if ([self.optionsArray[indexPath.section][1][indexPath.row][@"settings"][@"predicateReference"] containsObject:@"selectedTank"])
//            {
//                
//            }
//            for(NSString *prePredicate in prePredicates){
//                NSURL *predicateURLID =  [[[SharedData getInstance] settings] URLForKey:prePredicate];
//                NSDictionary *prePredSettings = [self getSettingsFromOptions:prePredicate];
//                [cell setResultTypeFromURL:predicateURLID];
//                
//            }
//        }


        return cell;
    }
    else if ([CellIdentifier  isEqual: DTVCCellIdentifier_SegueCell]){
        SegueOptionCellInput* segueCellInput = (SegueOptionCellInput*) baseCellInput;
        SegueCell  *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        if (cell == nil) {
            [self.tableView registerClass:[SegueCell class] forCellReuseIdentifier:CellIdentifier];
            cell = [[SegueCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        
        // Configure the cell...
        cell.title.text = segueCellInput.title; //optionsArray[indexPath.section][1][indexPath.row][@"return"];
        cell.delegate = segueCellInput;
        cell.indexPath = indexPath;
        cell.tableViewDelegate = delegateToAssign;
        cell.destinationVC=segueCellInput.destinationVC;
        //        [cell setResultTypeFromURL:[self.updatedPredicates objectForKey:optionsArray[indexPath.section][1][indexPath.row][@"return"]]];
        
        //        if (self.optionsArray[indexPath.section][1][indexPath.row][@"settings"][@"prePredicates"] != nil){
        //            NSArray *prePredicates =self.optionsArray[indexPath.section][1][indexPath.row][@"settings"][@"prePredicates"];
        //            if ([self.optionsArray[indexPath.section][1][indexPath.row][@"settings"][@"predicateReference"] containsObject:@"selectedTank"])
        //            {
        //
        //            }
        //            for(NSString *prePredicate in prePredicates){
        //                NSURL *predicateURLID =  [[[SharedData getInstance] settings] URLForKey:prePredicate];
        //                NSDictionary *prePredSettings = [self getSettingsFromOptions:prePredicate];
        //                [cell setResultTypeFromURL:predicateURLID];
        //                
        //            }
        //        }
        
        
        return cell;
    }
    else if ([CellIdentifier  isEqual: DTVCCellIdentifier_WebLinkCell]){
        WebLinkOptionCellInput* cellInput = (WebLinkOptionCellInput*) baseCellInput;
        WebLinkCell  *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        if (cell == nil) {
            [self.tableView registerClass:[WebLinkCell class] forCellReuseIdentifier:CellIdentifier];
            cell = [[WebLinkCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        
        // Configure the cell...
        cell.title.text = cellInput.title; //optionsArray[indexPath.section][1][indexPath.row][@"return"];
        cell.delegate = cellInput;
        cell.indexPath = indexPath;
        cell.tableViewDelegate = delegateToAssign;
        cell.linkURL=cellInput.linkURL;
        cell.descriptionLabel.text=cellInput.assetDescription;
        cell.authorLabel.text=cellInput.author;
        cell.assetLabel.text=cellInput.asset;
        return cell;
    }
    else if ([CellIdentifier  isEqual: DTVCCellIdentifier_PurchaseCell]){
        PurchaseOptionCellInput* cellInput = (PurchaseOptionCellInput*) baseCellInput;
        InAppPurchaseCell  *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        if (cell == nil) {
            [self.tableView registerClass:[InAppPurchaseCell class] forCellReuseIdentifier:CellIdentifier];
            cell = [[InAppPurchaseCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        
        // Configure the cell...
        SEL selector = @selector(productPurchased:);
        BOOL returnValue = NO;
        if ([cellInput.SKDelegate respondsToSelector:selector]){
            NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:
                                        [[cellInput.SKDelegate class] instanceMethodSignatureForSelector:selector]];
            [invocation setSelector:selector];
            [invocation setTarget:cellInput.SKDelegate];
            [invocation invoke];
            [invocation getReturnValue:&returnValue];
            NSLog(@"Returned %d", returnValue);
        }
        if (returnValue) {
            [cell.buyButton setTitle:@"Bought" forState:UIControlStateNormal];
            [cell.buyButton setBackgroundColor:[UIColor greenColor]];
        }
        else {
            [cell.buyButton setTitle:@"Buy" forState:UIControlStateNormal];

        }
        cell.title.text = cellInput.IAPproduct.localizedTitle; //optionsArray[indexPath.section][1][indexPath.row][@"return"];
        NSLog(@"IAP cell %@ %@",cellInput.IAPproduct.localizedTitle,[cellInput displayPrice]);
        cell.delegate = cellInput;
        cell.indexPath = indexPath;
        cell.tableViewDelegate = delegateToAssign;
        cell.subTitle.text=[cellInput displayPrice];
        return cell;
    }
    else if ([CellIdentifier  isEqual: DTVCCellIdentifier_ButtonCell]){
        ButtonOptionCellInput* cellInput = (ButtonOptionCellInput*) baseCellInput;
        ButtonCell  *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        if (cell == nil) {
            [self.tableView registerClass:[ButtonCell class] forCellReuseIdentifier:CellIdentifier];
            cell = [[ButtonCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        [cell.actionButton setTitle:cellInput.buttonTitle forState:UIControlStateNormal];
        cell.title.text = cellInput.title; //optionsArray[indexPath.section][1][indexPath.row][@"return"];
        cell.delegate = cellInput;
        cell.indexPath = indexPath;
        cell.tableViewDelegate = delegateToAssign;
        return cell;
    }
    NSLog(@"option cell was not set");
    return nil;
}

#pragma text field delegates

    //- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    static NSString *CellIdentifier = @"textCell";
//    
//    // Configure the cell...
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
//    if (cell == nil) {
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
//    }
//    
//    // Configure the cell...
//    
//    UITextField *textentry = [[UITextField alloc] init];
//    textentry.delegate = self;
//    textentry.tag = (indexPath.section + titletag);
//    //    NSLog(@"Cell created for %@ at section %ld and row %ld",sectitle,(long)textentry.tag, (long)indexPath.row);
//    textentry.autocorrectionType = UITextAutocorrectionTypeNo;
//    [textentry setInputAccessoryView:[self createInputAccessoryViewWithTags:(indexPath.section + titletag)]];
//    textentry.clearsOnBeginEditing = YES;
//    if ([_mutableFormObject valueForKey:[UserInfoArray objectAtIndex:indexPath.section]] != NULL){
//        textentry.text = [_mutableFormObject valueForKey:[UserInfoArray objectAtIndex:indexPath.section]];
//    }
//    
//    
//    [cell.contentView addSubview:textentry];
//    [self configureCell:cell atIndexPath:indexPath];
//    cell.selectionStyle = UITableViewCellSelectionStyleGray;
//            [cell setNeedsUpdateConstraints];
//        [cell updateConstraintsIfNeeded];
//        return cell;
//}
//
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    [self.txtActiveField resignFirstResponder];
//    self.txtActiveField = nil;
//    self.currentSelection = indexPath;
//    NSLog(@"Table Selected lable %@ at row %ld and section %ld" ,[self.UserInfoArray objectAtIndex:indexPath.section],(long)indexPath.row,(long)indexPath.section);
//    UITextField *textField = (UITextField *)[self.view viewWithTag:(currentSelection.section+titletag)];
//    [textField becomeFirstResponder];
//    self.txtActiveField = textField;
//    //    [[[[tableView cellForRowAtIndexPath:indexPath] contentView] viewWithTag:(indexPath.section+titletag)] becomeFirstResponder];
//    
//}
//- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    NSLog(@"Will Desplay Cell Called");
//    if (indexPath == self.currentSelection){
//        NSLog(@"Display cell should be selected");
//        [self.tableView selectRowAtIndexPath:currentSelection animated:YES scrollPosition: UITableViewScrollPositionNone];
//        [self.tableView scrollToRowAtIndexPath:currentSelection atScrollPosition:UITableViewScrollPositionNone animated:YES];
//        [[[[tableView cellForRowAtIndexPath:indexPath] contentView] viewWithTag:(indexPath.section+titletag)] becomeFirstResponder];
//    }
//    
//    
//}
//- (void)configureCell:(UITableViewCell *)theCell atIndexPath:(NSIndexPath *)indexPath {
//    // Get the text field using the tag
//    UITextField *textField = (UITextField *)[theCell.contentView viewWithTag:(indexPath.section+titletag)];
//    
//    // Position the text field within the cell bounds
//    CGRect cellBounds = theCell.bounds;
//    CGFloat textFieldBorder = 10.f;
//    // Don't align the field exactly in the vertical middle, as the text
//    // is not actually in the middle of the field.
//    CGRect aRect = CGRectMake(textFieldBorder, 9.f, CGRectGetWidth(cellBounds)-(2*textFieldBorder), 31.f );
//    textField.frame = aRect;
//    textField.tag = (indexPath.section + titletag);
//    //        textField.autocapitalizationType = UITextAutocapitalizationTypeWords;
//    
//
//    
//}
//
//- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
//    //    if (textField.tag == 1){
//    //        return NO;
//    //    }
//    //    else{
//    //        return YES;
//    //    }
//    NSInteger position = textField.tag-titletag;
//    NSLog(@"%@ Should begin editing at index %ld",self.UserInfoArray[position],(long)position);
//    currentSelection = [NSIndexPath indexPathForRow:0 inSection:(textField.tag - titletag)];
//    [self.tableView selectRowAtIndexPath:currentSelection animated:NO scrollPosition: UITableViewScrollPositionNone];
//    [self.tableView scrollToRowAtIndexPath:currentSelection atScrollPosition:UITableViewScrollPositionNone animated:NO];
//    return YES;
//}
////-(IBAction)textFieldDidEndEditing:(UITextField *)textField
////{
////    NSInteger position = textField.tag-titletag;
////    NSLog(@"%@ did end editing at index %ld",self.UserInfoArray[position],(long)position);
////
////    [textField endEditing:YES];
////    [textField resignFirstResponder];
////
////}
//
//#pragma mark textfield toolbar
//-(void)gotoPrevTextfield: (id) sender
//{
//    [self saveCurrentEntry:sender];
//    [_txtActiveField resignFirstResponder];
//    _txtActiveField = nil;
//    
//    
//    //    NSLog(@"%@ Should display at index %ld",self.UserInfoArray[position-1],(long)(position-1));
//    UIBarButtonItem *sendbut = sender;
//    NSInteger position = (sendbut.tag - titletag);
//    NSInteger max =([self.UserInfoArray count] -1);
//    NSLog(@"Prev called from position %d",position );
//    NSLog(@"Current Selection is %d",(currentSelection.section ));
//    //    NSLog(@"Max array size = %d", max);
//    //    NSLog(@"First entry is %@", self.UserInfoArray[0]);
//    //    NSLog(@"Last entry is %@", self.UserInfoArray[max]);
//    currentSelection = nil;
//    if(position >= 0){
//        NSLog(@"Prev button hit from %@ at %ld", self.UserInfoArray[position],(long)position);
//        if(position!=0){
//            currentSelection = [NSIndexPath indexPathForRow:0 inSection:(position-1)];
//            NSLog(@"%@ Should display at index %ld",self.UserInfoArray[position-1],(long)(position-1));
//            
//        }
//        else{
//            NSLog(@"Reset to beginning: %@ Should display at index %ld",self.UserInfoArray[([self.UserInfoArray count]-1)],(long)(([self.UserInfoArray count]-1)));
//            
//            currentSelection = [NSIndexPath indexPathForRow:0 inSection:([self.UserInfoArray count]-1)];
//        }
//    }else{
//        NSLog(@"No current selection, reset to beginnig");
//        currentSelection = [NSIndexPath indexPathForRow:0 inSection:0];
//    }
//    UITextField *textField = (UITextField *)[self.view viewWithTag:(currentSelection.section+titletag)];
//    self.txtActiveField = textField;
//    [textField becomeFirstResponder];
//    //
//    //    [self.tableView scrollToRowAtIndexPath:currentSelection atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
//    //    [self.tableView selectRowAtIndexPath:currentSelection animated:YES scrollPosition: UITableViewScrollPositionMiddle];
//    
//    
//    
//    
//}
//
//-(void)gotoNextTextfield: (id) sender
//{
//    NSLog(@"Next typing called");
//    UIBarButtonItem *sendbut = sender;
//    NSInteger position = (sendbut.tag - titletag);
//    NSInteger max =([self.UserInfoArray count] -1);
//    NSLog(@"Next called from position %d",position );
//    NSLog(@"Current Selection is %d",(currentSelection.section ));
//    [self saveCurrentEntry:sender];
//    [_txtActiveField resignFirstResponder];
//    _txtActiveField = nil;
//    currentSelection = nil;
//    //Remember to check boundaries before just setting an indexpath or your app will crash!
//    
//    
//    
//    
//    //    NSLog(@"Array Size: %ld, currentsection :%ld, tag: %ld",(long)[self.UserInfoArray count],(long)currentSelection.section,(long)(currentSelection.section+titletag));
//    //    if(position){
//    NSLog(@"Next button hit from %@ at %ld", self.UserInfoArray[position],(long)position);
//    if(position !=([self.UserInfoArray count]-1))
//    {
//        NSLog(@"%@ Should display at index %ld",self.UserInfoArray[position+1],(long)(position+1));
//        
//        currentSelection = [NSIndexPath indexPathForRow:0 inSection:(position+1)];
//    }
//    else{
//        NSLog(@"Back to beginning, %@ Should display at index %ld",self.UserInfoArray[0],(long)(0));
//        self.currentSelection = nil;
//        self.currentSelection = [NSIndexPath indexPathForRow:0 inSection:0];
//    }
//    //    }else{
//    //        NSLog(@"No selection, back to beginning: %@ Should display at index %ld",self.UserInfoArray[0],(long)(0));
//    //
//    //        currentSelection = [NSIndexPath indexPathForRow:0 inSection:0];
//    //    }
//    UITextField *textField = (UITextField *)[self.view viewWithTag:(currentSelection.section+titletag)];
//    self.txtActiveField = textField;
//    [textField becomeFirstResponder];
//    
//    //    [self.tableView scrollToRowAtIndexPath:currentSelection atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
//    //    [self.tableView selectRowAtIndexPath:currentSelection animated:YES scrollPosition: UITableViewScrollPositionMiddle];
//    
//    
//}
//-(void)saveCurrentEntry: (id) sender {
//    UIBarButtonItem *sendbut = sender;
//    NSInteger position = (sendbut.tag - titletag);
//    
//    UITextField *textField = (UITextField *)[self.view viewWithTag:(position+titletag)];
//    
//    NSLog(@"Save Data text field tag %d \r\n button tag  %d \r\n currentPosition %d", (textField.tag - titletag), (sendbut.tag - titletag), currentSelection.section);
//    
//    [_mutableFormObject setValue: textField.text forKey:[UserInfoArray objectAtIndex:position]];
//    NSLog(@"Entry %@ saved for field %@ at section %ld",textField.text,[UserInfoArray objectAtIndex:position],(long)position);
//    [textField endEditing:YES];
//}
//-(void)doneTyping: (id) sender
//{
//    NSLog(@"Done typing called");
//    self.currentSelection = nil;
//    [_txtActiveField resignFirstResponder];
//    _txtActiveField = nil;
//    [self saveCurrentEntry:sender];
//
//}
//
//
//-(UIToolbar *)createInputAccessoryView
//{
//    UIToolbar* keyboard = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, self.tableView.bounds.size.width, 44)];
//    keyboard.barStyle = UIBarStyleDefault;
//    keyboard.tintColor = [UIColor lightGrayColor];
//    UIBarButtonItem* previousButton = [[UIBarButtonItem alloc] initWithTitle:@"Previous" style:UIBarButtonItemStylePlain target:self action:@selector(gotoPrevTextfield:)];
//    UIBarButtonItem* nextButton = [[UIBarButtonItem alloc] initWithTitle:@"Next" style:UIBarButtonItemStylePlain target:self action:@selector(gotoNextTextfield:)];
//    UIBarButtonItem* flexSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
//    UIBarButtonItem* doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneTyping:)];
//    [keyboard setItems:[NSArray arrayWithObjects: previousButton, nextButton, flexSpace, doneButton, nil] animated:NO];
//    return keyboard;
//}
//
//#pragma mark rest
//
//-(IBAction)saveUser:(id)sender{
//    [self.managedObjectContext save:nil];
//    NSLog(@"%@" ,_mutableFormObject);
//    int counter = 0;
//    //    for( NSString* key in UserInfoArray){
//    //    UITextField *textField = (UITextField *)[self.view viewWithTag:(counter+titletag)];
//    //        [user setValue:textField.text forKey:key];
//    //        counter++;
//    //    }
//    [self.navigationController popViewControllerAnimated:YES];
//    
//}

@end
