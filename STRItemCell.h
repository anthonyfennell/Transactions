//
//  STRItemCellTableViewCell.h
//  Transactions
//
//  Created by Anthony Fennell on 9/11/14.
//  Copyright (c) 2014 Anthony Fennell. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface STRItemCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *valueLabel;

@end
