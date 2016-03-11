//
//  FeedTableViewSection.m
//  ObjCDemo
//
//  Created by materik on 10/02/16.
//
//

#import "FeedTableViewSection.h"

#import "FeedButtonTableViewRow.h"
#import "FeedItem.h"
#import "FeedTitleTableViewRow.h"

typedef NS_ENUM(NSUInteger, FeedRow) {
    FeedRowTitle,
    FeedRowDesc,
    FeedRowButton,
    FeedRowCount,
};

@interface FeedTableViewSection ()

@property(nonatomic, assign, getter=isDescHidden) BOOL hideDesc;

@end

@implementation FeedTableViewSection

- (NSUInteger)numberOfRows {
    return FeedRowCount;
}

- (TableViewRow *)createRowAtIndex:(NSUInteger)row {
    FeedItem *feedItem = (FeedItem *)self.object;
    switch ((FeedRow)row) {
        case FeedRowButton: {
            NSString *title = self.isDescHidden ? @"+ Show Desc" : @"- Hide Desc";
            return [[FeedButtonTableViewRow alloc] initWithObject:title];
        }
        case FeedRowCount: {
            return nil;
        }
        case FeedRowDesc: {
            if (self.isDescHidden) {
                return nil;
            }
            return [[FeedTitleTableViewRow alloc] initWithObject:feedItem.desc];
        }
        case FeedRowTitle: {
            return [[FeedTitleTableViewRow alloc] initWithObject:feedItem.title];
        }
    }
}

#pragma mark - Action

- (void)toggleHideDescriptionInDataSource:(TableViewDataSource *)dataSource {
    [self setHideDesc:!self.isDescHidden];
    [self reloadRowAtIndex:FeedRowDesc inDataSource:dataSource withRowAnimation:UITableViewRowAnimationFade];
    [self reloadRowAtIndex:FeedRowButton inDataSource:dataSource withRowAnimation:UITableViewRowAnimationAutomatic];
}

@end
