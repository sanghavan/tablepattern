//
//  TableViewDataSource.m
//  Pods
//
//  Created by materik on 26/01/16.
//
//

#import "TableViewDataSource.h"

#import "LoadingTableViewSection.h"
#import "TableViewCell.h"

#define weaken(object, newName) __typeof__(object) __weak newName = object

static UIColor *_loadingIndicatorTintColor;
static NSUInteger const kPaginationPageDefault = 1;
static NSUInteger const kPaginationPageDisabled = 0;

static NSString *const kEmptyCellReuseIdentifier;

@interface TableViewDataSource ()

@property(nonatomic, strong) NSArray<TableViewSection *> *sections;
@property(nonatomic, readonly) LoadingTableViewSection *loadingSection;

@end

@implementation TableViewDataSource

@synthesize loadingSection = _loadingSection;

- (instancetype)init {
    self = [super init];
    if (self) {
        [self setEnableLoadingIndicator:YES];
    }
    return self;
}

- (UITableView *)tableView {
    return self.tableViewController.tableView;
}

- (LoadingTableViewSection *)loadingSection {
    if (!_loadingSection) {
        _loadingSection = [[LoadingTableViewSection alloc] initWithObject:nil];
    }
    return _loadingSection;
}

- (void)setLoading:(BOOL)loading {
    _loading = loading;
    if (self.isLoadingIndicatorEnabled) {
        [self.loadingSection setLoading:self.isLoading inDataSource:self];
    }
    [self setupData];
}

#pragma mark - TableViewDataSource

- (void)resetData {
    [self resetDataOnCompletion:nil];
}

- (void)resetDataOnCompletion:(TableViewDataSourceReloadDataCompletion)completion {
    [self setPaginationPage:self.isPaginationEnabled ? kPaginationPageDefault : kPaginationPageDisabled];
    [self reloadDataOnCompletion:completion];
}

- (void)reloadData {
    [self reloadDataOnCompletion:nil];
}

- (void)reloadDataOnCompletion:(TableViewDataSourceReloadDataCompletion)completion {
    weaken(self, weakSelf);

    [self setLoading:YES];

    if (self.isPaginationEnabled) {
        NSAssert(self.paginationLimit > 0,
                 @"TableViewDataSource: reloadData: need to specify paginationLimit if you're going to use pagination");
        if (self.paginationPage == kPaginationPageDisabled) {
            [self setLoading:NO];
            return;
        }
        [self loadPaginatedDataInPage:self.paginationPage
                            withLimit:self.paginationLimit
                         onCompletion:^(BOOL hasMore) {
                           [weakSelf setPaginationPage:hasMore ? weakSelf.paginationPage + 1 : kPaginationPageDisabled];
                           [weakSelf setLoading:NO];
                           if (completion) {
                               completion();
                           }
                         }];
    } else {
        [self loadDataOnCompletion:^{
          [weakSelf setLoading:NO];
          if (completion) {
              completion();
          }
        }];
    }
}

- (void)setupData {
    [self setupSections];
    [self.tableView reloadData];
}

- (void)loadDataOnCompletion:(TableViewDataSourceLoadDataCompletion)completion {
    NSLog(@"WARNING: TableViewDataSource: loadData: should be implemented by subclass");
    completion();
}

- (void)loadPaginatedDataInPage:(NSUInteger)page
                      withLimit:(NSUInteger)limit
                   onCompletion:(TableViewDataSourceLoadPaginatedDataCompletion)completion {
    NSLog(@"WARNING: TableViewDataSource: loadPaginatedDataInPage: should be implemented by subclass");
    completion(NO);
}

- (NSUInteger)numberOfSections {
    NSAssert(NO, @"TableViewDataSource: numberOfSections: need to be implemented by subclass");
    return 0;
}

- (TableViewSection *)createSectionAtIndex:(NSUInteger)section {
    NSAssert(NO, @"TableViewDataSource: createSectionAtIndex: need to be implemented by subclass");
    return nil;
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[self getSectionAtIndex:section] numberOfRows];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.numberOfSections + (self.isLoadingIndicatorEnabled ? 1 : 0);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TableViewSection *section = [self getSectionAtIndex:indexPath.section];
    TableViewRow *row = [section getRowAtIndex:indexPath.row];
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
    TableViewSection *section = [self getSectionAtIndex:indexPath.section];
    TableViewRow *row = [section getRowAtIndex:indexPath.row];
    if (row) {
        return [row heightInSection:section inDataSource:self];
    }
    return 0.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    TableViewSection *section = [self getSectionAtIndex:indexPath.section];
    if (section) {
        [section didSelectRowAtIndex:indexPath.row inDataSource:self];
    }
}

- (void)tableView:(UITableView *)tableView
  willDisplayCell:(UITableViewCell *)cell
forRowAtIndexPath:(NSIndexPath *)indexPath {
    TableViewSection *section = [self getSectionAtIndex:indexPath.section];
    TableViewRow *row = [section getRowAtIndex:indexPath.row];
    if (row) {
        [row willDisplayCell:(TableViewCell *)cell inSection:section inDataSource:self];
        [self.tableViewController addChildViewController:section];
        [self.tableViewController addChildViewController:row];
    }

    if (indexPath.section == self.numberOfSections - 1 && indexPath.row == [section numberOfRows] - 1 &&
        self.paginationPage != kPaginationPageDisabled && !self.isLoading) {
        [self reloadData];
    }
}

- (void)tableView:(UITableView *)tableView
    didEndDisplayingCell:(UITableViewCell *)cell
       forRowAtIndexPath:(NSIndexPath *)indexPath {
    TableViewSection *section = [self getSectionAtIndex:indexPath.section];
    TableViewRow *row = [section getRowAtIndex:indexPath.row];
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

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)index {
    TableViewSection *section = [self getSectionAtIndex:index];
    return [section headerHeightInDataSource:self];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)index {
    TableViewSection *section = [self getSectionAtIndex:index];
    return [section headerViewInDataSource:self];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)index {
    TableViewSection *section = [self getSectionAtIndex:index];
    return [section footerHeightInDataSource:self];
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)index {
    TableViewSection *section = [self getSectionAtIndex:index];
    return [section footerViewInDataSource:self];
}

#pragma mark - Helper

- (void)setupSections {
    NSMutableArray *sections = [NSMutableArray array];
    for (int index = 0; index < self.numberOfSections; index++) {
        TableViewSection *section = [self createSectionAtIndex:index];
        [section setIndex:index];
        [section setupRows];
        [sections addObject:section ?: [NSNull null]];
    }

    if (self.isLoadingIndicatorEnabled) {
        [self.loadingSection setIndex:[sections count]];
        [sections addObject:self.loadingSection];
    }

    [self setSections:sections];
}

- (TableViewSection *)getSectionAtIndex:(NSUInteger)index {
    if (index < [self.sections count]) {
        TableViewSection *section = [self.sections objectAtIndex:index];
        return [section isKindOfClass:[NSNull class]] ? nil : section;
    }
    return nil;
}

- (TableViewRow *)getRowAtIndexPath:(NSIndexPath *)indexPath {
    TableViewSection *section = [self getSectionAtIndex:indexPath.section];
    return [section getRowAtIndex:indexPath.row];
}

#pragma mark - Static

+ (UIColor *)loadingIndicatorTintColor {
    return _loadingIndicatorTintColor;
}

+ (void)setLoadingIndicatorTintColor:(UIColor *)tintColor {
    _loadingIndicatorTintColor = tintColor;
}

@end
