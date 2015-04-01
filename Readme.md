DynamicTableGenerator is 
An Objective-C static library that makes creating table view forms, settings panels, and any form of user input quick and simple.


####[iOS Acknowledgements- Example](https://github.com/TheoBrown/easyIOS-acknowledgements)

###Object/Form Setup

```Objective-C

@interface TestObject : NSObject
@property (nonatomic, retain) NSDate * birth_date__dtd;
@property (nonatomic, retain) NSString * first_name;
@property (nonatomic, retain) NSString * last_name;
@property (nonatomic, retain) NSString * email__e;
@property (nonatomic, retain) NSString * phone__p;
@property (nonatomic, retain) NSString * website__u;
@property (nonatomic, retain) NSString * address;
@property (nonatomic, retain) NSNumber * age__i;
@property (nonatomic, retain) NSNumber * organizer_id__d;
@property (nonatomic, retain) NSNumber * group_member__b;
@property (nonatomic, retain) NSNumber * gpa__f;
@end

```

###Table View Setup and Display

```Objective-C
        TestObject* newObject = [[TestObject alloc] init];
        DynamicTableViewObjectParser * formHelper = [[DynamicTableViewObjectParser alloc] initWithObject:newObject];
        DynamicTableViewController *tableview = [[DynamicTableViewController alloc] init];
        [tableview setupWithInputArray:[formHelper cellsArray]];
        [self.navigationController pushViewController:tableview animated:YES];

```

###Results

![Auto Generated TableView](http://imgur.com/K7BBsbs.png)
![Dates](http://imgur.com/15zsuiT.png)
![Text](http://imgur.com/5LZOoGC.png)
![Numbers](http://imgur.com/AnMvRLN.png)
![Floats](http://imgur.com/dGilmNE.png)

The attributes within TestObject will automatically be converted into UITableViewCells with delgate methods to assign values to the model from UI.

After the tableview dismisses, all of the user entered data is accessable in ```newObject```

