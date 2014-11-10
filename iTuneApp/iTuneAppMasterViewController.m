//
//  iTuneAppMasterViewController.m
//  iTuneApp
//
//  Created by synerzip on 30/10/14.
//  Copyright (c) 2014 ___FULLUSERNAME___. All rights reserved.
//

#import "iTuneAppMasterViewController.h"
#import "iTuneAppDetailViewController.h"
#import "storeiTuneAppObject.h"
#import "AppInfoObject.h"
#import "ApplicationCell.h"
#import "iTuneAppAppDelegate.h"

#define URL @"https://itunes.apple.com/us/rss/newfreeapplications/limit=2/json"

iTuneAppAppDelegate *appDelegate;

@interface iTuneAppMasterViewController ()

@property ( nonatomic,strong) storeiTuneAppObject *storeInfo;
@property ( nonatomic,strong) NSURLSession *session;
@end

@implementation iTuneAppMasterViewController

- (void)awakeFromNib
{
    [super awakeFromNib];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSURLSessionConfiguration *config = [ NSURLSessionConfiguration ephemeralSessionConfiguration];
    _session = [NSURLSession sessionWithConfiguration : config];
    
    [self.tableView addSubview:_activity];
    [self.tableView bringSubviewToFront:_activity];
    _activity.center = self.tableView.center;
    [_activity startAnimating];
    [self parseJson];
    
}

- (void)parseJson
{
    NSURL *url = [[NSURL alloc] initWithString:URL];
    NSURLSessionDataTask *dataTask = [self.session dataTaskWithURL:url completionHandler : ^(NSData *iTuneData, NSURLResponse *response, NSError *error)
                                      {
                                          dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                                              _storeInfo = [[storeiTuneAppObject alloc] initWithJsonData:iTuneData];
                                              dispatch_async(dispatch_get_main_queue(),^{
                                                  [self.tableView reloadData];
                                              });
                                          });
                                      }];
    [dataTask resume];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _storeInfo.applicationInfoObjects.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    [_activity hidesWhenStopped];
    [_activity stopAnimating];
    ApplicationCell *cell = [[ApplicationCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier : @"Cell"];
    
    AppInfoObject *appInfo = _storeInfo.applicationInfoObjects[indexPath.row];
    cell.applicationObject = appInfo;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    return 66;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:@"showDetail" sender:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        AppInfoObject *appInfo = _storeInfo.applicationInfoObjects[indexPath.row];
        iTuneAppDetailViewController *detailViewController = segue.destinationViewController;
        
        detailViewController.appNameString = appInfo.appName ;
        detailViewController.iconImage = appInfo.appIcon;
        detailViewController.artistString = appInfo.artist ;
        detailViewController.priceString = appInfo.price;
        detailViewController.releaseDateString = appInfo.releaseDate;
        detailViewController.linkString = appInfo.link;
        detailViewController.categoryString = appInfo.category;
        detailViewController.rightString = appInfo.rights;
    }
}

@end
