//
//  STRItem.m
//  Transactions
//
//  Created by Anthony Fennell on 9/14/14.
//  Copyright (c) 2014 Anthony Fennell. All rights reserved.
//

#import "STRItem.h"

@interface STRItem ()

@end

static double theBalance = 0.0;

@implementation STRItem


- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.itemName forKey:@"itemName"];
    [aCoder encodeObject:self.date forKey:@"date"];
    [aCoder encodeDouble:self.valueInDollars forKey:@"valueInDollars"];
    [aCoder encodeObject:self.assetType forKey:@"assetType"];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if (self) {
        _itemName = [aDecoder decodeObjectForKey:@"itemName"];
        _date = [aDecoder decodeObjectForKey:@"date"];
        _valueInDollars = [aDecoder decodeDoubleForKey:@"valueInDollars"];
        _assetType = [aDecoder decodeObjectForKey:@"assetType"];
        [self addItemsValueToBalance:_valueInDollars];
    }
    return self;
}

- (instancetype)init {
    return [self initWithItemName:@"Item"];
}

- (instancetype)initWithItemName:(NSString *)name {
    return [self initWithItemName:name valueInDollars:0.0 assetType:@"Food"];
}

- (instancetype)initWithItemName:(NSString *)name
                  valueInDollars:(double)value assetType:(NSString *)asset{
    
    self = [super init];
    
    if (self) {
        _itemName = name;
        _valueInDollars = value;
        _date = [[NSDate alloc] init];
        _assetType = asset;
        theBalance -= value;
    }
    return self;
}


+ (instancetype)randomItem {
    
    NSArray *names = @[@"Socks", @"Little people", @"Cats", @"Boxers", @"Tiger", @"Elf", @"Dragon"];
    NSInteger nameInt = arc4random() % [names count];
    
    double randomValue = arc4random() % 100;
    randomValue *= 0.51;
    
    return [[self alloc] initWithItemName:names[nameInt] valueInDollars:randomValue assetType:nil];
}


- (void)setValueInDollars:(double)valueInDollars {
    
    NSLog(@"The balance: %.2f", theBalance);
    if ([_assetType isEqualToString:@"Deposit"]) {
        NSLog(@"%@ Adding difference", NSStringFromSelector(_cmd));
        theBalance += valueInDollars - _valueInDollars;
    } else {
        NSLog(@"%@ Subtracting difference", NSStringFromSelector(_cmd));
        theBalance = theBalance - (valueInDollars - _valueInDollars);
    }
    _valueInDollars = valueInDollars;
}

- (double)balance {
    return theBalance;
}

- (void)subtractItemsValueFromBalance:(double)amount {
    if ([_assetType isEqualToString:@"Deposit"]) {
        theBalance -= amount;
        return;
    }
    
    theBalance += amount;
}

- (void)addItemsValueToBalance:(double)amount {
    if ([_assetType isEqualToString:@"Deposit"]) {
        theBalance += amount;
        return;
    }
    theBalance -= amount;
}


- (void)setAssetType:(NSString *)asset {
    NSLog(@"%@", NSStringFromSelector(_cmd));
    
    
    if (![_assetType isEqualToString:asset]) {
        
        // nil -> PayCheck
        if (!_assetType && [asset isEqualToString:@"Deposit"]) {
            NSLog(@"%@ Adding twice the diff", NSStringFromSelector(_cmd));
            theBalance += _valueInDollars * 2;
            
        // Junk -> PayCheck
        } else if ([asset isEqualToString:@"Deposit"]) {
            NSLog(@"%@ Adding twice the diff", NSStringFromSelector(_cmd));
            theBalance += _valueInDollars * 2;
            
        // PayCheck -> Junk
        } else if ([_assetType isEqualToString:@"Deposit"]) {
            NSLog(@"%@ Subtracting twice the diff", NSStringFromSelector(_cmd));
            theBalance -= _valueInDollars * 2;
        }
    }
    _assetType = asset;
}

@end



















