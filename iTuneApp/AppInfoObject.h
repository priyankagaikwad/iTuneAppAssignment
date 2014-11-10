//
//  AppInfoObject.h
//  iTuneApp
//
//  Created by synerzip on 31/10/14.
//  Copyright (c) 2014 synerzip. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AppInfoObject : NSObject <NSCoding>

@property (nonatomic,strong) NSString *appName, *imageURL, *rights, *link, *price, *artist, *category, *releaseDate;
@property (nonatomic,strong) UIImage *appIcon;

- (instancetype)initWithJsonData:(NSDictionary *) jsonInfo;

@end
