//
//  ViewController.m
//  ios-onedrive-starterkit
//
//  Created by Guven Bolukbasi on 23.07.2018.
//  Copyright © 2018 dorianlabs. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [ODClient setActiveDirectoryAppId:@"APP_ID" redirectURL:@"REDIRECT_URL"];
    
}




@end
