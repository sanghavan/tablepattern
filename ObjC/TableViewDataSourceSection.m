//
//  TableViewDataSourceSection.m
//  Pods
//
//  Created by materik on 10/02/16.
//
//

#import "TableViewDataSourceSection.h"

@interface TableViewDataSourceSection ()

@property(nonatomic, strong) NSArray<TableViewDataSourceRow *> *rows;

@end

@implementation TableViewDataSourceSection

- (instancetype)initWithObject:(id)object {
    self = [super init];
    if (self) {
        NSAssert([object isKindOfClass:self.objectClass], @"object need to be of class %@", self.objectClass);
        [self setObject:object];
    }
    return self;
}

- (Class)objectClass {
    NSAssert(NO, @"need to be implemented by subclass");
    return nil;
}

- (NSUInteger)numberOfRows {
    NSAssert(NO, @"need to be implemented by subclass");
    return 0;
}

- (TableViewDataSourceRow *)createDataSourceRowAtRow:(NSUInteger)row {
    NSAssert(NO, @"need to be implemented by subclass");
    return nil;
}

#pragma mark - TableView

- (void)didSelectCell:(UITableViewCell *)cell forRow:(NSUInteger)row inTableView:(UITableView *)tableView {
    TableViewDataSourceRow *dataSourceRow = [self getDataSourceRowAtRow:row];
    [dataSourceRow didSelectCell:cell inTableView:tableView];
}

- (void)willDisplayCell:(UITableViewCell *)cell forRow:(NSUInteger)row inTableView:(UITableView *)tableView {
    TableViewDataSourceRow *dataSourceRow = [self getDataSourceRowAtRow:row];
    [dataSourceRow willDisplayCell:cell inTableView:tableView];
    [self addChildViewController:dataSourceRow];
}

- (void)didEndDisplayingCell:(UITableViewCell *)cell forRow:(NSUInteger)row inTableView:(UITableView *)tableView {
    TableViewDataSourceRow *dataSourceRow = [self getDataSourceRowAtRow:row];
    [dataSourceRow didEndDisplayingCell:cell inTableView:tableView];
    [dataSourceRow removeFromParentViewController];
}

#pragma mark - Header/Footer

- (CGFloat)headerHeightInTableView:(UITableView *)tableView {
    return 0.0f;
}

- (UIView *)headerViewInTableView:(UITableView *)tableView {
    return nil;
}

- (CGFloat)footerHeightInTableView:(UITableView *)tableView {
    return 0.0f;
}

- (UIView *)footerViewInTableView:(UITableView *)tableView {
    return nil;
}

#pragma mark - Helper

- (void)setupRowsInTableView:(UITableView *)tableView {
    NSMutableArray *rows = [NSMutableArray array];
    for (int i = 0; i < [self numberOfRows]; i++) {
        TableViewDataSourceRow *row = [self createDataSourceRowAtRow:i];
        [row setIndex:i];
        [rows addObject:row];
    }
    [self setRows:rows];
}

- (TableViewDataSourceRow *)getDataSourceRowAtRow:(NSUInteger)row {
    if (row < [self.rows count]) {
        return [self.rows objectAtIndex:row];
    }
    NSAssert(NO, @"did you forget to call [super reloadDataInTableView:]?");
    return nil;
}

@end
