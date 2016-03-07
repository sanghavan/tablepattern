//
//  FeedButtonTableViewRow.m
//  ObjCDemo
//
//  Created by materik on 06/03/16.
//
//

#import "FeedButtonTableViewRow.h"

#import "FeedTableViewSection.h"
#import "FeedTitleTableViewCell.h"

@implementation FeedButtonTableViewRow

- (Class)cellClass {
    return [FeedTitleTableViewCell class];
}

- (void)didSelectCell:(UITableViewCell *)cell
  inSection:(FeedTableViewSection *)section
         inDataSource:(TableViewDataSource *)dataSource {
    if ([section isKindOfClass:[FeedTableViewSection class]]) {
        [section toggleHideDescriptionInDataSource:dataSource];
    }
}

@end
