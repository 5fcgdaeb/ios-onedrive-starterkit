# ios-onedrive-starterkit
A project that offers a very smooth integration to OneDrive API. Feel free to use the code in your integration projects; it should help you get started quickly.

# Installation
2 integration options are available:

1. Via Cocoapods in the **master** branch. Simply do a **pod install** after cloning the project.
2. Old style drag and drop project file integration. This is offered in the **retro_dependency** branch. No installation steps required after cloning this branch. You just need to have the onedrive-ios-sdk project in the same directory level.


# Usage

The project offers a very simple and lean interface to the OneDrive API. It provides one higher level of abstraction to the OneDrive API. Here is how the interface looks like:

```
@protocol OneDriveAPI <NSObject>

- (instancetype)init: (ODClient*) client;

- (BOOL) isLoggedIn;
- (void) logoutWithHandler: (void (^)(NSError *error)) handler;

- (void) rootFolder:(void (^)(ODItem *folder, NSError *error)) handler;
- (void) itemWithId: (NSString*) itemId completionHandler:(void (^)(ODItem *item, NSError *error)) handler;
- (void) downloadItemWithId: (NSString*) itemId completionHandler: (void (^)(NSURL *location, NSURLResponse *response, NSError *error)) handler;

- (void) uploadToRootFolder: (NSData*) data withFileName:(NSString*) filename completionHandler: (void (^)(ODItem *response, NSError *error)) handler;
- (void) uploadToFolderId: (NSString*) folderItemId theData: (NSData*) data withFileName:(NSString*) filename completionHandler: (void (^)(ODItem *response, NSError *error)) handler;


@end
```
