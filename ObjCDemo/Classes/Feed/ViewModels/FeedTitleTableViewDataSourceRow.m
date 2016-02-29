//
//  FeedTitleTableViewDataSourceRow.m
//  ObjCDemo
//
//  Created by materik on 29/02/16.
//
//

#import "FeedTitleTableViewDataSourceRow.h"

#import "DetailViewController.h"

@implementation FeedTitleTableViewDataSourceRow

- (void)didSelectCell:(UITableViewCell *)cell inTableView:(UITableView *)tableView {
    DetailViewController *detailViewController = [[DetailViewController alloc] initWithTitle:self.model];
    [self.navigationController pushViewController:detailViewController animated:YES];
}

@end
