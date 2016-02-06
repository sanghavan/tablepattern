//
//  FeedTableViewDataSource.m
//  ObjCDemo
//
//  Created by materik on 10/02/16.
//
//

#import "FeedTableViewDataSource.h"

#import "FeedItem.h"
#import "FeedTableViewDataSourceSection.h"

@interface FeedTableViewDataSource ()

@property(nonatomic, strong) NSArray<FeedItem *> *items;

@end

@implementation FeedTableViewDataSource

- (void)reloadDataInTableView:(UITableView *)tableView {
    [self setItems:@[
        [[FeedItem alloc] initWithTitle:@"Carrot" desc:@"An orange vegetable"],
        [[FeedItem alloc] initWithTitle:@"Tomato" desc:@"A red vegetable"],
    ]];
    [super reloadDataInTableView:tableView];
}

- (TableViewDataSourceSection *)createSectionInSection:(NSUInteger)section {
    return [[FeedTableViewDataSourceSection alloc] initWithModel:[self.items objectAtIndex:section]];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self.items count];
}

@end
