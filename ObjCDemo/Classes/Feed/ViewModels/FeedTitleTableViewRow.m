//
//  FeedTitleTableViewRow.m
//  ObjCDemo
//
//  Created by materik on 29/02/16.
//
//

#import "FeedTitleTableViewRow.h"

#import "DetailViewController.h"

@implementation FeedTitleTableViewRow

- (Class)objectClass {
    return [NSString class];
}

- (void)didSelectCell:(UITableViewCell *)cell
  inSection:(TableViewSection *)section
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
