//
//  TableViewCell.h
//  Materik
//
//  Created by materik on 30/11/15.
//  Copyright © 2015 Materik. All rights reserved.
//

#import "TableViewDataSourceRow.h"

@interface TableViewCell : UITableViewCell

@property(nonatomic, readonly) TableViewDataSourceRow *row;

- (void)setupWithRow:(TableViewDataSourceRow *)row;
+ (CGFloat)heightWithRow:(TableViewDataSourceRow *)row inTableView:(UITableView *)tableView;
+ (instancetype)dequeueOrCreateReusableCellInTableView:(UITableView *)tableView;

- (instancetype)initWithFrame:(CGRect)frame NS_UNAVAILABLE;
- (instancetype)initWithCoder:(NSCoder *)aDecoder NS_UNAVAILABLE;
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier NS_UNAVAILABLE;

@end
