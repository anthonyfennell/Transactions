//
//  STRDetailViewController.h
//  Transactions
//
//  Created by Anthony Fennell on 9/12/14.
//  Copyright (c) 2014 Anthony Fennell. All rights reserved.
//

#import <UIKit/UIKit.h>

@class STRItem;

@interface STRDetailViewController : UIViewController <UITextFieldDelegate>

@property (nonatomic, strong) STRItem *item;
@property (nonatomic, copy) void (^dismissBlock)(void);

- (instancetype)initForNewItem:(BOOL)isNew;

@end
