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
        [self setPaginationLimit:3];
    }
    return self;
}

- (void)resetAndLoadDataOnCompletion:(TableViewDataSourceReloadDataCompletion)completion {
    [self setItems:@[]];
    [super resetAndLoadDataOnCompletion:completion];
}

- (void)fetchDataOnCompletion:(TableViewDataSourceLoadDataCompletion)completion {
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

- (void)fetchDataOnPage:(NSUInteger)page
              withLimit:(NSUInteger)limit
           onCompletion:(TableViewDataSourceLoadPaginatedDataCompletion)completion {
    switch (page) {
        case 1: {
            // NOTE(materik): artificial delay
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(),
                           ^{
                             [self setItems:[self.items arrayByAddingObjectsFromArray:@[
                                       [[FeedItem alloc] initWithTitle:@"Carrot" desc:@"An orange vegetable"],
                                       [[FeedItem alloc] initWithTitle:@"Tomato" desc:@"A red vegetable"],
                                       [[FeedItem alloc] initWithTitle:@"Banana" desc:@"An yellow fruit"],
                                   ]]];
                             completion(YES);
                           });
            break;
        }
        case 2: {
            // NOTE(materik): artificial delay
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(),
                           ^{
                             [self setItems:[self.items arrayByAddingObjectsFromArray:@[
                                       [[FeedItem alloc] initWithTitle:@"Cucumber" desc:@"A green vegetable"],
                                       [[FeedItem alloc] initWithTitle:@"Orange" desc:@"An orange fruit"],
                                       [[FeedItem alloc] initWithTitle:@"Banana" desc:@"An yellow fruit"],
                                   ]]];
                             completion(YES);
                           });
            break;
        }
        case 3: {
            // NOTE(materik): artificial delay
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(),
                           ^{
                             [self setItems:[self.items arrayByAddingObjectsFromArray:@[
                                       [[FeedItem alloc] initWithTitle:@"Apple" desc:@"An red/green fruit"],
                                       [[FeedItem alloc] initWithTitle:@"Banana" desc:@"An yellow fruit"],
                                       [[FeedItem alloc] initWithTitle:@"Banana" desc:@"An yellow fruit"],
                                   ]]];
                             completion(YES);
                           });
            break;
        }
        case 4: {
            // NOTE(materik): artificial delay
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(),
                           ^{
                             [self setItems:[self.items arrayByAddingObjectsFromArray:@[
                                       [[FeedItem alloc] initWithTitle:@"Carrot" desc:@"An orange vegetable"],
                                       [[FeedItem alloc] initWithTitle:@"Tomato" desc:@"A red vegetable"],
                                       [[FeedItem alloc] initWithTitle:@"Banana" desc:@"An yellow fruit"],
                                   ]]];
                             completion(YES);
                           });
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
