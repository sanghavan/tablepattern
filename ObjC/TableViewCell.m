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

@synthesize row = _row;

- (instancetype)init {
    NSString *reuseIdentifier = NSStringFromClass(self.class);
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    return self;
}

- (void)setupWithRow:(TableViewDataSourceRow *)row {
    _row = row;
}

+ (CGFloat)heightWithRow:(TableViewDataSourceRow *)row inTableView:(UITableView *)tableView {
    return kHeight;
}

+ (instancetype)dequeueOrCreateReusableCellInTableView:(UITableView *)tableView {
    NSString *reuseIdentifier = NSStringFromClass(self.class);
    id cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (!cell) {
        cell = [[[self class] alloc] init];
    }
    return cell;
}

@end
