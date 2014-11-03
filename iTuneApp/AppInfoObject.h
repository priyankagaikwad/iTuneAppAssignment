//
//  AppInfoObject.h
//  iTuneApp
//
//  Created by synerzip on 31/10/14.
//  Copyright (c) 2014 synerzip. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AppInfoObject : NSObject

@property (nonatomic,strong) NSString *appName, *imageURL, *rights, *link, *price, *artist, *category, *releaseDate, *downloadImages,*directoryContents;
@property (nonatomic,strong) UIImage *appIcon;

- (instancetype)initWithJsonData:(NSDictionary *) jsonInfo;
- (void)downloadImage:(NSURL *)imageUrl andSaveAs:(NSString *)labelAsImageName;

@end
