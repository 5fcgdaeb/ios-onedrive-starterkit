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
@property (weak, nonatomic) IBOutlet UIButton *fetchItemButton;
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
        self.fetchItemButton.enabled = YES;
        self.uploadButton.enabled = YES;
        self.logoutButton.enabled = YES;
    }
    else {
        self.authenticateButton.enabled = YES;
        self.viewRootButton.enabled = NO;
        self.fetchItemButton.enabled = NO;
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
            dispatch_async(dispatch_get_main_queue(), ^{
                [self updateButtonEnableDisable];
            });
            NSLog(@"Success");
        }
    }];
}

- (IBAction) viewRootFolderTapped: (id)sender {
    
    [self.api rootFolder:^(ODItem *folder, NSError *error) {
        if (error){
            NSLog(@"%@", error.localizedDescription);
        }
        else {
            NSLog(@"%@", folder.debugDescription);
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

- (IBAction) viewItemTapped: (id)sender {
    
    [self.api itemWithId:@"01MATGSSN6Y2GOVW7725BZO354PWSELRRZ" completionHandler:^(ODItem *item, NSError *error) {
        if (error){
            NSLog(@"%@", error.localizedDescription);
        }
        else {
            NSLog(@"%@", item.debugDescription);
        }
    }];
}



- (IBAction) uploadTapped: (id)sender {
    
    NSString *filepath = [[NSBundle mainBundle] pathForResource:@"Sample_PDF" ofType:@"pdf"];
    NSError *error;
    NSData* data = [NSData dataWithContentsOfFile:filepath options:NSDataReadingMappedAlways error:&error];
    
    if (error) {
        NSLog(@"Error reading file: %@", error.localizedDescription);
        return;
    }
    
    [self.api uploadToRootFolder:data withFileName:@"Sample_PDF.pdf" completionHandler:^(NSError *error) {
        if(error) {
            NSLog(@"%@", error.localizedDescription);
        }
    }];
    
}

- (IBAction) logoutTapped: (id)sender {
    
    [self.api logoutWithHandler:^(NSError *error) {
        if (error){
            NSLog(@"%@", error.localizedDescription);
        }
        else {
            self.api = nil;
            dispatch_async(dispatch_get_main_queue(), ^{
                [self updateButtonEnableDisable];
            });
            NSLog(@"Signed out.");
        }
    }];
}



@end
