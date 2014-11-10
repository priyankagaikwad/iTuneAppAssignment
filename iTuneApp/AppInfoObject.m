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

- (id)initWithCoder:(NSCoder *)decoder {
    self = [super init];
    if (!self) {
        return nil;
    }
    self.appName = [decoder decodeObjectForKey:@"appName"];
    self.imageURL = [decoder decodeObjectForKey:@"imageURL"];
    self.rights = [decoder decodeObjectForKey:@"rights"];
    self.link  = [decoder decodeObjectForKey:@"link"];
    self.category = [decoder decodeObjectForKey:@"category"];
    self.price = [decoder decodeObjectForKey:@"price"];
    self.artist = [decoder decodeObjectForKey:@"artist"];
    self.releaseDate = [decoder decodeObjectForKey:@"releaseDate"];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
    
    [encoder encodeObject:self.appName forKey:@"appName"];
    [encoder encodeObject:self.imageURL forKey:@"imageURL"];
    [encoder encodeObject:self.rights forKey:@"rights"];
    [encoder encodeObject:self.link  forKey:@"link"];
    [encoder encodeObject:self.category forKey:@"category"];
    [encoder encodeObject:self.price forKey:@"price"];
    [encoder encodeObject:self.artist forKey:@"artist"];
    [encoder encodeObject:self.releaseDate forKey:@"releaseDate"];
}

@end
