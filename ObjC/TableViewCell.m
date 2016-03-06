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

- (void)setupWithDataSourceRow:(TableViewDataSourceRow *)dataSourceRow {
    // Do nothing...
}

- (void)setupWithDataSourceRow:(TableViewDataSourceRow *)dataSourceRow
           inDataSourceSection:(TableViewDataSourceSection *)dataSourceSection {
    return [self setupWithDataSourceRow:dataSourceRow];
}

- (void)setupWithDataSourceRow:(TableViewDataSourceRow *)dataSourceRow
           inDataSourceSection:(TableViewDataSourceSection *)dataSourceSection
                  inDataSource:(TableViewDataSource *)dataSource {
    _dataSource = dataSource;
    _dataSourceRow = dataSourceRow;
    _dataSourceRowSection = dataSourceSection;
    return [self setupWithDataSourceRow:dataSourceRow inDataSourceSection:dataSourceSection];
}

+ (CGFloat)heightWithDataSourceRow:(TableViewDataSourceRow *)dataSourceRow {
    return kHeight;
}

+ (CGFloat)heightWithDataSourceRow:(TableViewDataSourceRow *)dataSourceRow
               inDataSourceSection:(TableViewDataSourceSection *)dataSourceSection {
    return [self heightWithDataSourceRow:dataSourceRow];
}

+ (CGFloat)heightWithDataSourceRow:(TableViewDataSourceRow *)dataSourceRow
               inDataSourceSection:(TableViewDataSourceSection *)dataSourceSection
                      inDataSource:(TableViewDataSource *)dataSource {
    return [self heightWithDataSourceRow:dataSourceRow inDataSourceSection:dataSourceSection];
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
