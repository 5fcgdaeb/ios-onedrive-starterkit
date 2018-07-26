//
//  OneDriveAPI.h
//  ios-onedrive-starterkit
//
//  Created by Guven Bolukbasi on 24.07.2018.
//  Copyright © 2018 dorianlabs. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol OneDriveAPI <NSObject>

- (instancetype)init: (ODClient*) client;

- (BOOL) isLoggedIn;
- (void) logoutWithHandler: (void (^)(NSError *error)) handler;

- (void) rootFolder:(void (^)(ODItem *folder, NSError *error)) handler;
- (void) itemWithId: (NSString*) itemId completionHandler:(void (^)(ODItem *item, NSError *error)) handler;

- (void) uploadToRootFolder: (NSData*) data withFileName:(NSString*) filename completionHandler: (void (^)(NSError *error)) handler;
- (void) uploadToFolderId: (NSString*) folderItemId theData: (NSData*) data withFileName:(NSString*) filename completionHandler: (void (^)(NSError *error)) handler;


@end
