//
//  STRItemsViewController.m
//  Transactions
//
//  Created by Anthony Fennell on 9/11/14.
//  Copyright (c) 2014 Anthony Fennell. All rights reserved.
//

#import "STRItemsViewController.h"
#import "STRItem.h"
#import "STRItemStore.h"
#import "STRItemCell.h"
#import "STRDetailViewController.h"

@interface STRItemsViewController ()

@end

@implementation STRItemsViewController

- (instancetype)init {
    
    self = [super initWithStyle:UITableViewStylePlain];
    if (self) {
        UINavigationItem *navItem = self.navigationItem;
        //navItem.title = @"Transactions";
        
        UIBarButtonItem *bbi = [[UIBarButtonItem alloc]
                                initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                target:self
                                action:@selector(addNewItem:)];
        navItem.rightBarButtonItem = bbi;
        navItem.leftBarButtonItem = self.editButtonItem;
        
        [self reloadTitle];
    }
    return self;
}

- (instancetype)initWithStyle:(UITableViewStyle)style {
    return [self init];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UINib *nib = [UINib nibWithNibName:@"STRItemCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"STRItemCell"];
    self.tableView.rowHeight = 45;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.tableView reloadData];
    [self reloadTitle];
}

- (void)reloadTitle {
    UINavigationItem *navItem = self.navigationItem;
    navItem.title = [NSString stringWithFormat:@"Balance $%.2f",
                     [[STRItemStore sharedStore] balance]];
}




/*
 / Set number of rows
*/
- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {
    return [[[STRItemStore sharedStore] allItems] count];
}

/*
 / Set the look of each cell
*/
- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
 
    STRItemCell *cell =
    [tableView dequeueReusableCellWithIdentifier:@"STRItemCell" forIndexPath:indexPath];
    
    NSArray *items = [[STRItemStore sharedStore] allItems];
    STRItem *item = items[indexPath.row];
    
    cell.nameLabel.text = item.itemName;
    if ([item.assetType isEqualToString:@"Deposit"]) {
        cell.valueLabel.textColor = [UIColor greenColor];
    } else {
        cell.valueLabel.textColor = [UIColor redColor];
    }
    cell.valueLabel.text = [NSString stringWithFormat:@"$%.2f", item.valueInDollars];
    
    static NSDateFormatter *dateFormatter;
    if (!dateFormatter) {
        dateFormatter = [[NSDateFormatter alloc] init];
        dateFormatter.dateStyle = NSDateFormatterMediumStyle;
        dateFormatter.timeStyle = NSDateFormatterShortStyle;
    }
    cell.dateLabel.text = [dateFormatter stringFromDate:item.date];
  
    return cell;
}

/*
 / Selected an individual cell to edit
*/
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    STRDetailViewController *dvc = [[STRDetailViewController alloc] initForNewItem:NO];
    
    NSArray *items = [[STRItemStore sharedStore] allItems];
    STRItem *selectedItem = items[indexPath.row];
    
    dvc.item = selectedItem;
    
    [self.navigationController pushViewController:dvc animated:YES];
}

- (void)tableView:(UITableView *)tableView
commitEditingStyle:(UITableViewCellEditingStyle)editingStyle
forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSArray *items = [[STRItemStore sharedStore] allItems];
        STRItem *item = items[indexPath.row];
                
        [[STRItemStore sharedStore] removeItem:item];
        
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        [self reloadTitle];
    }
}

- (void)tableView:(UITableView *)tableView
moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath
      toIndexPath:(NSIndexPath *)destinationIndexPath {
    
    [[STRItemStore sharedStore] moveItemAtIndex:sourceIndexPath.row toIndex:destinationIndexPath.row];
}

- (IBAction)addNewItem:(id)sender {
    STRItem *newItem = [[STRItemStore sharedStore] createItem];
    
    STRDetailViewController *dvc = [[STRDetailViewController alloc] initForNewItem:YES];
    dvc.item = newItem;
    dvc.dismissBlock = ^{[self.tableView reloadData];
        [self reloadTitle];};
    
    UINavigationController *navController =
    [[UINavigationController alloc] initWithRootViewController:dvc];
    [self presentViewController:navController animated:YES completion:NULL];
}


@end



























