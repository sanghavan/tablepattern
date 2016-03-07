//
//  FeedTitleTableViewCell.m
//  ObjCDemo
//
//  Created by materik on 10/02/16.
//
//

#import "FeedTitleTableViewCell.h"

#import "FeedTitleTableViewRow.h"

static CGFloat const kPadding = 10.0f;

@interface FeedTitleTableViewCell ()

@property(nonatomic, readonly) UILabel *label;
@property(nonatomic, readonly) UIButton *button;

@end

@implementation FeedTitleTableViewCell

@synthesize label = _label;
@synthesize button = _button;

- (instancetype)init {
    self = [super init];
    if (self) {
        [self.contentView addSubview:self.label];
        [self.contentView addSubview:self.button];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];

    [self.label sizeToFit];
    [self.label setCenter:self.contentView.center];
    [self.button sizeToFit];
    [self.button setCenter:self.contentView.center];

    CGRect labelFrame = self.label.frame;
    labelFrame.origin.x = kPadding;
    [self.label setFrame:labelFrame];

    CGRect buttonFrame = self.button.frame;
    buttonFrame.origin.x = labelFrame.origin.x + labelFrame.size.width + kPadding;
    [self.button setFrame:buttonFrame];
}

#pragma mark - Action

- (void)action {
    FeedTitleTableViewRow *row = (FeedTitleTableViewRow *)self.row;
    [row alert];
}

#pragma mark - Views

- (UILabel *)label {
    if (!_label) {
        _label = [[UILabel alloc] init];
    }
    return _label;
}

- (UIButton *)button {
    if (!_button) {
        _button = [[UIButton alloc] init];
        [_button setBackgroundColor:[UIColor redColor]];
        [_button setTitle:@"Alert" forState:UIControlStateNormal];
        [_button addTarget:self action:@selector(action) forControlEvents:UIControlEventTouchUpInside];
    }
    return _button;
}

#pragma mark - TableViewCell

- (void)setupInRow:(TableViewRow *)row {
    [super setupInRow:row];
    [self.label setText:row.object];
}

@end
