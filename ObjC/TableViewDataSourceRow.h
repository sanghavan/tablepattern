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

@property(nonatomic, strong) id object;
@property(nonatomic, assign) NSUInteger index;

- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithObject:(id)object;

- (Class)cellClass;
- (Class)objectClass;

- (void)didSelectCell:(UITableViewCell *)cell inTableView:(UITableView *)tableView;
- (void)willDisplayCell:(UITableViewCell *)cell inTableView:(UITableView *)tableView;
- (void)didEndDisplayingCell:(UITableViewCell *)cell inTableView:(UITableView *)tableView;

- (CGFloat)heightInTableView:(UITableView *)tableView;
- (TableViewCell *)dequeueOrCreateReusableCellInTableView:(UITableView *)tableView;

@end
