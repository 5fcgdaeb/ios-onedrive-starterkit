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
    
}

- (IBAction) authenticateTapped: (id)sender {
    
    [ODClient clientWithCompletion:^(ODClient *client, NSError *error){
        if (error){
            NSLog(error.localizedDescription);
        }
        else {
            NSLog(@"Success");
        }
    }];
}

- (IBAction) viewTapped: (id)sender {
}

- (IBAction) uploadTapped: (id)sender {
}

- (IBAction) logoutTapped: (id)sender {
}



@end
