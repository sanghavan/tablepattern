//
//  FeedTableViewDataSource.m
//  ObjCDemo
//
//  Created by materik on 10/02/16.
//
//

#import "FeedTableViewDataSource.h"

#import "FeedItem.h"
#import "FeedTableViewSection.h"

@interface FeedTableViewDataSource ()

@property(nonatomic, strong) NSArray<FeedItem *> *items;

@end

@implementation FeedTableViewDataSource

- (instancetype)init {
    self = [super init];
    if (self) {
        [self setEnablePagination:YES];
        [self setPaginationLimit:2];
    }
    return self;
}

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

- (TableViewSection *)createSectionAtIndex:(NSUInteger)section {
    return [[FeedTableViewSection alloc] initWithObject:[self.items objectAtIndex:section]];
}

- (NSUInteger)numberOfSections {
    return [self.items count];
}

@end
