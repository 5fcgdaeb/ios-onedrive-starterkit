//
//  StarterKitOneDriveAPI.h
//  ios-onedrive-starterkit
//
//  Created by Guven Bolukbasi on 24.07.2018.
//  Copyright © 2018 dorianlabs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OneDriveAPI.h"

@interface StarterKitOneDriveAPI : NSObject <OneDriveAPI>

- (instancetype)init: (ODClient*) client;

@end
