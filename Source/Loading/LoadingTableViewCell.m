//
//  Created by materik on 12/03/16.
//

#import "LoadingTableViewCell.h"

#import "LoadingTableViewRow.h"
#import "TableViewDataSource.h"

#define weaken(object, newName) __typeof__(object) __weak newName = object

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

- (void)setupInRow:(LoadingTableViewRow *)row
         inSection:(TableViewSection *)section
      inDataSource:(TableViewDataSource *)dataSource {
    [super setupInRow:row inSection:section inDataSource:dataSource];

    [self.activityIndicatorView setColor:row.color];
    [self.activityIndicatorView setTransform:CGAffineTransformIdentity];
    [self.activityIndicatorView setTransform:CGAffineTransformMakeScale(row.size ?: 0.5f, row.size ?: 0.5f)];

    weaken(self, weakSelf);
    dispatch_async(dispatch_get_main_queue(), ^{
      if (row.isLoading) {
          [self.activityIndicatorView setHidden:NO];
          [weakSelf.activityIndicatorView startAnimating];
      } else {
          [self.activityIndicatorView setHidden:YES];
          [weakSelf.activityIndicatorView stopAnimating];
      }
    });
}

+ (CGFloat)heightInRow:(LoadingTableViewRow *)row
             inSection:(TableViewSection *)section
          inDataSource:(TableViewDataSource *)dataSource {
    return kHeight + 2 * row.padding;
}

@end