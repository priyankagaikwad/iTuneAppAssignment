//
//  ApplicationCell.h
//  iTuneApp
//
//  Created by synerzip on 31/10/14.
//  Copyright (c) 2014 synerzip. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppInfoObject.h"
@interface ApplicationCell : UITableViewCell

@property (nonatomic,strong) AppInfoObject * applicationObject;
@property (nonatomic,strong) UIImageView *appIcon;
@property (nonatomic,strong) UILabel *appNameLabel;

@end
