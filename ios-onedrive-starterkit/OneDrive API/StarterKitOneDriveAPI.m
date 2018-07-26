//
//  StarterKitOneDriveAPI.m
//  ios-onedrive-starterkit
//
//  Created by Guven Bolukbasi on 24.07.2018.
//  Copyright © 2018 dorianlabs. All rights reserved.
//

#import "StarterKitOneDriveAPI.h"

@interface StarterKitOneDriveAPI ()
@property(strong) ODClient* client;
@end

@implementation StarterKitOneDriveAPI

- (instancetype)init: (ODClient*) client {
    self = [super init];
    self.client = client;
    return self;
}

- (BOOL) isLoggedIn {
    return self.client != nil;
}

- (void) logoutWithHandler: (void (^)(NSError *error)) handler {
    
    [self.client signOutWithCompletion:handler];
    
}

- (void) rootFolder:(void (^)(ODItem *folder, NSError *error))completionHandler {
    
    [[[[self.client drive] items:@"root"] request] getWithCompletion:completionHandler];
    
}

- (void) itemWithId: (NSString*) itemId completionHandler:(void (^)(ODItem *item, NSError *error)) handler {
    
    [[[[self.client drive] items:itemId] request] getWithCompletion: handler];
    
}

- (void) uploadToRootFolder: (NSData*) data withFileName:(NSString*) filename completionHandler: (void (^)(NSError *error)) handler {
    
    ODItemContentRequest* request = [[[[self.client drive] items:@"root"] itemByPath:filename] contentRequest];
    
    [request uploadFromData:data completion:^(ODItem *response, NSError *error) {
        handler(error);
    }];
}

- (void) uploadToFolderId: (NSString*) folderItemId theData: (NSData*) data withFileName:(NSString*) filename completionHandler: (void (^)(NSError *error)) handler {
    
    ODItemContentRequest* request = [[[self.client drive] items:folderItemId] contentRequest];
    
    [request uploadFromData:data completion:^(ODItem *response, NSError *error) {
        handler(error);
    }];
}

- (void) availableDrives {
    [[[self.client drives] request] getWithCompletion:^(ODCollection *response, ODDrivesCollectionRequest *nextRequest, NSError *error) {
        NSLog(@"hello");
    }];
}

@end
