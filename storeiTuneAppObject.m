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

- (instancetype)storeJsonData:(NSData *)iTuneData
{
    appDelegate = [[UIApplication sharedApplication] delegate];
    
    NSString *pathString = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    NSString *filePath =[pathString stringByAppendingFormat:@"/iTuneData.json"];
    NSDictionary *allJsonData = [NSJSONSerialization JSONObjectWithData:iTuneData options:NSJSONReadingAllowFragments error:nil];
    
    NSDictionary *feedDictionary;
    if (appDelegate.hasInternet)  {
                feedDictionary = allJsonData[@"feed"];
    }
    else {
    //if (filePath)
    {
            feedDictionary = [NSMutableDictionary dictionaryWithContentsOfFile:filePath];
    }
//        else {
//            
//            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"No Network" message:@"No data available for offline mode!!!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//            [alert show];
//        }
        
    }
    [feedDictionary writeToFile:filePath atomically:YES];
    NSArray *entry = feedDictionary[@"entry"];
    
    _applicationInfoObjects = [NSMutableArray array];
    for (NSDictionary *info in entry)
    {
        AppInfoObject *appInfoObj = [[AppInfoObject alloc] initWithJsonData:info];
        [_applicationInfoObjects addObject:appInfoObj];
    }

    return self;
}

@end
