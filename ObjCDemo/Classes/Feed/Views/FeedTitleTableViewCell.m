//
//  FeedTitleTableViewCell.m
//  ObjCDemo
//
//  Created by materik on 10/02/16.
//
//

#import "FeedTitleTableViewCell.h"

@interface FeedTitleTableViewCell ()

@property(nonatomic, readonly) UILabel *label;

@end

@implementation FeedTitleTableViewCell

@synthesize label = _label;

- (instancetype)init {
    self = [super init];
    if (self) {
        [self addSubview:self.label];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];

    CGFloat x = 10.0f;
    [self.label setFrame:CGRectMake(x, 0, self.frame.size.width - 2 * x, self.frame.size.height)];
}

#pragma mark - TableViewCell

- (void)setupWithRow:(TableViewDataSourceRow *)row {
    [super setupWithRow:row];
    [self.label setText:row.model];
}

#pragma mark - Views

- (UILabel *)label {
    if (!_label) {
        _label = [[UILabel alloc] init];
    }
    return _label;
}

@end
