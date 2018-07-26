//
//  ItemDetailVC.h
//  ios-onedrive-starterkit
//
//  Created by Guven Bolukbasi on 26.07.2018.
//  Copyright © 2018 dorianlabs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ItemDetailVC : UIViewController<UITableViewDataSource, UITableViewDelegate>

- (void) configureWithItem: (ODItem*) item;

@end
