//
//  TableViewDataSourceRow.m
//  Pods
//
//  Created by materik on 29/02/16.
//
//

#import "TableViewDataSourceRow.h"

#import "TableViewCell.h"

@implementation TableViewDataSourceRow

- (instancetype)initWithModel:(id)model {
    self = [super init];
    if (self) {
        [self setModel:model];
    }
    return self;
}

#pragma mark - TableView

- (void)didSelectCell:(UITableViewCell *)cell inTableView:(UITableView *)tableView {
    // Do nothing...
}

- (void)willDisplayCell:(UITableViewCell *)cell inTableView:(UITableView *)tableView {
    // Do nothing...
}

- (void)didEndDisplayingCell:(UITableViewCell *)cell inTableView:(UITableView *)tableView {
    // Do nothing...
}

#pragma mark - TableViewCell

- (Class)cellClass {
    NSString *className = NSStringFromClass([self class]);
    className = [className stringByReplacingOccurrencesOfString:@"DataSourceRow" withString:@"Cell"];
    return NSClassFromString(className);
}

- (CGFloat)heightInTableView:(UITableView *)tableView {
    NSAssert([self.cellClass isSubclassOfClass:[TableViewCell class]],
             @"cellClass needs to be subclass of TableViewCell");
    return [self.cellClass heightWithRow:self inTableView:tableView];
}

- (TableViewCell *)dequeueOrCreateReusableCellInTableView:(UITableView *)tableView {
    NSAssert([self.cellClass isSubclassOfClass:[TableViewCell class]],
             @"cellClass needs to be subclass of TableViewCell");
    TableViewCell *cell = [self.cellClass dequeueOrCreateReusableCellInTableView:tableView];
    [cell setupWithRow:self];
    return cell;
}

@end
