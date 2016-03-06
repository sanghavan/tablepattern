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

- (void)resetData {
    [self setItems:@[]];
    [super resetData];
}

- (void)loadDataOnCompletion:(TableViewDataSourceLoadDataCompletion)completion {
    [self setItems:@[
        [[FeedItem alloc] initWithTitle:@"Carrot" desc:@"An orange vegetable"],
        [[FeedItem alloc] initWithTitle:@"Tomato" desc:@"A red vegetable"],
        [[FeedItem alloc] initWithTitle:@"Cucumber" desc:@"A green vegetable"],
        [[FeedItem alloc] initWithTitle:@"Orange" desc:@"An orange fruit"],
        [[FeedItem alloc] initWithTitle:@"Apple" desc:@"An red/green fruit"],
        [[FeedItem alloc] initWithTitle:@"Banana" desc:@"An yellow fruit"],
    ]];
    completion();
}

- (void)loadPaginatedDataInPage:(NSUInteger)page
                      withLimit:(NSUInteger)limit
                   onCompletion:(TableViewDataSourceLoadPaginatedDataCompletion)completion {
    switch (page) {
        case 1: {
            [self setItems:[self.items arrayByAddingObjectsFromArray:@[
                      [[FeedItem alloc] initWithTitle:@"Carrot" desc:@"An orange vegetable"],
                      [[FeedItem alloc] initWithTitle:@"Tomato" desc:@"A red vegetable"],
                  ]]];
            completion(YES);
            break;
        }
        case 2: {
            [self setItems:[self.items arrayByAddingObjectsFromArray:@[
                      [[FeedItem alloc] initWithTitle:@"Cucumber" desc:@"A green vegetable"],
                      [[FeedItem alloc] initWithTitle:@"Orange" desc:@"An orange fruit"],
                  ]]];
            completion(YES);
            break;
        }
        case 3: {
            [self setItems:[self.items arrayByAddingObjectsFromArray:@[
                      [[FeedItem alloc] initWithTitle:@"Apple" desc:@"An red/green fruit"],
                      [[FeedItem alloc] initWithTitle:@"Banana" desc:@"An yellow fruit"],
                  ]]];
            completion(YES);
            break;
        }
        default:
            completion(NO);
    }
}

- (TableViewDataSourceSection *)createDataSourceSectionInSection:(NSUInteger)section {
    return [[FeedTableViewDataSourceSection alloc] initWithObject:[self.items objectAtIndex:section]];
}

- (NSInteger)numberOfSections {
    return [self.items count];
}

@end
