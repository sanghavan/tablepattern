//
//  Created by materik on 12/03/16.
//

#import "LoadingTableViewCell.h"

#import "LoadingTableViewRow.h"
#import "TableViewDataSource.h"

static CGFloat const kHeight = 44.0f;

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
            [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    }
    return _activityIndicatorView;
}

#pragma mark - TableViewCell

- (void)setupInRow:(LoadingTableViewRow *)row {
    [self.activityIndicatorView setColor:row.color];
    [self.activityIndicatorView setTransform:CGAffineTransformIdentity];
    [self.activityIndicatorView setTransform:CGAffineTransformMakeScale(row.size ?: 0.5f, row.size ?: 0.5f)];

    if (row.isLoading) {
        [self.activityIndicatorView setHidden:NO];
        [self.activityIndicatorView startAnimating];
    } else {
        [self.activityIndicatorView setHidden:YES];
        [self.activityIndicatorView stopAnimating];
    }
}

+ (CGFloat)heightInRow:(LoadingTableViewRow *)row {
    return kHeight + 2 * row.padding;
}

@end