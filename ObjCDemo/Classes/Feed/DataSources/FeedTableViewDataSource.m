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
        [[FeedItem alloc] initWithTitle:@"Cucumber" desc:@"A green vegetable"],
        [[FeedItem alloc] initWithTitle:@"Orange" desc:@"An orange fruit"],
        [[FeedItem alloc] initWithTitle:@"Apple" desc:@"An red/green fruit"],
        [[FeedItem alloc] initWithTitle:@"Banana" desc:@"An yellow fruit"],
    ]];
    [super reloadDataInTableView:tableView];
}

- (TableViewDataSourceSection *)createDataSourceSectionInSection:(NSUInteger)section {
    return [[FeedTableViewDataSourceSection alloc] initWithObject:[self.items objectAtIndex:section]];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self.items count];
}

@end
