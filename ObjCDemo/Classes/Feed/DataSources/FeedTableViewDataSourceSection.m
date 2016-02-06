//
//  FeedTableViewDataSourceSection.m
//  ObjCDemo
//
//  Created by materik on 10/02/16.
//
//

#import "FeedTableViewDataSourceSection.h"

#import "FeedTableViewCellModelFactory.h"

typedef NS_ENUM(NSUInteger, FeedRow) {
    FeedRowTitle,
    FeedRowDesc,
    FeedRowCount,
};

@interface FeedTableViewDataSourceSection ()

@property(nonatomic, readonly) FeedTableViewCellModelFactory *feedFactory;

@end

@implementation FeedTableViewDataSourceSection

@synthesize feedFactory = _feedFactory;

- (FeedTableViewCellModelFactory *)feedFactory {
    if (!_feedFactory) {
        _feedFactory = [[FeedTableViewCellModelFactory alloc] init];
    }
    return _feedFactory;
}

- (NSUInteger)numberOfRows {
    return FeedRowCount;
}

- (TableViewCellModel *)cellModelAtRow:(NSUInteger)row {
    switch (row) {
        case FeedRowTitle:
            return [self.feedFactory createTitleCellModelFromItem:self.model];
        case FeedRowDesc:
            return [self.feedFactory createDescCellModelFromItem:self.model];
        default:
            return nil;
    }
}

@end
