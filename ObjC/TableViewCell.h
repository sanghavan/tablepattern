//
//  TableViewCell.h
//  Materik
//
//  Created by materik on 30/11/15.
//  Copyright © 2015 Materik. All rights reserved.
//

#import "TableViewCellModel.h"

#import <UIKit/UIKit.h>

@interface TableViewCell : UITableViewCell

@property(nonatomic, strong) TableViewCellModel *model;

+ (CGFloat)heightWithModel:(TableViewCellModel *)model fromTableView:(UITableView *)tableView;
+ (instancetype)dequeueOrCreateReusableCellFromTableView:(UITableView *)tableView;

- (instancetype)initWithFrame:(CGRect)frame NS_UNAVAILABLE;
- (instancetype)initWithCoder:(NSCoder *)aDecoder NS_UNAVAILABLE;
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier NS_UNAVAILABLE;

@end
