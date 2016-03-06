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

- (Class)objectClass {
    return [NSString class];
}

- (void)didSelectCell:(UITableViewCell *)cell
  inDataSourceSection:(TableViewDataSourceSection *)dataSourceSection
         inDataSource:(TableViewDataSource *)dataSource {
    DetailViewController *detailViewController = [[DetailViewController alloc] initWithTitle:self.object];
    [self.navigationController pushViewController:detailViewController animated:YES];
}

- (void)alert {
    [[[UIAlertView alloc] initWithTitle:self.object
                                message:nil
                               delegate:nil
                      cancelButtonTitle:@"Ok"
                      otherButtonTitles:nil] show];
}

@end
