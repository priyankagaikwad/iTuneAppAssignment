//
//  storeiTuneAppObject.h
//  iTuneApp
//
//  Created by synerzip on 30/10/14.
//  Copyright (c) 2014 synerzip. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface storeiTuneAppObject : NSObject


@property (nonatomic,strong) NSMutableArray *applicationInfoObjects;

- (instancetype)initWithJsonData:(NSData *) allJsonData;

@end
