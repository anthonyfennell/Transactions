//
//  STRItem.h
//  Transactions
//
//  Created by Anthony Fennell on 9/14/14.
//  Copyright (c) 2014 Anthony Fennell. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface STRItem : NSObject <NSCoding>

@property (nonatomic, strong) NSString * itemName;
@property (nonatomic, strong) NSDate * date;
@property (nonatomic) double valueInDollars;
@property (nonatomic, strong) NSString *assetType;


- (void)setValueInDollars:(double)valueInDollars;

- (double)balance;
- (void)addItemsValueToBalance:(double)amount;
- (void)subtractItemsValueFromBalance:(double)amount;

- (void)setAssetType:(NSString *)asset;

- (instancetype)initWithItemName:(NSString *)name;
- (instancetype)initWithItemName:(NSString *)name valueInDollars:(double)value assetType:(NSString *)asset;
+ (instancetype)randomItem;

@end
