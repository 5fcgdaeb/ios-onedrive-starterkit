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
@end

@implementation ItemDetailVC

- (void)configureWithItem:(ODItem *)item {
    self.item = item;
    self.itemDetails = [[NSMutableArray alloc] init];
    [self.itemDetails addObject:self.item.name];
    [self.itemDetails addObject:self.item.id];
    [self.itemDetails addObject:self.item.createdDateTime.description];
    [self.itemDetailTableView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"BasicCell"];
    NSString* theDetail = self.itemDetails[indexPath.row];
    cell.textLabel.text = theDetail;
    return cell;
}

@end
