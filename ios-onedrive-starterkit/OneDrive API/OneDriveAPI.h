//
//  OneDriveAPI.h
//  ios-onedrive-starterkit
//
//  Created by Guven Bolukbasi on 24.07.2018.
//  Copyright © 2018 dorianlabs. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol OneDriveAPI <NSObject>

- (BOOL) isLoggedIn;

- (void) rootItem:(void (^)(ODItem *response, NSError *error)) handler;

- (void) itemWithId: (NSString*) itemId completionHandler:(void (^)(ODItem *response, NSError *error)) handler;

- (void) logoutWithHandler: (void (^)(NSError *error)) handler;

@end
