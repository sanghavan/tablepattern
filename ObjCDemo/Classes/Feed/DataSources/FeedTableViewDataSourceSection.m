//
//  FeedTableViewDataSourceSection.m
//  ObjCDemo
//
//  Created by materik on 10/02/16.
//
//

#import "FeedTableViewDataSourceSection.h"

#import "FeedItem.h"
#import "FeedTitleTableViewDataSourceRow.h"

typedef NS_ENUM(NSUInteger, FeedRow) {
    FeedRowTitle,
    FeedRowDesc,
    FeedRowCount,
};

@implementation FeedTableViewDataSourceSection

- (NSUInteger)numberOfRows {
    return FeedRowCount;
}

- (TableViewDataSourceRow *)createDataSourceRowAtRow:(NSUInteger)row {
    FeedItem *feedItem = (FeedItem *)self.object;
    switch ((FeedRow)row) {
        case FeedRowTitle:
            return [[FeedTitleTableViewDataSourceRow alloc] initWithObject:feedItem.title];
        case FeedRowDesc:
            return [[FeedTitleTableViewDataSourceRow alloc] initWithObject:feedItem.desc];
        case FeedRowCount:
            return nil;
    }
}

@end
