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

@property(nonatomic, strong) NSArray<TableViewSection *> *sections;
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

- (NSUInteger)numberOfSections {
    NSAssert(NO, @"TableViewDataSource: numberOfSections: need to be implemented by subclass");
    return 0;
}

- (TableViewSection *)createSectionInSection:(NSUInteger)section {
    NSAssert(NO, @"TableViewDataSource: createSectionInSection: need to be implemented by subclass");
    return nil;
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[self getSectionInSection:section] numberOfRows];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self numberOfSections];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TableViewSection *section = [self getSectionInSection:indexPath.section];
    TableViewRow *row = [section getRowAtRow:indexPath.row];
    if (row) {
        return [row dequeueOrCreateReusableCellInSection:section inDataSource:self];
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
    TableViewSection *section = [self getSectionInSection:indexPath.section];
    TableViewRow *row = [section getRowAtRow:indexPath.row];
    if (row) {
        return [row heightInSection:section inDataSource:self];
    }
    return 0.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    TableViewSection *section = [self getSectionInSection:indexPath.section];
    TableViewRow *row = [section getRowAtRow:indexPath.row];
    if (row) {
        [row didSelectCell:(TableViewCell *)cell inSection:section inDataSource:self];
    }
}

- (void)tableView:(UITableView *)tableView
  willDisplayCell:(UITableViewCell *)cell
forRowAtIndexPath:(NSIndexPath *)indexPath {
    TableViewSection *section = [self getSectionInSection:indexPath.section];
    TableViewRow *row = [section getRowAtRow:indexPath.row];
    if (row) {
        [row willDisplayCell:(TableViewCell *)cell inSection:section inDataSource:self];
        [self.tableViewController addChildViewController:section];
        [self.tableViewController addChildViewController:row];
    }

    if (indexPath.section == [self numberOfSections] - 1 && indexPath.row == [section numberOfRows] - 1 &&
        self.paginationPage != kPaginationPageDisabled) {
        [self reloadData];
    }
}

- (void)tableView:(UITableView *)tableView
    didEndDisplayingCell:(UITableViewCell *)cell
       forRowAtIndexPath:(NSIndexPath *)indexPath {
    TableViewSection *section = [self getSectionInSection:indexPath.section];
    TableViewRow *row = [section getRowAtRow:indexPath.row];
    if (row) {
        [row didEndDisplayingCell:(TableViewCell *)cell inSection:section inDataSource:self];
        [row removeFromParentViewController];

        NSArray<NSNumber *> *visibleIndexPaths = [tableView.indexPathsForVisibleRows valueForKey:@"section"];
        if (![visibleIndexPaths containsObject:@(indexPath.section)]) {
            [section removeFromParentViewController];
        }
    }
}

#pragma mark Header/Footer

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)sectionIndex {
    TableViewSection *section = [self getSectionInSection:sectionIndex];
    return [section headerHeightInDataSource:self];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)sectionIndex {
    TableViewSection *section = [self getSectionInSection:sectionIndex];
    return [section headerViewInDataSource:self];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)sectionIndex {
    TableViewSection *section = [self getSectionInSection:sectionIndex];
    return [section footerHeightInDataSource:self];
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)sectionIndex {
    TableViewSection *section = [self getSectionInSection:sectionIndex];
    return [section footerViewInDataSource:self];
}

#pragma mark - Helper

- (void)setupSections {
    NSMutableArray *sections = [NSMutableArray array];
    for (int sectionIndex = 0; sectionIndex < [self numberOfSections]; sectionIndex++) {
        TableViewSection *section = [self createSectionInSection:sectionIndex];
        [section setSectionIndex:sectionIndex];
        [sections addObject:section];
    }
    [self setSections:sections];
}

- (TableViewSection *)getSectionInSection:(NSUInteger)section {
    if (section < [self.sections count]) {
        return [self.sections objectAtIndex:section];
    }
    return nil;
}

- (TableViewRow *)getRowAtIndexPath:(NSIndexPath *)indexPath {
    TableViewSection *section = [self getSectionInSection:indexPath.section];
    return [section getRowAtRow:indexPath.row];
}

@end
