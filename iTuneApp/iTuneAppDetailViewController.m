//
//  iTuneAppDetailViewController.m
//  iTuneApp
//
//  Created by synerzip on 30/10/14.
//  Copyright (c) 2014 ___FULLUSERNAME___. All rights reserved.
//

#import "iTuneAppDetailViewController.h"

@interface iTuneAppDetailViewController ()
- (void)configureView;
@end

@implementation iTuneAppDetailViewController

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem
{
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        
        // Update the view.
        [self configureView];
    }
}

- (void)configureView
{
       if (self.detailItem) {
       
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _lblAppName.text = _appNameString ;
    _lblArtist.text = _artistString;
    _lblPrice.text = _priceString;
    _lblReleaseDate.text = _releaseDateString;
    _lblCatagory.text = _categoryString;
    _lblRights.text = _rightString;
    _appIcon.image = _iconImage;
    [self configureView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
