//
//  STRDateViewController.m
//  Transactions
//
//  Created by Anthony Fennell on 9/18/14.
//  Copyright (c) 2014 Anthony Fennell. All rights reserved.
//

#import "STRDateViewController.h"
#import "STRItem.h"

@interface STRDateViewController ()

@property (nonatomic, weak) IBOutlet UIDatePicker *datePicker;

@end

@implementation STRDateViewController

- (IBAction)setDate:(id)sender {    
    [self.navigationController popViewControllerAnimated:YES];
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.tabBarItem.title = @"Set Date";
    }
    return self;
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.tabBarItem.title = @"Set Date";
        
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
}

- (void)viewWillDisappear:(BOOL)animated {

    STRItem *item = self.item;
    item.date = self.datePicker.date;
}


@end
