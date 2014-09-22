//
//  STRAssetTypeViewController.m
//  Transactions
//
//  Created by Anthony Fennell on 9/13/14.
//  Copyright (c) 2014 Anthony Fennell. All rights reserved.
//

#import "STRAssetTypeViewController.h"
#import "STRItem.h"
#import "STRItemStore.h"

@implementation STRAssetTypeViewController

- (instancetype)init {
    self = [super initWithStyle:UITableViewStylePlain];
    if (self) {
        self.navigationItem.title = @"Asset Type";
    }
    return self;
}

- (instancetype)initWithStyle:(UITableViewStyle)style {
    return [self init];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerClass:[UITableViewCell class]
           forCellReuseIdentifier:@"UITableViewCell"];
}

- (void)setItem:(STRItem *)item {
    _item = item;
    self.navigationItem.title = _item.itemName;
}






- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[[STRItemStore sharedStore] allAssetTypes] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
    
    NSArray *allAssets = [[STRItemStore sharedStore] allAssetTypes];
    NSString *assetType = allAssets[indexPath.row];
    cell.textLabel.text = assetType;
    
    // Checkmark the one that is currently selected
    if ([assetType isEqualToString:self.item.assetType]) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    } else {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    cell.accessoryType = UITableViewCellAccessoryCheckmark;
    
    NSArray *allAssets = [[STRItemStore sharedStore] allAssetTypes];
    
    self.item.assetType = allAssets[indexPath.row];
    
    [self.navigationController popViewControllerAnimated:YES];
}



@end
















