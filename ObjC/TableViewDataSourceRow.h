//
//  TableViewDataSourceRow.h
//  Pods
//
//  Created by materik on 29/02/16.
//
//

#import <UIKit/UIKit.h>

@class TableViewCell, TableViewDataSource, TableViewDataSourceSection;

@interface TableViewDataSourceRow : UIViewController

@property(nonatomic, strong) id object;
@property(nonatomic, assign) NSUInteger row;
@property(nonatomic, readonly) Class cellClass;
@property(nonatomic, readonly) Class objectClass;

- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithObject:(id)object;

- (void)didSelectCell:(TableViewCell *)cell
  inDataSourceSection:(TableViewDataSourceSection *)dataSourceSection
         inDataSource:(TableViewDataSource *)dataSource;
- (void)willDisplayCell:(TableViewCell *)cell
    inDataSourceSection:(TableViewDataSourceSection *)dataSourceSection
           inDataSource:(TableViewDataSource *)dataSource;
- (void)didEndDisplayingCell:(TableViewCell *)cell
         inDataSourceSection:(TableViewDataSourceSection *)dataSourceSection
                inDataSource:(TableViewDataSource *)dataSource;
- (void)reloadInDataSourceSection:(TableViewDataSourceSection *)dataSourceSection
                     inDataSource:(TableViewDataSource *)dataSource
                 withRowAnimation:(UITableViewRowAnimation)animation;

- (CGFloat)heightInDataSourceSection:(TableViewDataSourceSection *)dataSourceSection
                        inDataSource:(TableViewDataSource *)dataSource;
- (TableViewCell *)dequeueOrCreateReusableCellInDataSourceSection:(TableViewDataSourceSection *)dataSourceSection
                                                     inDataSource:(TableViewDataSource *)dataSource;

@end
