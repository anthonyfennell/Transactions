//
//  STRItemStorage.h
//  Transactions
//
//  Created by Anthony Fennell on 9/11/14.
//  Copyright (c) 2014 Anthony Fennell. All rights reserved.
//

#import <Foundation/Foundation.h>

@class STRItem;

@interface STRItemStorage : NSObject

@property (nonatomic, readonly, copy) NSArray *allItems;

+ (instancetype)sharedStore;
- (STRItem *)createItem;
- (void)removeItem;
- (BOOL)saveChanges;

@end
