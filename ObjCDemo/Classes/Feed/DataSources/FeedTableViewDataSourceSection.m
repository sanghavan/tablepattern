//
//  FeedTableViewDataSourceSection.m
//  ObjCDemo
//
//  Created by materik on 10/02/16.
//
//

#import "FeedTableViewDataSourceSection.h"

#import "FeedButtonTableViewDataSourceRow.h"
#import "FeedItem.h"
#import "FeedTitleTableViewDataSourceRow.h"

typedef NS_ENUM(NSUInteger, FeedRow) {
    FeedRowTitle,
    FeedRowDesc,
    FeedRowButton,
    FeedRowCount,
};

@interface FeedTableViewDataSourceSection ()

@property(nonatomic, assign, getter=isDescHidden) BOOL hideDesc;

@end

@implementation FeedTableViewDataSourceSection

- (Class)objectClass {
    return [FeedItem class];
}

- (NSUInteger)numberOfRows {
    return FeedRowCount;
}

- (TableViewDataSourceRow *)createDataSourceRowAtRow:(NSUInteger)row {
    FeedItem *feedItem = (FeedItem *)self.object;
    switch ((FeedRow)row) {
        case FeedRowButton: {
            NSString *title = self.isDescHidden ? @"+ Show Desc" : @"- Hide Desc";
            return [[FeedButtonTableViewDataSourceRow alloc] initWithObject:title];
        }
        case FeedRowCount: {
            return nil;
        }
        case FeedRowDesc: {
            if (self.isDescHidden) {
                return nil;
            }
            return [[FeedTitleTableViewDataSourceRow alloc] initWithObject:feedItem.desc];
        }
        case FeedRowTitle: {
            return [[FeedTitleTableViewDataSourceRow alloc] initWithObject:feedItem.title];
        }
    }
}

#pragma mark - Action

- (void)toggleHideDescriptionInDataSource:(TableViewDataSource *)dataSource {
    [self setHideDesc:!self.isDescHidden];
    [self reloadDataSourceRowAtRow:FeedRowDesc inDataSource:dataSource withRowAnimation:UITableViewRowAnimationFade];
    [self reloadDataSourceRowAtRow:FeedRowButton
                      inDataSource:dataSource
                  withRowAnimation:UITableViewRowAnimationAutomatic];
}

@end
