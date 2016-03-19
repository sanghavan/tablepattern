//
//  TableViewSection.m
//  Pods
//
//  Created by materik on 10/02/16.
//
//

#import "TableViewSection.h"

#import "TableViewDataSource.h"

#define weaken(object, newName) __typeof__(object) __weak newName = object

@interface TableViewSection ()

@property(nonatomic, strong) NSArray<TableViewRow *> *rows;

@end

@implementation TableViewSection

- (instancetype)initWithObject:(id)object {
    self = [super init];
    if (self) {
        [self setObject:object];
    }
    return self;
}

- (NSUInteger)numberOfRows {
    NSAssert(NO, @"TableViewSection: numberOfRows: need to be implemented by subclass");
    return 0;
}

- (TableViewRow *)createRowAtIndex:(NSUInteger)index {
    NSAssert(NO, @"TableViewSection: createRowAtIndex: need to be implemented by subclass");
    return nil;
}

- (TableViewRow *)_createRowAtIndex:(NSUInteger)index {
    TableViewRow *row = [self createRowAtIndex:index];
    if (row) {
        [row setIndex:index];
        [self addChildViewController:row];
    }
    return row;
}

#pragma mark - Header/Footer

- (CGFloat)headerHeightInDataSource:(TableViewDataSource *)dataSource {
    return 0.0f;
}

- (UIView *)headerViewInDataSource:(TableViewDataSource *)dataSource {
    return nil;
}

- (CGFloat)footerHeightInDataSource:(TableViewDataSource *)dataSource {
    return 0.0f;
}

- (UIView *)footerViewInDataSource:(TableViewDataSource *)dataSource {
    return nil;
}

#pragma mark - Helper

- (void)setupRows {
    NSMutableArray *rows = [NSMutableArray array];
    for (int index = 0; index < self.numberOfRows; index++) {
        TableViewRow *row = [self _createRowAtIndex:index];
        [rows addObject:row ?: [NSNull null]];
    }
    [self setRows:rows];
}

- (TableViewRow *)getRowAtIndex:(NSUInteger)index {
    if (index < [self.rows count]) {
        TableViewRow *row = [self.rows objectAtIndex:index];
        return [row isKindOfClass:[NSNull class]] ? nil : row;
    }
    return nil;
}

- (void)didSelectRowAtIndex:(NSUInteger)index inDataSource:(TableViewDataSource *)dataSource {
    TableViewRow *row = [self.rows objectAtIndex:index];
    if (row) {
        [row didSelectInSection:self inDataSource:dataSource];
    }
}

- (void)reloadInDataSource:(TableViewDataSource *)dataSource withRowAnimation:(UITableViewRowAnimation)animation {
    [self setupRows];
    NSIndexSet *indexSet = [NSIndexSet indexSetWithIndex:self.index];
    [dataSource.tableView reloadSections:indexSet withRowAnimation:animation];
}

- (void)reloadRowAtIndex:(NSUInteger)index
            inDataSource:(TableViewDataSource *)dataSource
        withRowAnimation:(UITableViewRowAnimation)animation {
    [self reloadRowsAtIndexes:@[ @(index) ] inDataSource:dataSource withRowAnimation:animation];
}

- (void)reloadRowsAtIndexes:(NSArray<NSNumber *> *)indexes
               inDataSource:(TableViewDataSource *)dataSource
           withRowAnimation:(UITableViewRowAnimation)animation {
    NSMutableArray<NSNumber *> *validIndexes = [[NSMutableArray alloc] init];
    for (NSNumber *number in indexes) {
        NSInteger index = [number integerValue];
        if (index < [dataSource.tableView numberOfRowsInSection:self.index] && index < [self.rows count]) {
            [validIndexes addObject:number];
        }
    }

    NSMutableArray<NSIndexPath *> *indexPaths = [[NSMutableArray alloc] init];
    for (NSNumber *number in validIndexes) {
        NSInteger index = [number integerValue];
        TableViewRow *row = [self _createRowAtIndex:index];
        NSMutableArray *rows = [self.rows mutableCopy];
        [rows replaceObjectAtIndex:index withObject:row ?: [NSNull null]];
        [self setRows:rows];

        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:self.index];
        [indexPaths addObject:indexPath];
    }

    if ([indexPaths count]) {
        [dataSource.tableView reloadRowsAtIndexPaths:indexPaths withRowAnimation:animation];
    }
}

@end
