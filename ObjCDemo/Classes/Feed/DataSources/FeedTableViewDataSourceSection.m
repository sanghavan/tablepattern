//
//  FeedTableViewDataSourceSection.m
//  ObjCDemo
//
//  Created by materik on 10/02/16.
//
//

#import "FeedTableViewDataSourceSection.h"

#import "DetailViewController.h"
#import "FeedItem.h"
#import "FeedTableViewCellModelFactory.h"

typedef NS_ENUM(NSUInteger, FeedRow) {
    FeedRowTitle,
    FeedRowDesc,
    FeedRowCount,
};

@implementation FeedTableViewDataSourceSection

- (NSUInteger)numberOfRows {
    return FeedRowCount;
}

- (TableViewCellModel *)createCellModelAtRow:(NSUInteger)row {
    switch (row) {
        case FeedRowTitle:
            return [FeedTableViewCellModelFactory createTitleCellModelFromItem:self.model];
        case FeedRowDesc:
            return [FeedTableViewCellModelFactory createDescCellModelFromItem:self.model];
        default:
            return nil;
    }
}

- (void)didSelectCell:(UITableViewCell *)cell forRow:(NSUInteger)row inTableView:(UITableView *)tableView {
    FeedItem *feedItem = (FeedItem *)self.model;
    DetailViewController *detailViewController = [[DetailViewController alloc] initWithTitle:feedItem.title];
    [self.navigationController pushViewController:detailViewController animated:YES];
}

@end
