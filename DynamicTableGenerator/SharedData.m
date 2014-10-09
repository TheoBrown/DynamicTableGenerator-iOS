//
//  SharedData.m
//  CoreDataTest
//
//  Created by Theodore Brown on 10/14/13.
//  Copyright (c) 2013 Theodore Brown. All rights reserved.
//

#import "SharedData.h"
#define kAPIServerHost @"http://192.155.94.103"//
#define kAPIServerPath @"/ImgProcSub/"
#define kAPIDeskHost @"http://192.168.1.100"
#define kAPIDeskPath @"/ImgProcSub/"
@implementation SharedData
@synthesize settings;
static SharedData *instance =nil;
#pragma mark - init
//intialize the API class with the deistination host name

-(SharedData*)init {
    NSLog(@"SharedData init");
    
    //call super init
    self = [super init];
    if (self != nil) {
        //initialize the object
        NSLog(@"This should only happen once: init");

//        HostIP = kAPIServerHost;
//        HostPath = kAPIServerPath;
//        useKeyChain = TRUE;
        settings = [NSUserDefaults standardUserDefaults];
        if ([self isFirstRun]){
            NSDictionary *mainDictionary = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"defaultGraphSettings" ofType:@"plist"]];
            NSLog(@"This if first run contents of plist");
            for (NSString* key in [mainDictionary allKeys]){
                NSLog(@"Key %@ found for value %@ of class %@", key,[[mainDictionary objectForKey:key] description],[[mainDictionary objectForKey:key] class]);
//                [[mainDictionary objectForKey:key] class]
                [settings setObject:[mainDictionary objectForKey:key] forKey:key];
            }
//            [settings setObject:kAPIServerHost forKey:@"HostIP"];
//            [settings setObject:kAPIServerPath forKey:@"HostPath"];
//            [settings setBool:TRUE forKey:@"useKeyChain"];
//            [settings setBool:TRUE forKey:@"useServerHost"];


        }


    }
    return self;
}

+(SharedData *)getInstance
{
    @synchronized(self)
    {
        if(instance==nil)
        {
            
            instance= [SharedData new];
        }
    }
    return instance;
}


#pragma mark - Data Access Methods
- (BOOL) isFirstRun
{
    if ([settings objectForKey:@"isFirstRun"])
    {
        return NO;
    }
    
    [settings setObject:[NSDate date] forKey:@"isFirstRun"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    return YES;
}
//-(NSString *)getString:(NSString*)value
//{
//    return [settings objectForKey:value];
//}
//
//-(int)getInt:(NSString*)value {
//    return [[settings objectForKey:value] intValue];
//}
//-(void)setValue:(NSString*)value newString:(NSString *)aValue {
//    [settings setObject:aValue forKey:value];
//}
//-(void)setValue:(NSString*)value newInt:(int)aValue {
//    [settings setObject:[NSString stringWithFormat:@"%i",aValue] forKey:value];
//}
-(void)save {
    // NOTE: You should be replace "MyAppName" with your own custom application string.
     [[NSUserDefaults standardUserDefaults] setObject:settings forKey:@"iDiagnostic"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
//-(void)load {
//    // NOTE: You should be replace "MyAppName" with your own custom application string. //
//    [settings addEntriesFromDictionary:[[NSUserDefaults standardUserDefaults] objectForKey:@"iDiagnostic"]];
//}
//// Logging function great for checkin out what keys/values you have at any given time //
//-(void)logSettings {
//    for(NSString* item in [settings allKeys]){
//        NSLog(@"[SettingsManager KEY:%@ - VALUE:%@]", item, [settings valueForKey:item]);
//    }
//}
@end