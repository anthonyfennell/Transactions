//
//  STRItemStore.h
//  Transactions
//
//  Created by Anthony Fennell on 9/11/14.
//  Copyright (c) 2014 Anthony Fennell. All rights reserved.
//

#import <Foundation/Foundation.h>

@class STRItem;

@interface STRItemStore : NSObject

@property (nonatomic, readonly, copy) NSArray *allItems;
@property (nonatomic, readonly) double balance;

+ (instancetype)sharedStore;
- (STRItem *)createItem;
- (void)removeItem:(STRItem *)item;
- (void)moveItemAtIndex:(NSUInteger)fromindex toIndex:(NSUInteger)toIndex;
- (double)balance;
- (NSArray *)allAssetTypes;
- (BOOL)saveChanges;

@end
