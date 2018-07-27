//
//  ItemDetailVC.m
//  ios-onedrive-starterkit
//
//  Created by Guven Bolukbasi on 26.07.2018.
//  Copyright © 2018 dorianlabs. All rights reserved.
//

#import "ItemDetailVC.h"

@interface ItemDetailVC ()
@property(strong) ODItem* item;
@property (weak, nonatomic) IBOutlet UITableView *itemDetailTableView;
@property(strong) NSMutableArray* itemDetails;
@property(strong) NSMutableArray* dataTitles;
@end

@implementation ItemDetailVC

- (void)configureWithItem:(ODItem *)item {
    self.item = item;
    [self configureDataTitles];
    
    self.itemDetails = [[NSMutableArray alloc] init];
    [self.itemDetails addObject:self.item.name];
    [self.itemDetails addObject:self.item.id];
    [self.itemDetails addObject:self.item.createdDateTime.description];
    [self.itemDetails addObject:[self fileOrFolderInfoForItem:self.item]];
    [self.itemDetails addObject:[self childrenInfoForItem:self.item]];
    
    [self.itemDetailTableView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"BasicCell"];
    NSString* theDetail = self.itemDetails[indexPath.row];
    NSString* theTitle = self.dataTitles[indexPath.row];
    
    cell.textLabel.text = theTitle;
    cell.detailTextLabel.text = theDetail;
    
    return cell;
}

- (void) configureDataTitles {
    self.dataTitles = [[NSMutableArray alloc] init];
    [self.dataTitles addObject:@"Name"];
    [self.dataTitles addObject:@"ID"];
    [self.dataTitles addObject:@"Created At"];
    [self.dataTitles addObject:@"Is File or Folder?"];
    [self.dataTitles addObject:@"Children Count"];
}

- (NSString*) fileOrFolderInfoForItem: (ODItem*) item {
    if(item.folder) {
        return @"Folder";
    }
    else {
        return @"File";
    }
}

- (NSString*) childrenInfoForItem: (ODItem*) item {
    
    if(item.folder) {
        return [NSString stringWithFormat:@"%d", item.folder.childCount];
    }
    else {
        return @"None";
    }
}

@end
