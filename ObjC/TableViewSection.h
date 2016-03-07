//
//  TableViewSection.h
//  Pods
//
//  Created by materik on 26/01/16.
//
//

#import <UIKit/UIKit.h>

@class TableViewDataSource, TableViewRow;

@interface TableViewSection : UIViewController

@property(nonatomic, strong) id object;
@property(nonatomic, assign) NSUInteger sectionIndex;
@property(nonatomic, readonly) NSUInteger numberOfRows;
@property(nonatomic, readonly) Class objectClass;

- (instancetype)initWithObject:(id)object;

- (TableViewRow *)createRowAtRow:(NSUInteger)row;
- (TableViewRow *)getRowAtRow:(NSUInteger)row;
- (void)reloadRowAtRow:(NSUInteger)row
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
