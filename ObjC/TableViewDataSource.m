//
//  TableViewDataSource.m
//  Pods
//
//  Created by materik on 26/01/16.
//
//

#import "TableViewDataSource.h"

#import "TableViewCell.h"
#define weaken(object, newName) __typeof__(object) __weak newName = object

static NSUInteger const kPaginationPageDefault = 1;
static NSUInteger const kPaginationPageDisabled = 0;

static NSString *const kEmptyCellReuseIdentifier;

@interface TableViewDataSource ()

@property(nonatomic, strong) NSArray<TableViewDataSourceSection *> *dataSourceSections;
@property(nonatomic, assign) NSUInteger paginationPage;

@end

@implementation TableViewDataSource

- (UITableView *)tableView {
    return self.tableViewController.tableView;
}

#pragma mark - TableViewDataSource

- (void)resetData {
    [self setPaginationPage:self.isPaginationEnabled ? kPaginationPageDefault : kPaginationPageDisabled];
    [self reloadData];
}

- (void)reloadData {
    weaken(self, weakSelf);
    if (self.isPaginationEnabled) {
        NSAssert(self.paginationLimit > 0,
                 @"TableViewDataSource: reloadData: need to specify paginationLimit if you're going to use pagination");
        [self loadPaginatedDataInPage:self.paginationPage
                            withLimit:self.paginationLimit
                         onCompletion:^(BOOL hasMore) {
                           [weakSelf setPaginationPage:hasMore ? weakSelf.paginationPage + 1 : kPaginationPageDisabled];
                           [weakSelf setupData];
                         }];
    } else {
        [self loadDataOnCompletion:^{
          [weakSelf setupData];
        }];
    }
}

- (void)setupData {
    [self setupSections];
    [self.tableView reloadData];
}

- (void)loadDataOnCompletion:(TableViewDataSourceLoadDataCompletion)completion {
    NSAssert(NO, @"TableViewDataSource: loadData: need to be implemented by subclass");
}

- (void)loadPaginatedDataInPage:(NSUInteger)page
                      withLimit:(NSUInteger)limit
                   onCompletion:(TableViewDataSourceLoadPaginatedDataCompletion)completion {
    NSAssert(NO, @"TableViewDataSource: loadPaginatedData: need to be implemented by subclass");
}

- (NSInteger)numberOfSections {
    NSAssert(NO, @"TableViewDataSource: numberOfSections: need to be implemented by subclass");
    return 0;
}

- (TableViewDataSourceSection *)createDataSourceSectionInSection:(NSUInteger)section {
    NSAssert(NO, @"TableViewDataSource: createDataSourceSectionInSection: need to be implemented by subclass");
    return nil;
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[self getDataSourceSectionInSection:section] numberOfRows];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self numberOfSections];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TableViewDataSourceSection *dataSourceSection = [self getDataSourceSectionInSection:indexPath.section];
    TableViewDataSourceRow *dataSourceRow = [dataSourceSection getDataSourceRowAtRow:indexPath.row];
    if (dataSourceRow) {
        return [dataSourceRow dequeueOrCreateReusableCellInDataSourceSection:dataSourceSection inDataSource:self];
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
    TableViewDataSourceSection *dataSourceSection = [self getDataSourceSectionInSection:indexPath.section];
    TableViewDataSourceRow *dataSourceRow = [dataSourceSection getDataSourceRowAtRow:indexPath.row];
    if (dataSourceRow) {
        return [dataSourceRow heightInDataSourceSection:dataSourceSection inDataSource:self];
    }
    return 0.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    TableViewDataSourceSection *dataSourceSection = [self getDataSourceSectionInSection:indexPath.section];
    TableViewDataSourceRow *dataSourceRow = [dataSourceSection getDataSourceRowAtRow:indexPath.row];
    if (dataSourceRow) {
        [dataSourceRow didSelectCell:(TableViewCell *)cell inDataSourceSection:dataSourceSection inDataSource:self];
    }
}

- (void)tableView:(UITableView *)tableView
  willDisplayCell:(UITableViewCell *)cell
forRowAtIndexPath:(NSIndexPath *)indexPath {
    TableViewDataSourceSection *dataSourceSection = [self getDataSourceSectionInSection:indexPath.section];
    TableViewDataSourceRow *dataSourceRow = [dataSourceSection getDataSourceRowAtRow:indexPath.row];
    if (dataSourceRow) {
        [dataSourceRow willDisplayCell:(TableViewCell *)cell inDataSourceSection:dataSourceSection inDataSource:self];
        [self.tableViewController addChildViewController:dataSourceSection];
        [self.tableViewController addChildViewController:dataSourceRow];
    }

    if (indexPath.section == [self numberOfSections] - 1 && indexPath.row == [dataSourceSection numberOfRows] - 1 &&
        self.paginationPage != kPaginationPageDisabled) {
        [self reloadData];
    }
}

- (void)tableView:(UITableView *)tableView
    didEndDisplayingCell:(UITableViewCell *)cell
       forRowAtIndexPath:(NSIndexPath *)indexPath {
    TableViewDataSourceSection *dataSourceSection = [self getDataSourceSectionInSection:indexPath.section];
    TableViewDataSourceRow *dataSourceRow = [dataSourceSection getDataSourceRowAtRow:indexPath.row];
    if (dataSourceRow) {
        [dataSourceRow didEndDisplayingCell:(TableViewCell *)cell
                        inDataSourceSection:dataSourceSection
                               inDataSource:self];
        [dataSourceRow removeFromParentViewController];

        NSArray<NSNumber *> *visibleIndexPaths = [tableView.indexPathsForVisibleRows valueForKey:@"section"];
        if (![visibleIndexPaths containsObject:@(indexPath.section)]) {
            [dataSourceSection removeFromParentViewController];
        }
    }
}

#pragma mark Header/Footer

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    TableViewDataSourceSection *dataSourceSection = [self getDataSourceSectionInSection:section];
    return [dataSourceSection headerHeightInDataSource:self];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    TableViewDataSourceSection *dataSourceSection = [self getDataSourceSectionInSection:section];
    return [dataSourceSection headerViewInDataSource:self];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    TableViewDataSourceSection *dataSourceSection = [self getDataSourceSectionInSection:section];
    return [dataSourceSection footerHeightInDataSource:self];
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    TableViewDataSourceSection *dataSourceSection = [self getDataSourceSectionInSection:section];
    return [dataSourceSection footerViewInDataSource:self];
}

#pragma mark - Helper

- (void)setupSections {
    NSMutableArray *dataSourceSections = [NSMutableArray array];
    for (int section = 0; section < [self numberOfSections]; section++) {
        TableViewDataSourceSection *dataSourceSection = [self createDataSourceSectionInSection:section];
        [dataSourceSection setSection:section];
        [dataSourceSections addObject:dataSourceSection];
    }
    [self setDataSourceSections:dataSourceSections];
}

- (TableViewDataSourceSection *)getDataSourceSectionInSection:(NSUInteger)section {
    if (section < [self.dataSourceSections count]) {
        return [self.dataSourceSections objectAtIndex:section];
    }
    return nil;
}

- (TableViewDataSourceRow *)getDataSourceRowAtIndexPath:(NSIndexPath *)indexPath {
    TableViewDataSourceSection *dataSourceSection = [self getDataSourceSectionInSection:indexPath.section];
    return [dataSourceSection getDataSourceRowAtRow:indexPath.row];
}

@end
