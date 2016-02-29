//
//  TableViewDataSourceSection.m
//  Pods
//
//  Created by materik on 10/02/16.
//
//

#import "TableViewDataSourceSection.h"

@implementation TableViewDataSourceSection

- (instancetype)initWithModel:(id)model {
    self = [super init];
    if (self) {
        [self setModel:model];
    }
    return self;
}

- (NSUInteger)numberOfRows {
    NSAssert(NO, @"need to be implemented by subclass");
    return 0;
}

- (TableViewCellModel *)createCellModelAtRow:(NSUInteger)row {
    NSAssert(NO, @"need to be implemented by subclass");
    return nil;
}

- (void)didSelectCell:(UITableViewCell *)cell forRow:(NSUInteger)row inTableView:(UITableView *)tableView {
    // Do nothing...
}

- (void)willDisplayCell:(UITableViewCell *)cell forRow:(NSUInteger)row inTableView:(UITableView *)tableView {
    // Do nothing...
}

- (void)didEndDisplayingCell:(UITableViewCell *)cell forRow:(NSUInteger)row inTableView:(UITableView *)tableView {
    // Do nothing...
}

#pragma mark Header/Footer

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

@end
