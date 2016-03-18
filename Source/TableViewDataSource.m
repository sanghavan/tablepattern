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

static CGFloat __loadingIndicatorSize;
static CGFloat __loadingIndicatorPadding;
static UIColor *__loadingIndicatorColor;
static NSUInteger const kPaginationPageDefault = 0;
static NSUInteger const kPaginationPageDisabled = -1;

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
    [self setLoading:loading andReuseExistingSections:NO];
}

- (void)setLoading:(BOOL)loading andReuseExistingSections:(BOOL)reuse {
    _loading = loading;
    if (self.isLoadingIndicatorEnabled) {
        [self.loadingSection setLoading:_loading];
    }
    [self setupDataAndReuseExistingSections:reuse];
}

- (BOOL)isPaginationEnabled {
    return _enablePagination && self.paginationPage != kPaginationPageDisabled;
}

#pragma mark - TableViewDataSource

- (void)resetAndLoadDataOnCompletion:(TableViewDataSourceReloadDataCompletion)completion {
    [self setPaginationPage:_enablePagination ? kPaginationPageDefault : kPaginationPageDisabled];
    [self loadDataOnCompletion:completion];
}

- (void)refreshDataOnCompletion:(TableViewDataSourceReloadDataCompletion)completion {
    [self setupDataAndReuseExistingSections:NO];
    if (completion) {
        completion();
    }
}

- (void)loadDataOnCompletion:(TableViewDataSourceReloadDataCompletion)completion {
    weaken(self, weakSelf);
    if (self.isPaginationEnabled) {
        NSAssert(self.paginationLimit > 0,
                 @"TableViewDataSource: need to specify paginationLimit if you're going to use pagination");
        [self loadNextPageOnCompletion:completion];
    } else {
        [self setLoading:YES];
        [self fetchDataOnCompletion:^{
          [weakSelf setLoading:NO];
          if (completion) {
              completion();
          }
        }];
    }
}

- (void)loadNextPageOnCompletion:(TableViewDataSourceReloadDataCompletion)completion {
    weaken(self, weakSelf);
    [self setLoading:YES andReuseExistingSections:YES];
    [self setPaginationPage:self.paginationPage + 1];
    [self fetchDataOnPage:self.paginationPage
                withLimit:self.paginationLimit
             onCompletion:^(BOOL hasMore) {
               [weakSelf setLoading:NO andReuseExistingSections:YES];
               if (!hasMore) {
                   [weakSelf setPaginationPage:kPaginationPageDisabled];
               }
               if (completion) {
                   completion();
               }
             }];
}

- (void)setupDataAndReuseExistingSections:(BOOL)reuse {
    if (!self.isLoading || [self.sections count] == 0) {
        [self setupSectionsAndReuseExistingSections:reuse];
        [self.tableView reloadData];
    }
}

- (void)fetchDataOnCompletion:(TableViewDataSourceLoadDataCompletion)completion {
    NSLog(@"WARNING: TableViewDataSource: fetchDataOnCompletion: should be implemented by subclass");
    completion();
}

- (void)fetchDataOnPage:(NSUInteger)page
              withLimit:(NSUInteger)limit
           onCompletion:(TableViewDataSourceLoadPaginatedDataCompletion)completion {
    NSLog(@"WARNING: TableViewDataSource: fetchDataOnPage: should be implemented by subclass");
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
    return [self getSectionAtIndex:section].numberOfRows;
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

    if (indexPath.section == self.numberOfSections && indexPath.row == section.numberOfRows - 1 &&
        self.isPaginationEnabled && !self.isLoading) {
        [self loadNextPageOnCompletion:nil];
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
    [self setupSectionsAndReuseExistingSections:NO];
}

- (void)setupSectionsAndReuseExistingSections:(BOOL)reuse {
    NSMutableArray *sections = [NSMutableArray array];

    if (reuse && self.sections) {
        sections = [self.sections mutableCopy];
        if (self.isLoadingIndicatorEnabled) {
            [sections removeLastObject];
        }
    }

    for (int index = (int)[sections count]; index < self.numberOfSections; index++) {
        TableViewSection *section = [self createSectionAtIndex:index];
        [section setIndex:index];
        [section setupRows];
        [sections addObject:section ?: [NSNull null]];
    }

    if (self.isLoadingIndicatorEnabled) {
        [self.loadingSection setIndex:[sections count]];
        [self.loadingSection setSize:self.loadingIndicatorSize ?: __loadingIndicatorSize];
        [self.loadingSection setPadding:self.loadingIndicatorPadding ?: __loadingIndicatorPadding];
        [self.loadingSection setColor:self.loadingIndicatorColor ?: __loadingIndicatorColor];
        [self.loadingSection setupRows];
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

+ (void)setLoadingIndicatorSize:(CGFloat)size {
    __loadingIndicatorSize = size;
}

+ (void)setLoadingIndicatorPadding:(CGFloat)padding {
    __loadingIndicatorPadding = padding;
}

+ (void)setLoadingIndicatorColor:(UIColor *)color {
    __loadingIndicatorColor = color;
}

@end
