//
//  TableViewDataSource.m
//  Pods
//
//  Created by materik on 26/01/16.
//
//

#import "TableViewDataSource.h"

#import "TableViewCell.h"
#import "TableViewCellChildViewControllerProtocol.h"
#import "TableViewCellModel.h"

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

- (TableViewDataSourceSection *)createSectionInSection:(NSUInteger)section {
    NSAssert(NO, @"need to be implemented by subclass");
    return nil;
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[self getSectionInSection:section] numberOfRows];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    NSAssert(NO, @"need to be implemented by subclass");
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TableViewCellModel *cellModel = [self tableView:tableView modelForCellAtIndexPath:indexPath];
    if (cellModel) {
        return [cellModel dequeueOrCreateReusableCellFromTableView:tableView];
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
    TableViewCellModel *cellModel = [self tableView:tableView modelForCellAtIndexPath:indexPath];
    if (cellModel) {
        return [cellModel heightFromTableView:tableView];
    }
    return 0.0f;
}

- (void)tableView:(UITableView *)tableView
  willDisplayCell:(UITableViewCell *)cell
forRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([cell conformsToProtocol:@protocol(TableViewCellChildViewControllerProtocol)]) {
        UIViewController *childViewController =
            [self getChildViewControllerFromTableViewCell:(id<TableViewCellChildViewControllerProtocol>)cell];
        [self.parentViewController addChildViewController:childViewController];
        [self childViewController:childViewController atIndexPath:indexPath];
    }

    TableViewDataSourceSection *section = [self getSectionInSection:indexPath.section];
    [section willDisplayCell:cell forRow:indexPath.row inTableView:tableView];

    [self.parentViewController addChildViewController:section];
}

- (void)tableView:(UITableView *)tableView
    didEndDisplayingCell:(UITableViewCell *)cell
       forRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([cell conformsToProtocol:@protocol(TableViewCellChildViewControllerProtocol)]) {
        UIViewController *childViewController =
            [self getChildViewControllerFromTableViewCell:(id<TableViewCellChildViewControllerProtocol>)cell];
        [childViewController removeFromParentViewController];
    }

    TableViewDataSourceSection *section = [self getSectionInSection:indexPath.section];
    [section didEndDisplayingCell:cell forRow:indexPath.row inTableView:tableView];

    NSArray<NSNumber *> *visibleIndexPaths = [tableView.indexPathsForVisibleRows valueForKey:@"section"];
    if (![visibleIndexPaths containsObject:@(indexPath.section)]) {
        [section removeFromParentViewController];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    TableViewDataSourceSection *section = [self getSectionInSection:indexPath.section];
    [section didSelectCell:cell forRow:indexPath.row inTableView:tableView];
}

#pragma mark Header/Footer

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    TableViewDataSourceSection *dataSourceSection = [self getSectionInSection:section];
    return [dataSourceSection headerHeightInTableView:tableView];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    TableViewDataSourceSection *dataSourceSection = [self getSectionInSection:section];
    return [dataSourceSection headerViewInTableView:tableView];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    TableViewDataSourceSection *dataSourceSection = [self getSectionInSection:section];
    return [dataSourceSection footerHeightInTableView:tableView];
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    TableViewDataSourceSection *dataSourceSection = [self getSectionInSection:section];
    return [dataSourceSection footerViewInTableView:tableView];
}

#pragma mark - Helper

- (void)setupSectionsInTableView:(UITableView *)tableView {
    NSMutableArray *sections = [NSMutableArray array];
    for (int i = 0; i < [self numberOfSectionsInTableView:tableView]; i++) {
        TableViewDataSourceSection *section = [self createSectionInSection:i];
        [section setIndex:i];
        [sections addObject:section];
    }
    [self setSections:sections];
}

- (TableViewDataSourceSection *)getSectionInSection:(NSUInteger)section {
    if (section < [self.sections count]) {
        return [self.sections objectAtIndex:section];
    }
    NSAssert(NO, @"did you forget to call [super reloadDataInTableView:]?");
    return nil;
}

- (TableViewCellModel *)tableView:(UITableView *)tableView modelForCellAtIndexPath:(NSIndexPath *)indexPath {
    return [[self getSectionInSection:indexPath.section] createCellModelAtRow:indexPath.row];
}

- (UIViewController *)getChildViewControllerFromTableViewCell:(id<TableViewCellChildViewControllerProtocol>)cell {
    return cell.childViewController;
}

@end
