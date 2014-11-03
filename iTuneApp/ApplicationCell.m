//
//  ApplicationCell.m
//  iTuneApp
//
//  Created by synerzip on 31/10/14.
//  Copyright (c) 2014 synerzip. All rights reserved.
//

#import "ApplicationCell.h"
#import "AppInfoObject.h"

@implementation ApplicationCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle: style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth |  UIViewAutoresizingFlexibleHeight;
        self.contentView.autoresizingMask = UIViewAutoresizingFlexibleWidth |  UIViewAutoresizingFlexibleHeight;
        
        _appNameLabel = [[UILabel alloc] initWithFrame: CGRectZero];
        _appNameLabel.numberOfLines = 0;
        [_appNameLabel setFont:[UIFont fontWithName:@"HelveticaNeue" size:17.0]];
        [self.contentView addSubview: _appNameLabel];
        
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
    _appIcon.image = nil;
    
    if (appObject.appIcon == nil)
    {
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            UIImage *image = [UIImage imageWithData:[ NSData dataWithContentsOfURL:[ NSURL URLWithString:appObject.imageURL]]];
            
            dispatch_async(dispatch_get_main_queue(),^{
                _applicationObject.appIcon = image;
                _appIcon.image = image;
                
            });
        });
    }
    else {
        _appIcon.image = appObject.appIcon;
    }
    
}

- (void)layoutSubviews
{
    CGRect contentViewFrame = self.contentView.frame;
    
    CGRect appIconFrame = _appIcon.frame;
    appIconFrame.origin.x = 10.0;
    appIconFrame.origin.y = (CGRectGetHeight(contentViewFrame) - 40)/2;
    appIconFrame.size = CGSizeMake(40, 40);
    _appIcon.frame = appIconFrame;
    
    CGRect appNameLabelFrame = _appNameLabel.frame;
    appNameLabelFrame.origin.x = CGRectGetMaxX(appIconFrame) + 10.0;
    appNameLabelFrame.origin.y = 0;
    appNameLabelFrame.size.width = CGRectGetWidth(contentViewFrame) - CGRectGetMaxX(appIconFrame) - (2*10.0);
    appNameLabelFrame.size.height = CGRectGetHeight(contentViewFrame);
    _appNameLabel.frame = appNameLabelFrame;
    
}

@end
