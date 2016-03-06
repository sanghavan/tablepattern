//
//  TableViewDataSourceRow.m
//  Pods
//
//  Created by materik on 29/02/16.
//
//

#import "TableViewDataSourceRow.h"

#import "TableViewCell.h"
#import "TableViewDataSourceSection.h"

@implementation TableViewDataSourceRow

- (instancetype)initWithObject:(id)object {
    self = [super init];
    if (self) {
        NSAssert([object isKindOfClass:self.objectClass], @"TableViewDataSourceRow: object need to be of class %@",
                 self.objectClass);
        [self setObject:object];
    }
    return self;
}

- (Class)cellClass {
    NSString *className = NSStringFromClass([self class]);
    className = [className stringByReplacingOccurrencesOfString:@"DataSourceRow" withString:@"Cell"];
    return NSClassFromString(className);
}

- (Class)objectClass {
    NSAssert(NO, @"TableViewDataSourceRow: objectClass: need to be implemented by subclass");
    return nil;
}

#pragma mark - TableView

- (void)didSelectCell:(UITableViewCell *)cell
  inDataSourceSection:(TableViewDataSourceSection *)dataSourceSection
         inDataSource:(TableViewDataSource *)dataSource {
    // Do nothing...
}

- (void)willDisplayCell:(UITableViewCell *)cell
    inDataSourceSection:(TableViewDataSourceSection *)dataSourceSection
           inDataSource:(TableViewDataSource *)dataSource {
    // Do nothing...
}

- (void)didEndDisplayingCell:(UITableViewCell *)cell
         inDataSourceSection:(TableViewDataSourceSection *)dataSourceSection
                inDataSource:(TableViewDataSource *)dataSource {
    // Do nothing...
}

- (void)reloadInDataSourceSection:(TableViewDataSourceSection *)dataSourceSection
                     inDataSource:(TableViewDataSource *)dataSource
                 withRowAnimation:(UITableViewRowAnimation)animation {
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self.row inSection:dataSourceSection.section];
    [dataSource.tableView reloadRowsAtIndexPaths:@[ indexPath ] withRowAnimation:animation];
}

#pragma mark - TableViewCell

- (CGFloat)heightInDataSourceSection:(TableViewDataSourceSection *)dataSourceSection
                        inDataSource:(TableViewDataSource *)dataSource {
    NSAssert([self.cellClass isSubclassOfClass:[TableViewCell class]],
             @"TableViewDataSourceRow: cellClass needs to be subclass of TableViewCell");
    return [self.cellClass heightWithDataSourceRow:self inDataSourceSection:dataSourceSection inDataSource:dataSource];
}

- (TableViewCell *)dequeueOrCreateReusableCellInDataSourceSection:(TableViewDataSourceSection *)dataSourceSection
                                                     inDataSource:(TableViewDataSource *)dataSource {
    NSAssert([self.cellClass isSubclassOfClass:[TableViewCell class]],
             @"TableViewDataSourceRow: cellClass needs to be subclass of TableViewCell");
    TableViewCell *cell = [self.cellClass dequeueOrCreateReusableCellInDataSource:dataSource];
    [cell setupWithDataSourceRow:self inDataSourceSection:dataSourceSection inDataSource:dataSource];
    return cell;
}

@end
