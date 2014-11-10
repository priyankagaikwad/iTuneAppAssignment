//
//  iTuneAppAppDelegate.h
//  iTuneApp
//
//  Created by synerzip on 30/10/14.
//  Copyright (c) 2014 ___FULLUSERNAME___. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Reachability.h"

@interface iTuneAppAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic) BOOL hasInternet;
@property (nonatomic,strong) NSMutableDictionary *loadimageDictionary;
@property (nonatomic,strong) NSMutableDictionary *imageDictionary;
@property (nonatomic,strong) NSString *filePathToStoreImageDictionry;
@property (nonatomic) NSMutableArray *appInfoAllObjects;

-(NSString *) stringFromStatus: (NetworkStatus) status;
@end
