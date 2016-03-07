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

- (TableViewRow *)createRowAtRow:(NSUInteger)row {
    NSAssert(NO, @"TableViewSection: createRowAtRow: need to be implemented by subclass");
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
    for (int rowIndex = 0; rowIndex < [self numberOfRows]; rowIndex++) {
        TableViewRow *row = [self createRowAtRow:rowIndex];
        [row setRowIndex:rowIndex];
        [rows addObject:row];
    }
    [self setRows:rows];
}

- (TableViewRow *)getRowAtRow:(NSUInteger)rowIndex {
    if (rowIndex < [self.rows count]) {
        TableViewRow *row = [self.rows objectAtIndex:rowIndex];
        return [row isKindOfClass:[NSNull class]] ? nil : row;
    }
    return nil;
}

- (void)reloadRowAtRow:(NSUInteger)rowIndex
          inDataSource:(TableViewDataSource *)dataSource
      withRowAnimation:(UITableViewRowAnimation)animation {
    TableViewRow *row = [self createRowAtRow:rowIndex];
    [row setRowIndex:rowIndex];

    NSMutableArray *rows = [self.rows mutableCopy];
    [rows replaceObjectAtIndex:rowIndex withObject:row ?: [NSNull null]];
    [self setRows:rows];

    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:rowIndex inSection:self.sectionIndex];
    [dataSource.tableView reloadRowsAtIndexPaths:@[ indexPath ] withRowAnimation:animation];
}

@end
