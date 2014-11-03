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
    NSString *pathTosaveImage = [docPath stringByAppendingPathComponent:imageName];
    
    if (![fileManager fileExistsAtPath:pathTosaveImage]) {
        NSString *pathTosaveImage = [docPath stringByAppendingPathComponent:imageName];
        offlineImageData = [NSData dataWithContentsOfURL:imageUrl];
        _appIcon = [UIImage imageWithData:offlineImageData];
        if (offlineImageData) {
            [offlineImageData writeToFile:pathTosaveImage atomically:YES];
        }
    }
}

- (void)fetchImage
{
    NSString *stringPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0];
    NSArray * filePaths = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject] error:nil];
    for(int i = 0;i<[filePaths count];i++)
    {
        NSString *filePath = [filePaths objectAtIndex:i];
        if ([[filePath pathExtension] isEqualToString:@"jpg"] || [[filePath pathExtension] isEqualToString:@"png"] || [[filePath pathExtension] isEqualToString:@"PNG"]) {
            NSString *imagePath = [[stringPath stringByAppendingFormat:@"/"] stringByAppendingFormat:@"%@",filePath];
            
            NSString* imageNames = [[imagePath lastPathComponent] stringByDeletingPathExtension];
            if([_appName isEqualToString:imageNames]){
                
                NSData *data = [NSData dataWithContentsOfFile:imagePath];
                if(data) {
                    
                    UIImage *image = [UIImage imageWithData:data];
                    _appIcon = image;
                    break;
                }
            }
        }
    }
}

@end
