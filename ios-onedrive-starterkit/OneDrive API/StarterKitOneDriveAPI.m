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

- (void) rootItem:(void (^)(ODItem *response, NSError *error))completionHandler {
    
    [[[[self.client drive] items:@"root"] request] getWithCompletion:completionHandler];
    
}

- (void) itemWithId: (NSString*) itemId completionHandler:(void (^)(ODItem *response, NSError *error)) handler {
    
    [[[[self.client drive] items:itemId]  request] getWithCompletion: handler];
    
}

- (void) logoutWithHandler: (void (^)(NSError *error)) handler {
    
    [self.client signOutWithCompletion:handler];
    
}

@end
