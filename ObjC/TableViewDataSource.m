//
//  TableViewDataSource.m
//  Pods
//
//  Created by materik on 26/01/16.
//
//

#import "TableViewDataSource.h"

#import "TableViewCell.h"

static NSString *const kEmptyCellReuseIdentifier;

@interface TableViewDataSource ()

@property(nonatomic, strong) NSArray<TableViewDataSourceSection *> *sections;

@end

@implementation TableViewDataSource

- (void)reloadDataInTableView:(UITableView *)tableView {
    [self setupSectionsInTableView:tableView];
    [tableView reloadData];
}

- (void)childViewController:(UIViewController *)childViewController atIndexPath:(NSIndexPath *)indexPath {
    // Do nothing...
}

- (TableViewDataSourceSection *)createDataSourceSectionInSection:(NSUInteger)section {
    NSAssert(NO, @"need to be implemented by subclass");
    return nil;
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[self getDataSourceSectionInSection:section] numberOfRows];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    NSAssert(NO, @"need to be implemented by subclass");
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TableViewDataSourceRow *dataSourceRow = [self getDataSourceRowAtIndexPath:indexPath];
    if (dataSourceRow) {
        return [dataSourceRow dequeueOrCreateReusableCellInTableView:tableView];
    }
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kEmptyCellReuseIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:kEmptyCellReuseIdentifier];
    }
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    TableViewDataSourceRow *dataSourceRow = [self getDataSourceRowAtIndexPath:indexPath];
    if (dataSourceRow) {
        return [dataSourceRow heightInTableView:tableView];
    }
    return 0.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    TableViewDataSourceSection *section = [self getDataSourceSectionInSection:indexPath.section];
    [section didSelectCell:cell forRow:indexPath.row inTableView:tableView];
}

- (void)tableView:(UITableView *)tableView
  willDisplayCell:(UITableViewCell *)cell
forRowAtIndexPath:(NSIndexPath *)indexPath {
    TableViewDataSourceSection *section = [self getDataSourceSectionInSection:indexPath.section];
    [section willDisplayCell:cell forRow:indexPath.row inTableView:tableView];
    [self.parentViewController addChildViewController:section];
}

- (void)tableView:(UITableView *)tableView
    didEndDisplayingCell:(UITableViewCell *)cell
       forRowAtIndexPath:(NSIndexPath *)indexPath {
    TableViewDataSourceSection *section = [self getDataSourceSectionInSection:indexPath.section];
    [section didEndDisplayingCell:cell forRow:indexPath.row inTableView:tableView];

    NSArray<NSNumber *> *visibleIndexPaths = [tableView.indexPathsForVisibleRows valueForKey:@"section"];
    if (![visibleIndexPaths containsObject:@(indexPath.section)]) {
        [section removeFromParentViewController];
    }
}

#pragma mark Header/Footer

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    TableViewDataSourceSection *dataSourceSection = [self getDataSourceSectionInSection:section];
    return [dataSourceSection headerHeightInTableView:tableView];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    TableViewDataSourceSection *dataSourceSection = [self getDataSourceSectionInSection:section];
    return [dataSourceSection headerViewInTableView:tableView];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    TableViewDataSourceSection *dataSourceSection = [self getDataSourceSectionInSection:section];
    return [dataSourceSection footerHeightInTableView:tableView];
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    TableViewDataSourceSection *dataSourceSection = [self getDataSourceSectionInSection:section];
    return [dataSourceSection footerViewInTableView:tableView];
}

#pragma mark - Helper

- (void)setupSectionsInTableView:(UITableView *)tableView {
    NSMutableArray *sections = [NSMutableArray array];
    for (int i = 0; i < [self numberOfSectionsInTableView:tableView]; i++) {
        TableViewDataSourceSection *section = [self createDataSourceSectionInSection:i];
        [section setupRowsInTableView:tableView];
        [section setIndex:i];
        [sections addObject:section];
    }
    [self setSections:sections];
}

- (TableViewDataSourceSection *)getDataSourceSectionInSection:(NSUInteger)section {
    if (section < [self.sections count]) {
        return [self.sections objectAtIndex:section];
    }
    NSAssert(NO, @"did you forget to call [super reloadDataInTableView:]?");
    return nil;
}

- (TableViewDataSourceRow *)getDataSourceRowAtIndexPath:(NSIndexPath *)indexPath {
    TableViewDataSourceSection *dataSourceSection = [self getDataSourceSectionInSection:indexPath.section];
    return [dataSourceSection getDataSourceRowAtRow:indexPath.row];
}

@end
