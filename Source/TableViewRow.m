//
//  TableViewRow.m
//  Pods
//
//  Created by materik on 29/02/16.
//
//

#import "TableViewRow.h"

#import "TableViewCell.h"
#import "TableViewSection.h"

@implementation TableViewRow

- (instancetype)initWithObject:(id)object {
    self = [super init];
    if (self) {
        NSAssert([object isKindOfClass:self.objectClass], @"TableViewRow: object need to be of class %@",
                 self.objectClass);
        [self setObject:object];
    }
    return self;
}

- (Class)cellClass {
    NSString *className = NSStringFromClass([self class]);
    className = [className stringByReplacingOccurrencesOfString:@"Row" withString:@"Cell"];
    return NSClassFromString(className);
}

- (Class)objectClass {
    NSAssert(NO, @"TableViewRow: objectClass: need to be implemented by subclass");
    return nil;
}

#pragma mark - TableView

- (void)willDisplayCell:(UITableViewCell *)cell
              inSection:(TableViewSection *)section
           inDataSource:(TableViewDataSource *)dataSource {
    // Do nothing...
}

- (void)didEndDisplayingCell:(UITableViewCell *)cell
                   inSection:(TableViewSection *)section
                inDataSource:(TableViewDataSource *)dataSource {
    // Do nothing...
}

- (void)didSelectInSection:(TableViewSection *)section inDataSource:(TableViewDataSource *)dataSource {
    // Do nothing...
}

- (void)reloadInSection:(TableViewSection *)section
           inDataSource:(TableViewDataSource *)dataSource
       withRowAnimation:(UITableViewRowAnimation)animation {
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self.index inSection:section.index];
    [dataSource.tableView reloadRowsAtIndexPaths:@[ indexPath ] withRowAnimation:animation];
}

#pragma mark - TableViewCell

- (CGFloat)heightInSection:(TableViewSection *)section inDataSource:(TableViewDataSource *)dataSource {
    NSAssert([self.cellClass isSubclassOfClass:[TableViewCell class]],
             @"TableViewRow: cellClass needs to be subclass of TableViewCell");
    return [self.cellClass heightInRow:self inSection:section inDataSource:dataSource];
}

- (TableViewCell *)dequeueOrCreateReusableCellInSection:(TableViewSection *)section
                                           inDataSource:(TableViewDataSource *)dataSource {
    NSAssert([self.cellClass isSubclassOfClass:[TableViewCell class]],
             @"TableViewRow: cellClass needs to be subclass of TableViewCell");
    TableViewCell *cell = [self.cellClass dequeueOrCreateReusableCellInDataSource:dataSource];
    [cell setupInRow:self inSection:section inDataSource:dataSource];
    return cell;
}

@end
