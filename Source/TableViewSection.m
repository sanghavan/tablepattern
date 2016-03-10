//
//  TableViewSection.m
//  Pods
//
//  Created by materik on 10/02/16.
//
//

#import "TableViewSection.h"

#import "TableViewDataSource.h"

@interface TableViewSection ()

@property(nonatomic, strong) NSArray<TableViewRow *> *rows;

@end

@implementation TableViewSection

- (instancetype)initWithObject:(id)object {
    self = [super init];
    if (self) {
        NSAssert([object isKindOfClass:self.objectClass], @"TableViewSection: object need to be of class %@",
                 self.objectClass);
        [self setObject:object];
        [self setupRows];
    }
    return self;
}

- (Class)objectClass {
    NSAssert(NO, @"TableViewSection: objectClass: need to be implemented by subclass");
    return nil;
}

- (NSUInteger)numberOfRows {
    NSAssert(NO, @"TableViewSection: numberOfRows: need to be implemented by subclass");
    return 0;
}

- (TableViewRow *)createRowAtIndex:(NSUInteger)row {
    NSAssert(NO, @"TableViewSection: createRowAtIndex: need to be implemented by subclass");
    return nil;
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
    for (int index = 0; index < [self numberOfRows]; index++) {
        TableViewRow *row = [self createRowAtIndex:index];
        if (row) {
            [row setIndex:index];
            [rows addObject:row];
        }
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

- (void)reloadRowAtIndex:(NSUInteger)index
            inDataSource:(TableViewDataSource *)dataSource
        withRowAnimation:(UITableViewRowAnimation)animation {
    TableViewRow *row = [self createRowAtIndex:index];
    [row setIndex:index];

    NSMutableArray *rows = [self.rows mutableCopy];
    [rows replaceObjectAtIndex:index withObject:row ?: [NSNull null]];
    [self setRows:rows];

    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:self.index];
    [dataSource.tableView reloadRowsAtIndexPaths:@[ indexPath ] withRowAnimation:animation];
}

@end
