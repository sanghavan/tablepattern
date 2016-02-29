//
//  TableViewDataSourceSection.h
//  Pods
//
//  Created by materik on 26/01/16.
//
//

#import <UIKit/UIKit.h>

#import "TableViewDataSourceRow.h"

@interface TableViewDataSourceSection : UIViewController

@property(nonatomic, strong) id model;
@property(nonatomic, assign) NSUInteger index;

- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithModel:(id)model;
- (void)setupRowsInTableView:(UITableView *)tableView;

- (NSUInteger)numberOfRows;
- (TableViewDataSourceRow *)createDataSourceRowAtRow:(NSUInteger)row;
- (TableViewDataSourceRow *)getDataSourceRowAtRow:(NSUInteger)row;

- (void)didSelectCell:(UITableViewCell *)cell forRow:(NSUInteger)row inTableView:(UITableView *)tableView;
- (void)willDisplayCell:(UITableViewCell *)cell forRow:(NSUInteger)row inTableView:(UITableView *)tableView;
- (void)didEndDisplayingCell:(UITableViewCell *)cell forRow:(NSUInteger)row inTableView:(UITableView *)tableView;

- (CGFloat)headerHeightInTableView:(UITableView *)tableView;
- (UIView *)headerViewInTableView:(UITableView *)tableView;
- (CGFloat)footerHeightInTableView:(UITableView *)tableView;
- (UIView *)footerViewInTableView:(UITableView *)tableView;

@end
