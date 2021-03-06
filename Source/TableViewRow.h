//
//  TableViewRow.h
//  Pods
//
//  Created by materik on 29/02/16.
//
//

#import <UIKit/UIKit.h>

@class TableViewCell, TableViewDataSource, TableViewSection;

@interface TableViewRow <ObjectType> : UIViewController

@property(nonatomic, strong) ObjectType object;
@property(nonatomic, assign) NSUInteger index;
@property(nonatomic, readonly) Class cellClass;

- (instancetype)initWithObject:(ObjectType)object;

- (void)willDisplayCell:(TableViewCell *)cell
              inSection:(TableViewSection *)section
           inDataSource:(TableViewDataSource *)dataSource;
- (void)didEndDisplayingCell:(TableViewCell *)cell
                   inSection:(TableViewSection *)section
                inDataSource:(TableViewDataSource *)dataSource;
- (void)didSelectInSection:(TableViewSection *)section inDataSource:(TableViewDataSource *)dataSource;
- (void)reloadInSection:(TableViewSection *)section
           inDataSource:(TableViewDataSource *)dataSource
       withRowAnimation:(UITableViewRowAnimation)animation;

- (CGFloat)heightInSection:(TableViewSection *)section inDataSource:(TableViewDataSource *)dataSource;
- (TableViewCell *)dequeueOrCreateReusableCellInSection:(TableViewSection *)section
                                           inDataSource:(TableViewDataSource *)dataSource;

- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithCoder:(NSCoder *)aDecoder NS_UNAVAILABLE;
- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil NS_UNAVAILABLE;

@end
