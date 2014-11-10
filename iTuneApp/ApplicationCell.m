//
//  ApplicationCell.m
//  iTuneApp
//
//  Created by synerzip on 31/10/14.
//  Copyright (c) 2014 synerzip. All rights reserved.
//

#import "ApplicationCell.h"
#import "AppInfoObject.h"
#import "iTuneAppAppDelegate.h"
@implementation ApplicationCell

iTuneAppAppDelegate *appDelegate;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle: style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth |  UIViewAutoresizingFlexibleHeight;
        self.contentView.autoresizingMask =  UIViewAutoresizingFlexibleWidth |  UIViewAutoresizingFlexibleHeight;
        
        _appNameLabel = [[UILabel alloc] initWithFrame: CGRectZero];
        _appNameLabel.numberOfLines = 0;
        [_appNameLabel setFont:[UIFont fontWithName:@"HelveticaNeue" size:17.0]];
        [self.contentView addSubview: _appNameLabel];
        
        _subtitle = [[UILabel alloc] initWithFrame: CGRectZero];
        _subtitle.numberOfLines = 0;
        [_subtitle setFont:[UIFont fontWithName:@"HelveticaNeue" size:14.0]];
        [self.contentView addSubview: _subtitle];
        
        
        _appIcon = [[UIImageView alloc] initWithFrame: CGRectZero];
        [_appIcon setBackgroundColor: [UIColor lightGrayColor]];
        [self.contentView addSubview: _appIcon];
    }
    return self;
}

- (void)setApplicationObject:(AppInfoObject *)appObject
{
    _applicationObject = appObject;
    
    self.appNameLabel.text = _applicationObject.appName;
    self.detailTextLabel.text = _applicationObject.artist;
    _appIcon.image = nil;
    __block UIImage *image ;
    if (appObject.appIcon == nil)
    {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            if(appDelegate.hasInternet) {
            [self downloadImage:appObject.imageURL andSaveAs:appObject.appName];
            }
            
            if (appDelegate.loadimageDictionary != nil) {
                NSData *data = [NSData dataWithContentsOfFile:[appDelegate.loadimageDictionary valueForKey:appObject.imageURL]];
                if(data) {
                    image = [UIImage imageWithData:data];
                }
                else {
                    image = [UIImage imageWithData:[ NSData dataWithContentsOfURL:[ NSURL URLWithString:appObject.imageURL]]];
                }
                
            }
            //            else {
            //                image = [UIImage imageWithData:[ NSData dataWithContentsOfURL:[ NSURL URLWithString:appObject.imageURL]]];
            //            }
            dispatch_async(dispatch_get_main_queue(),^{
                appObject.appIcon = image;
                _appIcon.image = image;
                
            });
        });
    }
    else
    {
        _appIcon.image = appObject.appIcon;
    }
}

- (void)downloadImage:(NSString *)imageURLString andSaveAs:(NSString *)labelAsImageName
{
    NSURL *imageURL = [[NSURL alloc] initWithString:imageURLString ];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *docPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    NSString *imageName = [NSString stringWithFormat:@"%@%@",labelAsImageName,@".png"];
    NSString *pathToSaveImage = [docPath stringByAppendingPathComponent:imageName];
    
    if (![fileManager fileExistsAtPath:pathToSaveImage]) {
        NSString *pathTosaveImage = [docPath stringByAppendingPathComponent:imageName];
        NSData *offlineImageData = [NSData dataWithContentsOfURL:imageURL];
        if (offlineImageData) {
            [offlineImageData writeToFile:pathTosaveImage atomically:YES];
            
        }
    }
    [appDelegate.imageDictionary setValue:pathToSaveImage forKey:imageURLString];
    //    NSString *pathString = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    //
    //    NSString *filePathToStoreImageDictionry = [pathString stringByAppendingFormat:@"/imageDictionary.plist"];
    [appDelegate.imageDictionary writeToFile:appDelegate.filePathToStoreImageDictionry atomically:YES];
}

-(UILabel *) detailTextLabel
{
    return self.subtitle;
}

- (void)layoutSubviews
{
    CGRect contentViewFrame = self.contentView.frame;
    
    CGRect appIconFrame = _appIcon.frame;
    appIconFrame.origin.x = 10.0;
    appIconFrame.origin.y = (CGRectGetHeight(contentViewFrame) - 52)/2;
    appIconFrame.size = CGSizeMake(52, 52);
    _appIcon.frame = appIconFrame;
    
    CGRect appNameLabelFrame = _appNameLabel.frame;
    appNameLabelFrame.origin.x = CGRectGetMaxX(appIconFrame) + 10.0;
    appNameLabelFrame.origin.y = 0;
    appNameLabelFrame.size.width = CGRectGetWidth(contentViewFrame) - CGRectGetMaxX(appIconFrame) - (2*10.0);
    appNameLabelFrame.size.height =  CGRectGetHeight(contentViewFrame)/2;
    _appNameLabel.frame = appNameLabelFrame;
    
    CGRect subtitleFrame = _subtitle.frame;
    subtitleFrame.origin.x = CGRectGetMaxX(appIconFrame) + 10.0;
    subtitleFrame.origin.y = CGRectGetHeight(appNameLabelFrame);
    subtitleFrame.size.width = CGRectGetWidth(contentViewFrame) - CGRectGetMaxX(appIconFrame) - (2*10.0);
    subtitleFrame.size.height =  CGRectGetHeight(contentViewFrame)/2;
    _subtitle.frame = subtitleFrame;
    
}

@end
