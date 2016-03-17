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

- (void)setupInRow:(TableViewRow *)row
         inSection:(TableViewSection *)section
      inDataSource:(TableViewDataSource *)dataSource {
    _dataSource = dataSource;
    _row = row;
    _section = section;
}

+ (CGFloat)heightInRow:(TableViewRow *)row
             inSection:(TableViewSection *)section
          inDataSource:(TableViewDataSource *)dataSource {
    return kHeight;
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
