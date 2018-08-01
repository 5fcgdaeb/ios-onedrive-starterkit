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
    self.client.logger = [[ODLogger alloc] initWithLogLevel:ODLogVerbose];
    return self;
}

- (BOOL) isLoggedIn {
    return self.client != nil;
}

- (void) logoutWithHandler: (void (^)(NSError *error)) handler {
    
    [self.client signOutWithCompletion:handler];
    
}

- (void) rootFolder:(void (^)(ODItem *folder, NSError *error))completionHandler {
    
//    ODItemRequestBuilder* itemRequestBuilder = [[self.client drive] items:@"root"];
//    ODChildrenCollectionRequestBuilder* collectionBuilder = [itemRequestBuilder children];
//    ODChildrenCollectionRequest* request = [collectionBuilder request];
    
//    [self availableDrives];
    [[[[self.client drive] items:@"root"] request] getWithCompletion:completionHandler];
    
//    [[[[[self.client drive] items:@"root"] children] request] getWithCompletion:^(ODCollection *response, ODChildrenCollectionRequest *nextRequest, NSError *error) {
//        for(ODItem* item in response.value) {
//            NSLog(item.id);
//        }
//    }];
    
}

- (void) itemWithId: (NSString*) itemId completionHandler:(void (^)(ODItem *item, NSError *error)) handler {
    
    [[[[self.client drive] items:itemId] request] getWithCompletion: handler];
    
}

- (void) downloadItemWithId: (NSString*) itemId completionHandler: (void (^)(NSURL *location, NSURLResponse *response, NSError *error)) handler {
    
    [[[[self.client drive] items:itemId] contentRequest] downloadWithCompletion:^(NSURL *location, NSURLResponse *response, NSError *error) {
        handler(location, response, error);
    }];
}

- (void) uploadToRootFolder: (NSData*) data withFileName:(NSString*) filename completionHandler: (void (^)(ODItem *response, NSError *error)) handler {
    
    ODItemContentRequest* request = [[[[self.client drive] items:@"root"] itemByPath:filename] contentRequest];
    
    [request uploadFromData:data completion:^(ODItem *response, NSError *error) {
        handler(response, error);
    }];
}

- (void) uploadToFolderId: (NSString*) folderItemId theData: (NSData*) data withFileName:(NSString*) filename completionHandler: (void (^)(ODItem *response, NSError *error)) handler {
    
    ODItemContentRequest* request = [[[[self.client drive] items:folderItemId] itemByPath:filename] contentRequest];
    
    [request uploadFromData:data completion:^(ODItem *response, NSError *error) {
        handler(response, error);
    }];
}

- (void) availableDrives {
    
    [[[[self.client drives] drive:@"sites/BoxDCTMMigration/drive"] request] getWithCompletion:^(ODDrive *response, NSError *error) {
        NSLog(@"hello");
    }];

}
@end
