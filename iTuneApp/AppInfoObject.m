//
//  AppInfoObject.m
//  iTuneApp
//
//  Created by synerzip on 31/10/14.
//  Copyright (c) 2014 synerzip. All rights reserved.
//

#import "AppInfoObject.h"
#import "iTuneAppAppDelegate.h"

NSData *offlineImageData;

@implementation AppInfoObject

iTuneAppAppDelegate *appDelegate;

- (instancetype) initWithJsonData : (NSDictionary *)jsonInfo
{
    NSDictionary *nameDictionary, *rightsDictionary, *priceDictionary, *artistDictionary, *releaseDateDictionary, *linkDictionary, *categoryDictionary, *subDictionary;
    _imageDictionary = [[NSMutableDictionary alloc] init];
    
    nameDictionary = jsonInfo[@"im:name"];
    _appName = nameDictionary[@"label"];
    
    NSArray *images = jsonInfo[@"im:image"];
    NSDictionary *imageLogoDictionary = [images objectAtIndex:0];
    _imageURL = imageLogoDictionary[@"label"];
    //Download image for offline mode
    [self downloadImage:[[NSURL alloc] initWithString:_imageURL ] andSaveAs:nameDictionary[@"label"]];
    
    if (appDelegate.hasInternet) {
        _appIcon = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:_imageURL]]];
        
    }
    else {
        [self fetchImage];
    }
    
    artistDictionary = jsonInfo[@"im:artist"];
    _artist = artistDictionary[@"label"];
    
    priceDictionary = jsonInfo[@"im:price"];
    subDictionary = priceDictionary[@"attributes"];
    _price = [NSString stringWithFormat:@"%@%@",subDictionary[@"amount"], subDictionary[@"currency"]];
    
    releaseDateDictionary = jsonInfo[@"im:releaseDate"];
    subDictionary = releaseDateDictionary[@"attributes"];
    _releaseDate = subDictionary[@"label"];
    
    linkDictionary = jsonInfo[@"link"];
    subDictionary = linkDictionary[@"attributes"];
    _link = subDictionary[@"href"];
    
    categoryDictionary = jsonInfo[@"category"];
    subDictionary = categoryDictionary[@"attributes"];
    _category = subDictionary[@"label"];
    
    rightsDictionary = jsonInfo[@"rights"];
    _rights = rightsDictionary[@"label"];
    
    return self;
}

- (void)downloadImage:(NSURL *)imageUrl andSaveAs:(NSString *)labelAsImageName
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *docPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    NSString *imageName = [NSString stringWithFormat:@"%@%@",labelAsImageName,@".png"];
    _pathToSaveImage = [docPath stringByAppendingPathComponent:imageName];
    if (![fileManager fileExistsAtPath:_pathToSaveImage]) {
        NSString *pathTosaveImage = [docPath stringByAppendingPathComponent:imageName];
        offlineImageData = [NSData dataWithContentsOfURL:imageUrl];
        if (offlineImageData) {
            [offlineImageData writeToFile:pathTosaveImage atomically:YES];
        }
    }
}

- (void)fetchImage
{
     NSString *docPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    _imageDictionary = [NSMutableDictionary dictionaryWithContentsOfFile:[docPath stringByAppendingPathComponent:@"imageDictionary.txt"]];
    NSData *data = [NSData dataWithContentsOfFile:[_imageDictionary valueForKey:_imageURL]];
    if(data) {
        UIImage *image = [UIImage imageWithData:data];
        _appIcon = image;
    }
}

@end
