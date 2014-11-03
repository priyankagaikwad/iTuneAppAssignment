//
//  iTuneAppDetailViewController.h
//  iTuneApp
//
//  Created by synerzip on 30/10/14.
//  Copyright (c) 2014 ___FULLUSERNAME___. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface iTuneAppDetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;
@property (weak, nonatomic) IBOutlet UIImageView *appIcon;
@property (weak, nonatomic) IBOutlet UILabel *lblAppName;
@property (weak, nonatomic) IBOutlet UILabel *lblArtist;
@property (weak, nonatomic) IBOutlet UILabel *lblPrice;
@property (weak, nonatomic) IBOutlet UIButton *btnLink;
@property (weak, nonatomic) IBOutlet UILabel *lblCatagory;
@property (weak, nonatomic) IBOutlet UILabel *lblReleaseDate;
@property (weak, nonatomic) IBOutlet UILabel *lblRights;

@property (strong,nonatomic) NSString *appNameString, *rightString, *priceString, *artistString, *releaseDateString, *linkString, *categoryString;
@property (strong,nonatomic) UIImage *iconImage;

@end
