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
@property (weak, nonatomic) IBOutlet UIButton *downloadtemButton;
@property (weak, nonatomic) IBOutlet UIButton *uploadButton;
@property (weak, nonatomic) IBOutlet UIButton *uploadByIdButton;
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
        self.downloadtemButton.enabled = YES;
        self.uploadButton.enabled = YES;
        self.uploadByIdButton.enabled = YES;
        self.logoutButton.enabled = YES;
    }
    else {
        self.authenticateButton.enabled = YES;
        self.viewRootButton.enabled = NO;
        self.fetchItemButton.enabled = NO;
        self.downloadtemButton.enabled = NO;
        self.uploadButton.enabled = NO;
        self.uploadByIdButton.enabled = NO;
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
            dispatch_async(dispatch_get_main_queue(), ^{
                [self launchItemDetailVCWithItem:folder];
            });
        }
    }];

}

- (IBAction) viewItemTapped: (id)sender {
    
    [self.api itemWithId:@"01MATGSSLIAGYPF2S22NAIGPWV3MW3KGIE" completionHandler:^(ODItem *item, NSError *error) {
        if (error){
            NSLog(@"%@", error.localizedDescription);
        }
        else {
            NSLog(@"%@", item.debugDescription);
            dispatch_async(dispatch_get_main_queue(), ^{
                [self launchItemDetailVCWithItem:item];
            });
        }
    }];
}

- (IBAction) downloadItembyIdTapped: (id)sender {
    
    [self.api downloadItemWithId:@"01MATGSSLIAGYPF2S22NAIGPWV3MW3KGIE" completionHandler:^(NSURL *location, NSURLResponse *response, NSError *error) {
        
        NSString* message = @"";
        if(error) {
            NSLog(@"%@", error.localizedDescription);
            message = error.localizedDescription;
        }
        else {
            message = [NSString stringWithFormat:@"Download success, item is at %@", location.absoluteString];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self displayMessage:message];
        });
        
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
    
    [self.api uploadToRootFolder:data withFileName:@"Sample_PDF.pdf" completionHandler:^(ODItem *response, NSError *error) {
        
        NSString* message = @"";
        if(error) {
            NSLog(@"%@", error.localizedDescription);
            message = error.localizedDescription;
        }
        else {
            message = [NSString stringWithFormat:@"Upload success, item Id is %@", response.id];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self displayMessage:message];
        });
        
    }];
    
}

- (IBAction) uploadByIDTapped: (id)sender {
    
    NSString *filepath = [[NSBundle mainBundle] pathForResource:@"Sample_PDF" ofType:@"pdf"];
    NSError *error;
    NSData* data = [NSData dataWithContentsOfFile:filepath options:NSDataReadingMappedAlways error:&error];
    
    if (error) {
        NSLog(@"Error reading file: %@", error.localizedDescription);
        return;
    }
    
    // 01MATGSSK6KVIGNWFQTBHKMLW76BQL3V35 - Migration Folder
    // 01MATGSSN6Y2GOVW7725BZO354PWSELRRZ - Root Folder
    // 01MATGSSLIAGYPF2S22NAIGPWV3MW3KGIE - Sample.PDF at the root folder
    
    [self.api uploadToFolderId:@"016RHULP3BFEMRTZC7XBDLQV5ZCAYN34ZL" theData:data withFileName:@"Sample_PDF.pdf" completionHandler:^(ODItem *response, NSError *error) {
        NSString* message = @"";
        if(error) {
            NSLog(@"%@", error.localizedDescription);
            message = error.localizedDescription;
        }
        else {
            message = [NSString stringWithFormat:@"Upload success, item Id is %@", response.id];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self displayMessage:message];
        });
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

- (IBAction) unwind:(UIStoryboardSegue *) segue {
    NSLog(@"Unwind happened.");
}

- (void) launchItemDetailVCWithItem: (ODItem*) item {
    ItemDetailVC* itemDetailVC = (ItemDetailVC*) [self.storyboard instantiateViewControllerWithIdentifier:@"ItemDetailVC"];
    [itemDetailVC configureWithItem:item];
    itemDetailVC.modalPresentationStyle = UIModalPresentationFullScreen;
    [self presentViewController:itemDetailVC animated:YES completion:nil];
}

- (void) displayMessage: (NSString*) message {
    
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Info" message:message preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {}];
    
    [alert addAction:defaultAction];
    [self presentViewController:alert animated:YES completion:nil];
}

@end
