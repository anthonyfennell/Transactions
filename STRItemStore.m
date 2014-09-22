//
//  STRItemStore.m
//  Transactions
//
//  Created by Anthony Fennell on 9/11/14.
//  Copyright (c) 2014 Anthony Fennell. All rights reserved.
//

#import "STRItemStore.h"
#import "STRItem.h"

@import CoreData;

@interface STRItemStore ()

@property (nonatomic) NSMutableArray *privateItems;
@property (nonatomic, strong) NSMutableArray *allAssetTypes;

@end

@implementation STRItemStore

+ (instancetype)sharedStore {
    static STRItemStore *sharedStore;
    
    if (!sharedStore) {
        sharedStore = [[self alloc] initPrivate];
    }
    return sharedStore;
}

- (instancetype)initPrivate {
    self = [super init];
    if (self) {
        NSString *path = [self itemArchivePath];
        _privateItems = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
        
        if (!_privateItems) {
            _privateItems = [[NSMutableArray alloc] init];
        }
        _allAssetTypes = [[NSMutableArray alloc] init];
    }
    return self;
}

- (BOOL)saveChanges {
    NSString *path = [self itemArchivePath];
    return [NSKeyedArchiver archiveRootObject:self.privateItems toFile:path];
}

- (STRItem *)createItem {
    STRItem *item = [STRItem randomItem];
    
    [self.privateItems insertObject:item atIndex:0];
    return item;
}

- (void)removeItem:(STRItem *)item {
    [item subtractItemsValueFromBalance:item.valueInDollars];
    
    [self.privateItems removeObjectIdenticalTo:item];
}

- (NSArray *)allItems {
    return [self.privateItems copy];
}

- (void)moveItemAtIndex:(NSUInteger)fromindex toIndex:(NSUInteger)toIndex {
    
    if (fromindex == toIndex) {
        return;
    }
    STRItem *item = self.privateItems[fromindex];
    [self.privateItems removeObjectAtIndex:fromindex];
    [self.privateItems insertObject:item atIndex:toIndex];
}

- (double)balance {
    if ([self.privateItems count] == 0) {
        return 0.0;
    }
    return [self.privateItems[0] balance];
}

- (NSArray *)allAssetTypes {
    
    if (!_allAssetTypes) {
        return nil;
    }
    
    // Is this the first time the program is being run?
    
    if ([_allAssetTypes count] == 0) {
        NSLog(@"Initializing assets");
        [_allAssetTypes addObject:@"Deposit"];
        [_allAssetTypes addObject:@"Food"];
        [_allAssetTypes addObject:@"Gas"];
        [_allAssetTypes addObject:@"Beer"];
        [_allAssetTypes addObject:@"Clothes"];
        [_allAssetTypes addObject:@"Other"];
    }
    
    return _allAssetTypes;
}


- (NSString *)itemArchivePath {
    // Make sure that the first argument is NSDocumentDirectory
    // and not NSDocumentationDirectory
    NSArray *documentDirectories = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    // Get the one document directory from that list
    NSString *documentDirectory = [documentDirectories firstObject];
    
    return [documentDirectory stringByAppendingPathComponent:@"items.archive"];
}

@end













