//
//  FeedButtonTableViewDataSourceRow.m
//  ObjCDemo
//
//  Created by materik on 06/03/16.
//
//

#import "FeedButtonTableViewDataSourceRow.h"

#import "FeedTableViewDataSourceSection.h"
#import "FeedTitleTableViewCell.h"

@implementation FeedButtonTableViewDataSourceRow

- (Class)cellClass {
    return [FeedTitleTableViewCell class];
}

- (void)didSelectCell:(UITableViewCell *)cell
  inDataSourceSection:(FeedTableViewDataSourceSection *)dataSourceSection
         inDataSource:(TableViewDataSource *)dataSource {
    if ([dataSourceSection isKindOfClass:[FeedTableViewDataSourceSection class]]) {
        [dataSourceSection toggleHideDescriptionInDataSource:dataSource];
    }
}

@end
