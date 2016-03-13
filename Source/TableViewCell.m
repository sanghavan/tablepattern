//
//  TableViewCell.m
//  Materik
//
//  Created by materik on 30/11/15.
//  Copyright © 2015 Materik. All rights reserved.
//

#import "TableViewCell.h"

static CGFloat const kHeight = 44.0f;

@implementation TableViewCell

- (instancetype)init {
    NSString *reuseIdentifier = NSStringFromClass(self.class);
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    return self;
}

- (void)setupInRow:(TableViewRow *)row {
    // Do nothing...
}

- (void)setupInRow:(TableViewRow *)row inSection:(TableViewSection *)section {
    return [self setupInRow:row];
}

- (void)setupInRow:(TableViewRow *)row
         inSection:(TableViewSection *)section
      inDataSource:(TableViewDataSource *)dataSource {
    _dataSource = dataSource;
    _row = row;
    _section = section;
    return [self setupInRow:row inSection:section];
}

+ (CGFloat)heightInRow:(TableViewRow *)row {
    return kHeight;
}

+ (CGFloat)heightInRow:(TableViewRow *)row inSection:(TableViewSection *)section {
    return [self heightInRow:row];
}

+ (CGFloat)heightInRow:(TableViewRow *)row
             inSection:(TableViewSection *)section
          inDataSource:(TableViewDataSource *)dataSource {
    return [self heightInRow:row inSection:section];
}

+ (instancetype)dequeueOrCreateReusableCellInDataSource:(TableViewDataSource *)dataSource {
    NSString *reuseIdentifier = NSStringFromClass(self.class);
    id cell = [dataSource.tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (!cell) {
        cell = [[[self class] alloc] init];
    }
    return cell;
}

@end
