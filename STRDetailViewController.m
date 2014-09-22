//
//  STRDetailViewController.m
//  Transactions
//
//  Created by Anthony Fennell on 9/12/14.
//  Copyright (c) 2014 Anthony Fennell. All rights reserved.
//

#import "STRDetailViewController.h"
#import "STRItem.h"
#import "STRItemStore.h"
#import "STRAssetTypeViewController.h"
#import "STRDateViewController.h"

@interface STRDetailViewController ()

@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *valueField;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *assetTypeButton;
@property (weak, nonatomic) IBOutlet UILabel *dateField;

@end

@implementation STRDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    [NSException raise:@"Wrong initializer" format:@"Use initForNewItem"];
    return nil;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)changeDate:(id)sender {
    STRDateViewController *dvc = [[STRDateViewController alloc] initWithNibName:@"STRDateViewController" bundle:nil];
    
    dvc.item = self.item;
    [self.navigationController pushViewController:dvc animated:YES];
}


- (instancetype)initForNewItem:(BOOL)isNew {
    self = [super initWithNibName:nil bundle:nil];
    
    if (self) {
        if (isNew) {
            UIBarButtonItem *doneItem = [[UIBarButtonItem alloc]
                                         initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                         target:self
                                         action:@selector(save:)];
            self.navigationItem.rightBarButtonItem = doneItem;
            
            UIBarButtonItem *cancelItem = [[UIBarButtonItem alloc]
                                           initWithBarButtonSystemItem:UIBarButtonSystemItemCancel
                                           target:self
                                           action:@selector(cancel:)];
            self.navigationItem.leftBarButtonItem = cancelItem;
        }
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    STRItem *item = self.item;
    
    self.nameField.text = item.itemName;
    self.valueField.text = [NSString stringWithFormat:@"%.2f", item.valueInDollars];
    
    static NSDateFormatter *dateFormatter;
    if (!dateFormatter) {
        dateFormatter = [[NSDateFormatter alloc] init];
        dateFormatter.dateStyle = NSDateFormatterMediumStyle;
        dateFormatter.timeStyle = NSDateFormatterShortStyle;
    }
    self.dateField.text = [dateFormatter stringFromDate:item.date];
    
    NSString *typeLabel = self.item.assetType;
    if (!typeLabel) {
        typeLabel = @"None";
    }
    
    self.assetTypeButton.title = [NSString stringWithFormat:@"Type: %@", typeLabel];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [self.view endEditing:YES];
    
    STRItem *item = self.item;
    item.itemName = self.nameField.text;
    item.valueInDollars = [self.valueField.text doubleValue];
    
    static NSDateFormatter *dateFormatter;
    if (!dateFormatter) {
        dateFormatter = [[NSDateFormatter alloc] init];
        dateFormatter.dateStyle = NSDateFormatterMediumStyle;
        dateFormatter.timeStyle = NSDateFormatterShortStyle;
    }
    
    item.date = [dateFormatter dateFromString:self.dateField.text];
}

- (IBAction)backgroundTapped:(id)sender {
    [self.view endEditing:YES];
}




- (IBAction)showAssetTypePicker:(id)sender {
    STRAssetTypeViewController *avc = [[STRAssetTypeViewController alloc] init];
    avc.item = self.item;
    [self.navigationController pushViewController:avc animated:YES];
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    NSLog(@"Resigning textField");
    [textField resignFirstResponder];
    return YES;
}



// Set the navigation bar title to the item name
- (void)setItem:(STRItem *)item {
    _item = item;
    self.navigationItem.title = _item.itemName;
}

- (void)save:(id)sender {
    [self.presentingViewController dismissViewControllerAnimated:YES
                                                      completion:self.dismissBlock];
}

- (void)cancel:(id)sender {
    [[STRItemStore sharedStore] removeItem:self.item];
    
    [self.presentingViewController dismissViewControllerAnimated:YES
                                                      completion:self.dismissBlock];
}


@end

























