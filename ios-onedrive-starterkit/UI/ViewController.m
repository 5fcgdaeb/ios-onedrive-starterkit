//
//  ViewController.m
//  ios-onedrive-starterkit
//
//  Created by Guven Bolukbasi on 23.07.2018.
//  Copyright © 2018 dorianlabs. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property(strong) StarterKitOneDriveAPI* api;
@property (weak, nonatomic) IBOutlet UIButton *authenticateButton;
@property (weak, nonatomic) IBOutlet UIButton *viewRootButton;
@property (weak, nonatomic) IBOutlet UIButton *uploadButton;
@property (weak, nonatomic) IBOutlet UIButton *logoutButton;

@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self updateButtonEnableDisable];
    
}

- (void) updateButtonEnableDisable {
    
    if(self.api) {
        self.authenticateButton.enabled = NO;
        self.viewRootButton.enabled = YES;
        self.uploadButton.enabled = YES;
        self.logoutButton.enabled = YES;
    }
    else {
        self.authenticateButton.enabled = YES;
        self.viewRootButton.enabled = NO;
        self.uploadButton.enabled = NO;
        self.logoutButton.enabled = NO;
    }
}
- (IBAction) authenticateTapped: (id)sender {
    
    [ODClient clientWithCompletion:^(ODClient *client, NSError *error){
        if (error){
            NSLog(@"%@", error.localizedDescription);
        }
        else {
            self.api = [[StarterKitOneDriveAPI alloc] init:client];
            [self updateButtonEnableDisable];
            NSLog(@"Success");
        }
    }];
}

- (IBAction) viewTapped: (id)sender {
    
    [self.api rootItem:^(ODItem *response, NSError *error) {
        if (error){
            NSLog(@"%@", error.localizedDescription);
        }
        else {
            NSLog(@"%@", response.debugDescription);
        }
    }];
    
    [self.api itemWithId:@"01MATGSSN6Y2GOVW7725BZO354PWSELRRZ" completionHandler:^(ODItem *response, NSError *error) {
        if (error){
            NSLog(@"%@", error.localizedDescription);
        }
        else {
            NSLog(@"%@", response.debugDescription);
        }
    }];
    
//    [[[[[self.client drive] items:@"root"] children] request] getWithCompletion:^(ODCollection *response, ODChildrenCollectionRequest *nextRequest, NSError *error) {
//        if (error){
//            NSLog(@"%@", error.localizedDescription);
//        }
//        else {
//            for(ODItem* item in response.value) {
//                NSLog(@"%@", item.debugDescription);
//            }
//        }
//    }];
    

}

- (IBAction) uploadTapped: (id)sender {
}

- (IBAction) logoutTapped: (id)sender {
    
    [self.api logoutWithHandler:^(NSError *error) {
        if (error){
            NSLog(@"%@", error.localizedDescription);
        }
        else {
            [self updateButtonEnableDisable];
            NSLog(@"Signed out.");
        }
    }];
}



@end
