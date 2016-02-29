//
//  TableViewDataSourceRow.h
//  Pods
//
//  Created by materik on 29/02/16.
//
//

#import <UIKit/UIKit.h>

@class TableViewCell;

@interface TableViewDataSourceRow : UIViewController

@property(nonatomic, strong) id model;
@property(nonatomic, assign) NSUInteger index;

- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithModel:(id)model;

- (void)didSelectCell:(UITableViewCell *)cell inTableView:(UITableView *)tableView;
- (void)willDisplayCell:(UITableViewCell *)cell inTableView:(UITableView *)tableView;
- (void)didEndDisplayingCell:(UITableViewCell *)cell inTableView:(UITableView *)tableView;

- (Class)cellClass;
- (CGFloat)heightInTableView:(UITableView *)tableView;
- (TableViewCell *)dequeueOrCreateReusableCellInTableView:(UITableView *)tableView;

@end
