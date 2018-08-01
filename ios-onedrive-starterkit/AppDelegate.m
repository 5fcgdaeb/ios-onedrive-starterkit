//
//  AppDelegate.m
//  ios-onedrive-starterkit
//
//  Created by Guven Bolukbasi on 23.07.2018.
//  Copyright © 2018 dorianlabs. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"OneDriveKeys" ofType:@"plist"];
    NSDictionary *keysDictionary = [NSDictionary dictionaryWithContentsOfFile:path];
    
    if(!keysDictionary) {
        NSLog(@"You need to have OneDriveKeys.plist file in your app! Please go throught the README.md file again.");
        exit(-1);
    }
    
    NSString* appId = keysDictionary[@"applicationId"];;
    NSString* redirectURL = keysDictionary[@"redirectURL"];
    
    if(!appId || !redirectURL) {
        NSLog(@"You need to have right data in OneDriveKeys.plist file! Please go throught the README.md file again.");
        exit(-1);
    }
    
    [ODClient setActiveDirectoryAppId:appId redirectURL:redirectURL];
    
    NSString* apiEndpoint = keysDictionary[@"apiEndpoint"];;
    NSString* resourceId = keysDictionary[@"resource"];
    
    if(apiEndpoint && resourceId) {
        ODAppConfiguration* config = [ODAppConfiguration defaultConfiguration];
        config.activeDirectoryApiEndpointURL = apiEndpoint;
        config.activeDirectoryResourceId = resourceId;
    }
    
    return YES;
}


@end
