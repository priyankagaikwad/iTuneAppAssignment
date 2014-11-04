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
    NSString *filePathToStoreJson =[pathString stringByAppendingFormat:@"/iTuneData.json"];
    NSDictionary *allJsonData = [NSJSONSerialization JSONObjectWithData:iTuneData options:NSJSONReadingAllowFragments error:nil];
    
    NSDictionary *feedDictionary;
    if (appDelegate.hasInternet)  {
                feedDictionary = allJsonData[@"feed"];
    }
    else {
             feedDictionary = [NSMutableDictionary dictionaryWithContentsOfFile:filePathToStoreJson];
    }
    [feedDictionary writeToFile:filePathToStoreJson atomically:YES];
    NSArray *entry = feedDictionary[@"entry"];
    NSMutableDictionary *imageDictionary = [[NSMutableDictionary alloc] init];
    _applicationInfoObjects = [NSMutableArray array];
    for (NSDictionary *info in entry) {
        
        AppInfoObject *appInfoObj = [[AppInfoObject alloc] initWithJsonData:info];
        [_applicationInfoObjects addObject:appInfoObj];
        [imageDictionary setValue:appInfoObj.pathToSaveImage forKey:appInfoObj.imageURL];
        
    }
    if(appDelegate.hasInternet) {
        
    NSString *filePathToStoreImageDictionry = [pathString stringByAppendingFormat:@"/imageDictionary.txt"];
    [imageDictionary writeToFile:filePathToStoreImageDictionry atomically:YES];    
    }
    return self;
}

@end
