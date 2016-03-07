//
//  TableViewDataSource.h
//  Pods
//
//  Created by materik on 26/01/16.
//
//

#import "TableViewRow.h"
#import "TableViewSection.h"

typedef void (^TableViewDataSourceLoadPaginatedDataCompletion)(BOOL hasMore);
typedef void (^TableViewDataSourceLoadDataCompletion)();

@protocol TableViewDataSourceParentViewController <NSObject>
@property(nonatomic, readonly) UITableView *tableView;
@end

@interface TableViewDataSource : NSObject <UITableViewDataSource, UITableViewDelegate>

@property(nonatomic, readonly) UITableView *tableView;
@property(nonatomic, strong) UIViewController<TableViewDataSourceParentViewController> *tableViewController;
@property(nonatomic, assign, getter=isPaginationEnabled) BOOL enablePagination;
@property(nonatomic, assign) NSUInteger paginationLimit;
@property(nonatomic, readonly) NSUInteger numberOfSections;

- (void)resetData;
- (void)reloadData;
- (void)loadDataOnCompletion:(TableViewDataSourceLoadDataCompletion)completion;
- (void)loadPaginatedDataInPage:(NSUInteger)page
                      withLimit:(NSUInteger)limit
                   onCompletion:(TableViewDataSourceLoadPaginatedDataCompletion)completion;

- (TableViewSection *)createSectionAtIndex:(NSUInteger)index;
- (TableViewSection *)getSectionAtIndex:(NSUInteger)index;
- (TableViewRow *)getRowAtIndexPath:(NSIndexPath *)indexPath;

@end
