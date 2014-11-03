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
@property (nonatomic, assign) BOOL hasInternet;

-(NSString *) stringFromStatus: (NetworkStatus) status;
@end
