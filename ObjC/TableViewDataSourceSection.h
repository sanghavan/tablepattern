//
//  TableViewDataSourceSection.h
//  Pods
//
//  Created by materik on 26/01/16.
//
//

#import <UIKit/UIKit.h>

@class TableViewDataSource, TableViewDataSourceRow;

@interface TableViewDataSourceSection : UIViewController

@property(nonatomic, strong) id object;
@property(nonatomic, assign) NSUInteger section;
@property(nonatomic, readonly) NSInteger numberOfRows;
@property(nonatomic, readonly) Class objectClass;

- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithObject:(id)object;

- (TableViewDataSourceRow *)createDataSourceRowAtRow:(NSUInteger)row;
- (TableViewDataSourceRow *)getDataSourceRowAtRow:(NSUInteger)row;
- (void)reloadDataSourceRowAtRow:(NSUInteger)row
                    inDataSource:(TableViewDataSource *)dataSource
                withRowAnimation:(UITableViewRowAnimation)animation;

- (CGFloat)headerHeightInDataSource:(TableViewDataSource *)dataSource;
- (UIView *)headerViewInDataSource:(TableViewDataSource *)dataSource;
- (CGFloat)footerHeightInDataSource:(TableViewDataSource *)dataSource;
- (UIView *)footerViewInDataSource:(TableViewDataSource *)dataSource;

@end
