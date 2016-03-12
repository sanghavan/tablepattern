//
//  Created by materik on 12/03/16.
//

#import "LoadingTableViewCell.h"

#import "LoadingTableViewRow.h"

@interface LoadingTableViewCell ()

@property(nonatomic, readonly) UIActivityIndicatorView *activityIndicatorView;

@end

@implementation LoadingTableViewCell

@synthesize activityIndicatorView = _activityIndicatorView;

- (instancetype)init {
    self = [super init];
    if (self) {
        [self setBackgroundColor:[UIColor clearColor]];
        [self.contentView setBackgroundColor:[UIColor clearColor]];
        [self.contentView addSubview:self.activityIndicatorView];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self.activityIndicatorView sizeToFit];
    [self.activityIndicatorView setCenter:self.contentView.center];
}

#pragma mark - Views

- (UIActivityIndicatorView *)activityIndicatorView {
    if (!_activityIndicatorView) {
        _activityIndicatorView =
            [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    }
    return _activityIndicatorView;
}

#pragma mark - TableViewCell

- (void)setupInRow:(LoadingTableViewRow *)row {
    [self.activityIndicatorView setHidden:!row.isLoading];
    if (self.activityIndicatorView.isHidden) {
        [self.activityIndicatorView stopAnimating];
    } else {
        [self.activityIndicatorView startAnimating];
    }
}

@end