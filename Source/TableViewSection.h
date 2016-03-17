//
//  TableViewSection.h
//  Pods
//
//  Created by materik on 26/01/16.
//
//

#import <UIKit/UIKit.h>

@class TableViewCell, TableViewDataSource, TableViewRow;

@interface TableViewSection <ObjectType> : UIViewController

@property(nonatomic, strong) ObjectType object;
@property(nonatomic, assign) NSUInteger index;
@property(nonatomic, readonly) NSUInteger numberOfRows;

- (instancetype)initWithObject:(ObjectType)object;
- (void)setupRows;

- (TableViewRow *)createRowAtIndex:(NSUInteger)index;
- (TableViewRow *)getRowAtIndex:(NSUInteger)index;
- (void)didSelectRowAtIndex:(NSUInteger)index inDataSource:(TableViewDataSource *)dataSource;
- (void)reloadInDataSource:(TableViewDataSource *)dataSource withRowAnimation:(UITableViewRowAnimation)animation;
- (void)reloadRowAtIndex:(NSUInteger)index
            inDataSource:(TableViewDataSource *)dataSource
        withRowAnimation:(UITableViewRowAnimation)animation;
- (void)reloadRowsAtIndexSet:(NSIndexSet *)indexSet
                inDataSource:(TableViewDataSource *)dataSource
            withRowAnimation:(UITableViewRowAnimation)animation;

- (CGFloat)headerHeightInDataSource:(TableViewDataSource *)dataSource;
- (UIView *)headerViewInDataSource:(TableViewDataSource *)dataSource;
- (CGFloat)footerHeightInDataSource:(TableViewDataSource *)dataSource;
- (UIView *)footerViewInDataSource:(TableViewDataSource *)dataSource;

- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithCoder:(NSCoder *)aDecoder NS_UNAVAILABLE;
- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil NS_UNAVAILABLE;

@end
