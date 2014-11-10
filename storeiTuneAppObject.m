//
//  storeiTuneAppObject.m
//  iTuneApp
//
//  Created by synerzip on 30/10/14.
//  Copyright (c) 2014 synerzip. All rights reserved.
//

#import "storeiTuneAppObject.h"
#import "AppInfoObject.h"
#import "iTuneAppAppDelegate.h"


@implementation storeiTuneAppObject

iTuneAppAppDelegate *appDelegate;

- (instancetype)initWithJsonData:(NSData *)iTuneData
{
    appDelegate = [[UIApplication sharedApplication] delegate];
    
    
    NSString *pathString = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    NSString *filePathToStoreJson =[pathString stringByAppendingFormat:@"/iTuneData.plist"];
    
    _applicationInfoObjects = [[NSMutableArray alloc] init];
    NSDictionary *feedDictionary;
    
    
    //  NSString *pathString = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    //  NSString *filePathToStoreJson = [pathString stringByAppendingFormat:@"/iTuneData.plist"];
    //NSMutableArray *appInfoAllObjects = [NSMutableArray array];
    // appInfoAllObjects = [NSKeyedUnarchiver unarchiveObjectWithFile:filePathToStoreJson];
    
    
    //if(appInfoAllObjects != nil)  {
    _applicationInfoObjects = [NSKeyedUnarchiver unarchiveObjectWithFile:filePathToStoreJson];
    
    //}
    
    if(appDelegate.hasInternet)
    {
        NSDictionary *allJsonData = [NSJSONSerialization JSONObjectWithData:iTuneData options:NSJSONReadingAllowFragments error:nil];
        
        if (appDelegate.hasInternet)  {
            feedDictionary = allJsonData[@"feed"];
        }
        
        NSArray *entry = feedDictionary[@"entry"];
        
        NSMutableArray *appInfoAllObjects = [[NSMutableArray alloc]init];
        
        for (NSDictionary *info in entry) {
            
            AppInfoObject *appInfoObj = [[AppInfoObject alloc] initWithJsonData:info];
            
            [appInfoAllObjects addObject:appInfoObj ];
            
        }
        [NSKeyedArchiver archiveRootObject:appInfoAllObjects toFile:filePathToStoreJson];
    }
    return self;
}

@end
