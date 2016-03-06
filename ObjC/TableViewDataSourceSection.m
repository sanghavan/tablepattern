//
//  TableViewDataSourceSection.m
//  Pods
//
//  Created by materik on 10/02/16.
//
//

#import "TableViewDataSourceSection.h"

#import "TableViewDataSource.h"

@interface TableViewDataSourceSection ()

@property(nonatomic, strong) NSArray<TableViewDataSourceRow *> *dataSourceRows;

@end

@implementation TableViewDataSourceSection

- (instancetype)initWithObject:(id)object {
    self = [super init];
    if (self) {
        NSAssert([object isKindOfClass:self.objectClass], @"TableViewDataSourceSection: object need to be of class %@",
                 self.objectClass);
        [self setObject:object];
        [self setupRows];
    }
    return self;
}

- (Class)objectClass {
    NSAssert(NO, @"TableViewDataSourceSection: objectClass: need to be implemented by subclass");
    return nil;
}

- (NSUInteger)numberOfRows {
    NSAssert(NO, @"TableViewDataSourceSection: numberOfRows: need to be implemented by subclass");
    return 0;
}

- (TableViewDataSourceRow *)createDataSourceRowAtRow:(NSUInteger)row {
    NSAssert(NO, @"TableViewDataSourceSection: createDataSourceRowAtRow: need to be implemented by subclass");
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
    NSMutableArray *dataSourceRows = [NSMutableArray array];
    for (int row = 0; row < [self numberOfRows]; row++) {
        TableViewDataSourceRow *dataSourceRow = [self createDataSourceRowAtRow:row];
        [dataSourceRow setRow:row];
        [dataSourceRows addObject:dataSourceRow];
    }
    [self setDataSourceRows:dataSourceRows];
}

- (TableViewDataSourceRow *)getDataSourceRowAtRow:(NSUInteger)row {
    if (row < [self.dataSourceRows count]) {
        TableViewDataSourceRow *dataSourceRow = [self.dataSourceRows objectAtIndex:row];
        return [dataSourceRow isKindOfClass:[NSNull class]] ? nil : dataSourceRow;
    }
    return nil;
}

- (void)reloadDataSourceRowAtRow:(NSUInteger)row
                    inDataSource:(TableViewDataSource *)dataSource
                withRowAnimation:(UITableViewRowAnimation)animation {
    TableViewDataSourceRow *dataSourceRow = [self createDataSourceRowAtRow:row];
    [dataSourceRow setRow:row];

    NSMutableArray *dataSourceRows = [self.dataSourceRows mutableCopy];
    [dataSourceRows replaceObjectAtIndex:row withObject:dataSourceRow ?: [NSNull null]];
    [self setDataSourceRows:dataSourceRows];

    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row inSection:self.section];
    [dataSource.tableView reloadRowsAtIndexPaths:@[ indexPath ] withRowAnimation:animation];
}

@end
